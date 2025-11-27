import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/Screeens/UpCommingMovie.dart';
import 'package:netflix_clone/apiservice/APIConstants.dart';
import 'package:http/http.dart' as http;


import '../../Mappers/UpcommingMappers.dart';
import '../FetchDataMainStaets.dart';
import '../UpcomingMainState.dart';


class FetchUpComing extends Cubit<UpcomingMovieMainState>
{
  FetchUpComing():super(FetchUpcomingInitialState());


  void fetchUpcoming()async
  {
    try{
      emit(FetchUpcomingLoadingState());
      final response = await  http.get(Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=31fcf3b5a614a733770f7900967f71e8"));
      if(response.statusCode == 200)
      {
        final Map<String,dynamic> data = jsonDecode(response.body);
        final movie = UpComingMovies.fromJson(data);
        emit(FetchUpcomingSuccessState( movie: movie
        ));
        print(movie.results![0].posterPath);
        print("Successfull");
      }


    }catch(e)
    {
      emit(FetchUpcomingErrorState(error: e.toString()));

    }

  }

}