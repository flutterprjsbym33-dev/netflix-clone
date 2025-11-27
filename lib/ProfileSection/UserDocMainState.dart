import 'package:netflix_clone/friendrequestProcess/FreindRequestServices.dart';

abstract class UserDocMainState{}
class FetchDocumentInitailState extends UserDocMainState{}
class FetchDocumentLoadingState extends UserDocMainState{}
class FetchDocumentSuccessState extends UserDocMainState{
  UserDoc userDoc;
  FetchDocumentSuccessState({required this.userDoc});

}

class FetchDocumentErrorState extends UserDocMainState{
  String error;
  FetchDocumentErrorState({required this.error});

}
