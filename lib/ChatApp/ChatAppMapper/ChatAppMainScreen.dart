import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix_clone/ChatApp/ChatAppMapper/ChatScreen.dart';
import 'package:netflix_clone/friendrequestProcess/FreindRequestServices.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:zego_zim/zego_zim.dart';
class ChatAppMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("We Chat",style: TextStyle(color: Colors.black),),
      ),
      body: SafeArea(child: StreamBuilder(stream: friendRequestServices.value.fetchUser(), builder: (context,snapshot){
        if(!snapshot.hasData || snapshot.data!.docs.isEmpty)
          {
            return Center(child: Text("No Friend Yet",style: TextStyle(color: Colors.black,fontSize: 25),));
          }
        if(snapshot.hasData)
          {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                  final image = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                  final url = image['image'];
                  final name = image['name'];
                  final id = image['id'];

                  return SizedBox(
                    width: double.infinity,
                    height: height*0.12,
                    child:
                     InkWell(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Theme(
                           data: ThemeData.light().copyWith(
                             scaffoldBackgroundColor: Colors.white,
                           ),
                           child: ZIMKitMessageListPage(
                             conversationID: id,
                             conversationType: ZIMConversationType.peer,
                           ),
                         ),
                         ),);

                       },
                       child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: height*0.04,
                                  backgroundImage: NetworkImage(url),
                                ),
                                SizedBox(width: 12.w,),
                                Column(
                                  children: [
                                    Text(name,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),),
                                    Text("Tap to chat",style: TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w200),),
                                  ],
                                )
                              ],
                            ),
                          ),
                     ),
                      );

                  }),
            );

          }
        else{
          return Center(child: Text("No Friend Yet",style: TextStyle(color: Colors.black,fontSize: 25),));
        }
      })),
    );
  }

}

void onChatTap(String name,String id,String image,BuildContext context)
{
  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(name: name, id: id, image: image)));

}