import 'package:netflix_clone/SearchCubit/SearchResult.dart';

abstract class SearchquerryMainState{}
class SearchquerryInitailState extends SearchquerryMainState{}
class SearchquerryLoadingState extends SearchquerryMainState{}
class SearchquerrySuccessState extends SearchquerryMainState{
  SearchResult searchResult;
  SearchquerrySuccessState({required this.searchResult});
}

class FetchMovieDetailsSuccessState extends SearchquerryMainState
{
  dynamic movie;
  FetchMovieDetailsSuccessState({required this.movie});
}

class SearchquerryErrorState extends SearchquerryMainState{
  String error;
  SearchquerryErrorState({required this.error});
}


