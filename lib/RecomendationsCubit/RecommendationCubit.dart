import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/Mappers/Recommendations.dart';

import 'RecommendationsState.dart';
import 'package:http/http.dart' as http;

class RecommendationCubit extends Cubit<RecommendationsMovieMainState>
{
  RecommendationCubit():super(RecommendationsInitialState());
  
  void fetchRecomendations(String id)async
  {
    try{
      emit(RecommendationsInitialState());
      final response =  await http.get(Uri.parse("https://api.themoviedb.org/3/movie/$id/recommendations?api_key=31fcf3b5a614a733770f7900967f71e8"));
      if(response.statusCode == 200)
        {
          final Map<String,dynamic> data = jsonDecode(response.body);
          final recommendations = Recomendations.fromJson(data);
          emit(RecommendationsSuccessState(recomendationsMovies: recommendations));
        }

      
    }catch(e)
    {
      emit(RecommendationsEroorState(errorMsg: e.toString()));
    }
    
  }


}