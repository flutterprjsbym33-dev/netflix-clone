import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:netflix_clone/auth_block_screens/AuthServices.dart';
import 'package:netflix_clone/main.dart';

ValueNotifier<FriendRequestServices> friendRequestServices = ValueNotifier(FriendRequestServices());

class FriendRequestServices{


  void confirmRequest(String sender, String senderImage,String senderName, String reciverName,String reciverImage)async
  {
    await FirebaseFirestore.instance.collection('users').doc(authServices.value
        .currentUser!.uid).collection('friendRequest').doc(sender).update({
      "status":"Accepted"

    });
    await FirebaseFirestore.instance.collection('users').doc(authServices.value.currentUser!.uid).collection('myFriends').doc(sender)
        .set({
      "id":sender,
      "image":senderImage,
      "name":senderName,
      "status":"Accepted",
      "time":FieldValue.serverTimestamp()
    });

    //Sender
    await FirebaseFirestore.instance.collection('users').doc(sender).collection('myFriends').doc(authServices.value.currentUser!.uid)
        .set({
      "id":authServices.value.currentUser!.uid,
      "image":reciverImage,
      "name":reciverName,
      "status":"Accepted",
      "time":FieldValue.serverTimestamp()
    });


    //Reciver

    
  }


  void addFriend(String receiverId,String senderId,String name,String photo)async
  {
    await FirebaseFirestore.instance.collection("users")
        .doc(receiverId).collection("friendRequest").doc(senderId).set({
      'id':senderId,
      "photo":userImage,
      "status":"Pending",
      "name":userName,
      "time":FieldValue.serverTimestamp()
    });
  }

  Stream<DocumentSnapshot> getUpdate(String receiverId,String senderId)
  {
    return FirebaseFirestore.instance.collection("users").
    doc(receiverId).collection('friendRequest').doc(senderId).snapshots();

  }


  Stream<QuerySnapshot> friendRequest()
  {
    final reciver = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection("users").
    doc(reciver).collection('friendRequest').snapshots();
  }



  Future<UserDoc> fetchUserData()async
  {
      final datas =await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      final data = datas.data() as Map<String,dynamic>;
      return UserDoc.fromJson(data);

  }


  Stream<QuerySnapshot> fetchUser()
  {
    return FirebaseFirestore.instance.collection("users").doc(authServices.value.currentUser!.uid).collection("myFriends").snapshots();
  }









}


class UserDoc{
  String name;
  String photoUrl;
  String email;

  UserDoc({required this.name,
    required this.email,
  required this.photoUrl});

 factory UserDoc.fromJson(Map<String,dynamic> user)
 {
   return UserDoc(name: user['fullname'], photoUrl: user['photoUrl'],email: user['email']);
 }
}