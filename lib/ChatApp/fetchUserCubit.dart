import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/ChatApp/FetchUserMainState.dart';
import 'package:netflix_clone/auth_block_screens/AuthServices.dart';

import 'ChatAppMapper/FetchedUsers.dart';

class FetchUsersCubit extends Cubit<FetchUserMainState>
{
  FetchUsersCubit():super(FetchUserInitialState());

  void fetchUsers()async
  {
    try{
      emit(FetchUserLoadingState());
      final response = await FirebaseFirestore.instance.collection("users").get();
      final data =   response.docs ;
     final datas =  data.where((i)=>i.data()['id']!=authServices.value.currentUser!.uid).toList();
      final users = datas.map((i)=>Fetchedusers.fromJson(i.data())).toList();
      print(users.first.photoUrl);
      emit(FetchUserSuccessState(users: users));
      print("emitted Success state");

    }catch(e){emit(FetchUserErrorState(errorMsg: e.toString()));}


  }
}