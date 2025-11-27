import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/ChatApp/ChatAppHomeScreen.dart';
import 'package:netflix_clone/Screeens/HomeScreenAppBar.dart';
import 'package:netflix_clone/Screeens/HomeScreenPageview.dart';
import 'package:netflix_clone/Screeens/SearchScreen.dart';
import 'package:netflix_clone/apiservice/Api%20Cubit.dart';
import 'package:netflix_clone/auth_block_screens/AuthServices.dart';
import 'package:netflix_clone/auth_block_screens/SignUpScreen.dart';

import '../BlocCubit/BottomNavigationIndex.dart';
import 'PouplarSection.dart';
import 'UpCommingMovie.dart';

class Homescreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Homescreen();
  }

}

class _Homescreen extends State<Homescreen>{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchNowPlaying>().fetchNowPlaying();
    context.read<FetchNowPlaying>().fetchNowPlaying();
  }


  List<String> bottomBarImages = [
    "assets/images/btn_1.png",
    "assets/images/search.png",
    "assets/images/btn3.png",

  ];

  List<String> bottomBarNames = [
    "Explore",
    "Search",
    "More"

  ];

  List<String> categories = [
    "Tv Shows",
    "Movies",
    "Categories"
  ];



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      //---------------------AppBar--------------------------------------------->
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset("assets/images/ntfx.png",height:30.h,)
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StreamBuilder(stream: authServices.value.authStateChange, builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting)
                        {
                          return Center(child: CircularProgressIndicator(),);
                        }
                      if(snapshot.hasData)
                        {
                         return ChatAppHomeScreen();
                        }
                      else{
                        return SignUpScreen();
                      }
                    })));
                  },
                    child: Image.asset("assets/images/search2.png",height:  30.h,color: Colors.white,)),

                IconButton(onPressed: (){}, icon: Icon(Icons.download, size:  30.h,)),
                IconButton(onPressed: (){}, icon: Icon(Icons.cast,size:  30.h,)),

              ],
            )

          ],
        ),

      ),
      //---------------------BottomBar--------------------------------------------->
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: height*0.1,
          width: double.infinity,

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bottomBarImages.length, (index){
                final isSelected = context.watch<BottomNavigationIndex>().state;
                return GestureDetector(
                  onTap: (){
                    context.read<BottomNavigationIndex>().addIndex(index);
                    actionOnBottomOnTap(context, index);


                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Image.asset(bottomBarImages[index],height: 35.h,color: index == isSelected ?  null :Colors.grey.shade600,),
                      Text(bottomBarNames[index],style: TextStyle(color:  index == isSelected ?  null :Colors.grey.shade700),)

                    ],
                  ),
                );
              }),
            ),
          ),
      ),
      //---------------------MainBody--------------------------------------------->
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                height: height*0.05,
        
                child: Row(
        
                  children: List.generate(categories.length, (index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Chip(
        
                          label: Text(categories[index])),
                    );
                  }),
                ),
              ),
              SizedBox(height: height*0.01,),
                 Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                  child:  HomeScreenPageView()),
              SizedBox(height: 5.h,),
              Text("Upcoming Movies",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.h,),
              UpCommingMovie(),
              SizedBox(height: 5,),
              Text("Popular Movies",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.h,),
              Pouplarsection()


        
        
            ],
          ),
        ),
      ),



    );
  }
}


void actionOnBottomOnTap(BuildContext context,int index)
{
  switch(index)
      {
    case 1:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
    context.read<BottomNavigationIndex>().addIndex(0);

      break;
  }

}


