import '../Mappers/Recommendations.dart';

abstract class RecommendationsMovieMainState {}
class RecommendationsInitialState extends RecommendationsMovieMainState{}
class RecommendationsLoadingState extends RecommendationsMovieMainState{}
class RecommendationsSuccessState extends RecommendationsMovieMainState{
  Recomendations recomendationsMovies;
  RecommendationsSuccessState({required this.recomendationsMovies});

}

class RecommendationsEroorState extends RecommendationsMovieMainState{
  String errorMsg;
  RecommendationsEroorState({required this.errorMsg});

}