import 'package:netflix_clone/MovieMapper.dart';
import 'package:netflix_clone/Screeens/UpCommingMovie.dart';

import '../Mappers/UpcommingMappers.dart';

abstract class FetchDataMainStats{}
class FetchNowPlayingInitialState extends FetchDataMainStats{}
class FetchNowPlayingLoadingState extends FetchDataMainStats{}
class FetchNowPlayingSuccessState extends FetchDataMainStats{
  final Movie movie;
  FetchNowPlayingSuccessState({required this.movie});
}

class FetchNowPlayingErrorState extends FetchDataMainStats{
  final error;
  FetchNowPlayingErrorState({required this.error});
}

