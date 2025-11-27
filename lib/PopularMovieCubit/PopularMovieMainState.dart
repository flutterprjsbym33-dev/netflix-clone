import 'package:netflix_clone/Mappers/Popular.dart';

abstract class PopularMovieMainState{}
class FetchPoPopularInitialState extends PopularMovieMainState{}
class FFetchPoPopularLoadingState extends PopularMovieMainState{}
class FetchPoPopularSuccessState extends PopularMovieMainState{
  final PopularMovies movie;
  FetchPoPopularSuccessState({required this.movie});
}

class FetchPoPopularErrorState extends PopularMovieMainState{
  final error;
  FetchPoPopularErrorState({required this.error});
}
