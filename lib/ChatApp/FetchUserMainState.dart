import 'package:netflix_clone/ChatApp/ChatAppMapper/FetchedUsers.dart';

abstract class FetchUserMainState {}
class FetchUserInitialState extends FetchUserMainState{}
class FetchUserLoadingState extends FetchUserMainState{}
class FetchUserSuccessState extends FetchUserMainState{
  List<Fetchedusers> users;
  FetchUserSuccessState({required this.users});

}
class FetchUserErrorState extends FetchUserMainState{
  String errorMsg;
  FetchUserErrorState({required this.errorMsg});

}