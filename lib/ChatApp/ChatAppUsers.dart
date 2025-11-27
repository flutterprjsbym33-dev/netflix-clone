import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix_clone/ChatApp/FetchUserMainState.dart';
import 'package:netflix_clone/ChatApp/fetchUserCubit.dart';
import 'package:netflix_clone/friendrequestProcess/FreindRequestServices.dart';

class ChatAppUsers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatAppUsers();
  }

}

class _ChatAppUsers extends State<ChatAppUsers> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Availiable users',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400,color: Colors.black),),
      ),
      body: SafeArea(child:SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<FetchUsersCubit,FetchUserMainState>(
                builder: (context,state){
                  if(state is FetchUserLoadingState)
                    {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  if(state is FetchUserSuccessState)
                    {
                     return Expanded(
                       child: ListView.builder(
                         scrollDirection: Axis.vertical,
                           itemCount: state.users.length,
                           itemBuilder: (context,index){
                         final item = state.users[index].photoUrl;
                         return SizedBox(
                           height: height*0.12,
                           child: Padding(
                             padding: const EdgeInsets.only(bottom: 15.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   children: [
                                     SizedBox(height: height*0.1,
                                       width: 75.w,
                                       child: ClipRRect(
                                         borderRadius: BorderRadius.circular(20),
                                         child: Image.network(item,fit: BoxFit.cover,),),
                                     ),
                                     SizedBox(width: 12.w,),
                                     Text('${state.users[index].fullname}',style: TextStyle(fontSize: 16,color: Colors.black,fontWeight:FontWeight.w600,overflow: TextOverflow.ellipsis),)
                                   ],
                                 ),
                                 Card(
                                   color: Colors.blueAccent,
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child:
                                         StreamBuilder(
                                           stream: friendRequestServices.value.getUpdate(state.users[index].id, FirebaseAuth.instance.currentUser!.uid),
                                           builder: (context, asyncSnapshot) {
                                              if(!asyncSnapshot.hasData || !asyncSnapshot.data!.exists)
                                             {
                                               return
                                                 GestureDetector(
                                                   onTap: (){
                                                     friendRequestServices.value.addFriend( state.users[index].id,  FirebaseAuth.instance.currentUser!.uid,state.users[index].fullname, state.users[index].photoUrl);
                                                   },
                                                   child: Row(
                                                     children: [
                                                       Image.asset('assets/images/ad.png',height: 20.h,color: Colors.white,),
                                                       Text("Add Friend",style: TextStyle(color: Colors.white),),

                                                     ],
                                                   ),
                                                 );
                                             }

                                              final data = asyncSnapshot.data!.data() as Map<String,dynamic>;
                                              final status = data['status'];
                                              if(status == "Pending")
                                                {
                                                  return Icon(Icons.pending);
                                                }
                                              if(status == "Accepted")
                                                {
                                                  return Icon(Icons.chat);
                                                }
                                              else{
                                                return GestureDetector(
                                                  onTap: (){
                                                    friendRequestServices.value.addFriend( state.users[index].id,  FirebaseAuth.instance.currentUser!.uid,state.users[index].fullname, state.users[index].photoUrl);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Image.asset('assets/images/ad.png',height: 20.h,color: Colors.white,),
                                                      Text("Add Friend",style: TextStyle(color: Colors.white),),

                                                    ],
                                                  ),
                                                );
                                              }
                                           }
                                         )

                                     ),
                                   ),

                             ])
                           ),
                         );
                           }),
                     );
                    }
                  else{
                    return SizedBox();
                  }
                })
          ],
        ),
      ))),
    );
  }
}