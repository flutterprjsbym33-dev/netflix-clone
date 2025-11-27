import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/ProfileSection/UserDocMainState.dart';
import 'package:netflix_clone/main.dart';

import '../friendrequestProcess/FreindRequestServices.dart';

class ProfileSectionCubit extends Cubit<UserDocMainState>
{
  ProfileSectionCubit():super(FetchDocumentInitailState());


 void fetchUserData()async
  {
    emit(FetchDocumentLoadingState());
    final datas =await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    final data = datas.data() as Map<String,dynamic>;
    final image = data['photoUrl'];
    final name = data['fullname'];
    userName = name;
    print("->>>>>>>>>>>>>>>$image");
    userImage = image;
    final user = UserDoc.fromJson(data);

    emit(FetchDocumentSuccessState(userDoc: user));

  }

}