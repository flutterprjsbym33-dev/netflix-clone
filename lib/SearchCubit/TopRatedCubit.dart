import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/SearchCubit/TopRatedMainState.dart';

import 'TopReatedMovies.dart';

class TopRatedCubit extends Cubit<TopRatedMainState>
{
  TopRatedCubit():super(TopRatedInitialState());

  void fetchTopMovies() async
  {
    try{
      emit(TopRatedLoadingState());
      final response = await  http.get(Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=31fcf3b5a614a733770f7900967f71e8"));
      if(response.statusCode == 200)
      {
        final Map<String,dynamic> data = jsonDecode(response.body);
        final movie = Topreatedmovies.fromJson(data);
        emit(TopRatedSuccessState( topreatedmovies: movie
        ));
        print(movie.results![0].posterPath);
        print("Successfull");
      }

    }catch(e)
    {
      emit(TopRatedErrorState(error: e.toString()));
    }
  }
}