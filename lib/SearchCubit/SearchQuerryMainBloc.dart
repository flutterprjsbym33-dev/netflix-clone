import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/SearchCubit/SearchQuerryMainEvents.dart';
import 'package:netflix_clone/SearchCubit/SearchResult.dart';
import 'package:netflix_clone/SearchCubit/SearchquerryMainState.dart';
import 'package:http/http.dart' as http;

class SearchQuerryMainBlock extends Bloc<SearchQuerryMainEvents,SearchquerryMainState>
{
  SearchQuerryMainBlock():super(SearchquerryInitailState()){
    on(onSearch);
    on(onCancelation);

  }


  void onSearch(OnSerachPressed event,Emitter<SearchquerryMainState> emit)async
  {
    try{
      emit(SearchquerryLoadingState());
      final response = await http.get(Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=31fcf3b5a614a733770f7900967f71e8&query=${event.querry}"));
      if(response.statusCode == 200)
        {
          final Map<String,dynamic> data = jsonDecode(response.body);
          final searchResult  = SearchResult.fromJson(data);
          emit(SearchquerrySuccessState(searchResult: searchResult));


        }
      
    }catch(e)
    {
      emit(SearchquerryErrorState(error: e.toString()));
    }


  }

  void onCancelation(onSearchCancel event,Emitter<SearchquerryMainState> emit)
  {
    emit(SearchquerryInitailState());
  }

}