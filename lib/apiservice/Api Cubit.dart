import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/apiservice/APIConstants.dart';
import 'package:http/http.dart' as http;


import '../MovieMapper.dart';
import 'FetchDataMainStaets.dart';

class FetchNowPlaying extends Cubit<FetchDataMainStats>
{
  FetchNowPlaying():super(FetchNowPlayingInitialState());





  void fetchNowPlaying()async
  {
    try{
      emit(FetchNowPlayingLoadingState());
     final response = await  http.get(Uri.parse(uri));
     if(response.statusCode == 200)
       {
         final Map<String,dynamic> data = jsonDecode(response.body);
         final movie = Movie.fromJson(data);
         emit(FetchNowPlayingSuccessState( movie: movie
         ));
         print(movie.results![0].posterPath);
         print("Successfull");
       }


    }catch(e)
    {
      emit(FetchNowPlayingErrorState(error: e.toString()));

    }

  }




}