abstract class SearchQuerryMainEvents{}
class OnSerachPressed extends SearchQuerryMainEvents{
  String querry;
  OnSerachPressed({required this.querry});
}

class FetchMovieDetails extends SearchQuerryMainEvents{
  String movieName;
  FetchMovieDetails({required this.movieName});
}

class FetchMovieDetailsSuccess extends SearchQuerryMainEvents{
  dynamic movieName;
  FetchMovieDetailsSuccess({required this.movieName});
}

class OnSearchError{
  String errorMsg;
  OnSearchError({required this.errorMsg});
}


class onSearchCancel extends SearchQuerryMainEvents{
}


