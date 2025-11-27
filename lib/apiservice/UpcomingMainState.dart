import 'package:netflix_clone/Screeens/UpCommingMovie.dart';

import '../Mappers/UpcommingMappers.dart';

abstract class UpcomingMovieMainState{}

class FetchUpcomingInitialState extends UpcomingMovieMainState{}
class FetchUpcomingLoadingState extends UpcomingMovieMainState{}
class FetchUpcomingSuccessState extends UpcomingMovieMainState{
  final UpComingMovies movie;
  FetchUpcomingSuccessState({required this.movie});
}

class FetchUpcomingErrorState extends UpcomingMovieMainState{
  final error;
  FetchUpcomingErrorState({required this.error});
}

