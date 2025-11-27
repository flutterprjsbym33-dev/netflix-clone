import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/Mappers/Popular.dart';

import 'PopularMovieMainState.dart';

class PoularMovieCubit extends Cubit<PopularMovieMainState>
{
  PoularMovieCubit():super(FetchPoPopularInitialState());


  void fetchUpcoming()async
  {
    try{
      emit(FFetchPoPopularLoadingState());
      final response = await  http.get(Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=31fcf3b5a614a733770f7900967f71e8"));
      if(response.statusCode == 200)
      {
        final Map<String,dynamic> data = jsonDecode(response.body);
        final movie = PopularMovies.fromJson(data);
        emit(FetchPoPopularSuccessState( movie: movie
        ));
        print(movie.results![0].posterPath);
        print("Successfull");
      }


    }catch(e)
    {
      emit(FetchPoPopularErrorState(error: e.toString()));

    }

  }
}