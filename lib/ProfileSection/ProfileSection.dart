import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix_clone/auth_block_screens/AuthenticationMainBloc.dart';
import 'package:netflix_clone/friendrequestProcess/FreindRequestServices.dart';
import 'package:netflix_clone/main.dart';

import '../auth_block_screens/AuthenticationEvents.dart';
import '../auth_block_screens/AuthenticationMainState.dart';
import 'ProfileSectionBloc.dart';
import 'UserDocMainState.dart';

class ProfileSection extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ProfileSection();
  }

}

class _ProfileSection extends State<ProfileSection>{




  @override
  initState()  {
    // TODO: implement initState
    super.initState();
    context.read<ProfileSectionCubit>().fetchUserData();


  }

  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Profile",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
      ),
      backgroundColor: Colors.white,
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h,),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children:[ BlocBuilder<ProfileSectionCubit,UserDocMainState>(
                    builder: (context,state){
                      if(state is FetchDocumentLoadingState)
                        {
                          return SizedBox(
                            height: height*0.05,width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }
                      if (state is FetchDocumentSuccessState) {
                        return Column(
                          children: [
                            SizedBox(
                              height: height * 0.2,
                              width: height*0.2,
                              child:
                              Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: height*0.1,
                                          backgroundImage: NetworkImage(state.userDoc.photoUrl),

                                        ),
                                      ),

                                      // ✅ Positioned plus icon (bottom-right corner)
                                      Positioned(
                                        bottom: 2,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                            SizedBox(height: 5.h),
                            Text(
                              state.userDoc.name,
                              style:  TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              state.userDoc.email,
                              style:  TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200
                              ),
                            ),
                            SizedBox(height: 5.h),
                           Text('Joined Sep 18,2025',style: TextStyle(fontSize: 16,color: Colors.grey),),
                            BlocBuilder<AuthenticationMainBloc,AuthenticationMainState>(
                               builder: (context,state) {
                                 if(state is onLogoutPressedLoadingState)
                                   {
                                     return SizedBox(
                                       height: height*0.07,
                                       width: 200.w,
                                       child: Card(
                                         color: Colors.blue,
                                         child: CircularProgressIndicator()
                                       ),
                                     );
                                   }
                                 else {
                                   return  GestureDetector(
                                     onTap: (){
                                       context.read<AuthenticationMainBloc>().add(onLogoutPressed());
                                     },
                                     child: SizedBox(
                                       height: height*0.07,
                                       width: 200.w,
                                       child: Card(
                                         color: Colors.blue,
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                             Icon(Icons.exit_to_app),
                                             Text("LogOut",style: TextStyle(color: Colors.white,fontSize: 18),)
                                           ],
                                         ),
                                       ),
                                     ),
                                   );
                                 }
                               }
                             ),

                            SizedBox(height: 15.h,),


                          ],
                        );
                      }

                      else{
                        return  SizedBox(
                          height: height*0.06,width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network("https://media.assettype.com/deccanherald%2F2024-07%2F08e63f78-4cdd-4ae7-a600-9ed41acbbdce%2FT20_World_Cup_Winning_Images__7_.JPG?w=undefined&auto=format%2Ccompress&fit=max"),
                          ),
                        );
                      }
                    }),
              ])
            ),
            Text("Friend Requests :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),),
            SizedBox(height: 10.h,),

            StreamBuilder(stream: friendRequestServices.value.friendRequest(),
                builder: (context,asyncSnapshot){
                  final datas = asyncSnapshot.data!.docs.map((i)=>i.data() as Map<String,dynamic>).toList();
              if(!asyncSnapshot.hasData || asyncSnapshot.data!.docs.isEmpty)
                {
                  return Text("No Friend Request Yet",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),);

                }




                  print("................$datas");
                  return 
                     Expanded(
                       child: ListView.builder(
                        itemCount: datas.length,
                          itemBuilder: (context,index){
                          return SizedBox(
                            height: height*0.1,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: height*0.045,
                                      backgroundImage: NetworkImage(datas[index]['photo'],scale: height*0.15),
                                    ),
                                    SizedBox(width: 15.w,),
                                    Text(datas[index]['name'],style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),)
                                  ],
                                ),
                                datas[index]['status']=="Accepted" ? Text("Accepted", style:  TextStyle(color: Colors.black),) :
                                Row(children: [
                                  GestureDetector(
                                    onTap: (){
                                      final id = datas[index]["id"];
                                      friendRequestServices.value..confirmRequest(id, datas[index]['photo'], datas[index]['name'], userName, userImage);


                                    },
                                    child: Card(
                                        color: Colors.blueAccent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text("Accept",style: TextStyle(color: Colors.white,fontSize: 14,),),
                                        )
                                    ),
                                  ),
                                  SizedBox(width: 2.w,),
                                  Card(
                                      color: Colors.blueAccent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text("Decline",style: TextStyle(color: Colors.white,fontSize: 14),),
                                      )
                                  ),


                                ],)

                                
                              ],
                            ),
                          );
                       
                          }),
                     );
                  




            })
          ],

        ),
      ));
  }

}


