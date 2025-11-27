import 'package:netflix_clone/SearchCubit/TopReatedMovies.dart';

abstract class TopRatedMainState{}
class TopRatedInitialState extends TopRatedMainState{}
class TopRatedLoadingState extends TopRatedMainState{}

class TopRatedSuccessState extends TopRatedMainState {
  Topreatedmovies topreatedmovies;
  TopRatedSuccessState({required this.topreatedmovies});


}

class TopRatedErrorState extends TopRatedMainState{
  String error;
  TopRatedErrorState({required this.error});

}




