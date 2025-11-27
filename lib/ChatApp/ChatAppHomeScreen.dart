import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix_clone/ChatApp/ChatAppUsers.dart';
import 'package:netflix_clone/ChatApp/fetchUserCubit.dart';
import 'package:netflix_clone/auth_block_screens/AuthServices.dart';
import 'package:netflix_clone/main.dart';

import '../ProfileSection/ProfileSectionBloc.dart';
import 'ChatAppMapper/ChatAppMainScreen.dart';
import '../ProfileSection/ProfileSection.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatAppHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatAppHomeScreen();
  }

}

class _ChatAppHomeScreen extends State<ChatAppHomeScreen>{
  int selectedIndex = 0;


void init()async{
  await ZIMKit().connectUser(id: authServices.value.currentUser!.uid, name: userName);
  await ZIMKit().updateUserInfo(
    name: userName,
    avatarUrl: userImage, // optional if you have avatar in Firebase
  );
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchUsersCubit>().fetchUsers();
    context.read<ProfileSectionCubit>().fetchUserData();
    init();
  }

  List<IconData> bottomicons = [
    Icons.chat,
    Icons.supervised_user_circle_sharp,
    Icons.account_circle
  ];
  List<String> bottomiconsNames = [
    "Chat",
    "Users",
    "Profile"
  ];
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: bootmNaigator(context, selectedIndex),

      bottomNavigationBar: Container(
            height: 85.h,

            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(bottomicons.length, (index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 8),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedIndex = index;
                        });

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(bottomicons[index],color: Colors.black,),
                          Text(bottomiconsNames[index],style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ),
                  );
              
              
              
              
                }),
              ),
            ),
          )


    );
  }

}

Widget bootmNaigator(BuildContext context,int index)
{
  switch(index)
      {
    case 0: return ChatAppMainScreen() ;break;
    case 1:return ChatAppUsers();
    case 2: return ProfileSection(); break;

      }
      return ChatAppHomeScreen();
}