import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/Screeens/HomeScreen.dart';
import 'package:netflix_clone/auth_block_screens/SignUpScreen.dart';

import '../apiservice/Api Cubit.dart';
import '../apiservice/UpCommingMovies/UpCommingCubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }

}

class _SplashScreen extends State<SplashScreen>{

  @override
  void initState() {
    context.read<FetchNowPlaying>().fetchNowPlaying();
    context.read<FetchUpComing>().fetchUpcoming();
    Timer(Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homescreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body: Center(
     child: Lottie.asset('assets/net.json'),
   ),
    );
  }
}