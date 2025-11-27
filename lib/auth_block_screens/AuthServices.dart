import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:netflix_clone/main.dart';
import 'package:zego_zim/zego_zim.dart';

ValueNotifier<AuthServices> authServices = ValueNotifier(AuthServices());

class AuthServices{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn.instance;
  bool isInitialized = false;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();






  Future<void> initailisze()async
  {
    if(!isInitialized)
    {
      await googleSignIn.initialize(clientId: "508621640385-r6eamr2bhsk5ppptsto02savvtj8uor9.apps.googleusercontent.com");
    }
    isInitialized = true;
  }

  Future<void>  signInWithGoogle()async
  {
    try{

      await initailisze();
      final GoogleSignInAccount googlesign = await googleSignIn.authenticate();
      print(googlesign.photoUrl);
      final idToken = await  googlesign.authentication.idToken;
      final   authorization = await googlesign.authorizationClient;
      final authoriza =await authorization.authorizationForScopes(['email','profile']);
      final accessToken =await authoriza?.accessToken;


      final credential =  await GoogleAuthProvider.credential(
          idToken: idToken,
          accessToken: accessToken
      );

      final userCredt = await firebaseAuth.signInWithCredential(credential);
      await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).set({
        "fullname":userCredt.user!.displayName,
        "email":userCredt.user!.email,
        "password":userCredt.user!.displayName,
        "photoUrl":userCredt.user!.photoURL,
        "id":currentUser!.uid,
      });
      print(userCredt.user!.email);





    }catch(e){
      print("Eroor>>>>>>>>>${e.toString()}");

      return Future.error(e.toString());
    }

  }


  Future<void> signInWithEmail(String fullName, String email, String password)async
  {
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).set({
      "fullname":fullName,
      "email":email,
      "password":password,
      "photoUrl":"https://static.vecteezy.com/system/resources/thumbnails/036/594/092/small_2x/man-empty-avatar-photo-placeholder-for-social-networks-resumes-forums-and-dating-sites-male-and-female-no-photo-images-for-unfilled-user-profile-free-vector.jpg",
      "id":currentUser!.uid,
    });
    await ZIM.getInstance()!.login(authServices.value.currentUser!.uid, ZIMLoginConfig(
      userName: userName,
      
    ));


  }
}