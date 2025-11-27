import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix_clone/ChatApp/messageService/MessageService.dart';
import 'package:netflix_clone/auth_block_screens/AuthServices.dart';
import 'package:zego_zim/zego_zim.dart';

import '../../main.dart';


class ChatScreen extends StatefulWidget {

  String id;
  String name;
  String image;

  ChatScreen({
    required this.name,
    required this.id,
    required this.image,

});

  @override
  State<StatefulWidget> createState() {
   return _ChatScreen();
  }

}

class _ChatScreen extends State<ChatScreen>{


  Future<void> loadOldMessages(String peerId) async {
    final config = ZIMMessageQueryConfig();
    config.count = 50; // how many to fetch
    config.reverse = true;

    final result = await ZIM.getInstance()!.queryHistoryMessage(
      peerId,
      ZIMConversationType.peer,
      config,
    );

    setState(() {
      messages = result.messageList.map((m) => m as ZIMTextMessage).toList();
    });
  }

  List<ZIMTextMessage> messages = [];

  TextEditingController message = TextEditingController();


  void init()async{
    await ZIM.getInstance()!.login(authServices.value.currentUser!.uid, ZIMLoginConfig(
      userName: userName,

    ));
  }

  @override
  void initState() {
    print(">>>>>>>>>>>>>>>>>>${widget.id}");
    // TODO: implement initState
    super.initState();
    listner();
    init();
    loadOldMessages("068m0VRv8lQ7T4tFCmKN8bRTdVQ2");
  }


  void listner()
  {
    ZIMEventHandler.onReceivePeerMessage = (zim, messageList, fromUserID) {
      setState(() {
        messages.addAll(messageList.map((i)=>i as ZIMTextMessage));
      });
    };
  }




  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children: [
                CircleAvatar(
                  radius: height*0.03,
                  backgroundImage: NetworkImage(widget.image),
                ),

                SizedBox(width: 10.h,),
                Text(widget.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
              ],
            ),
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.video_camera_front,color: Colors.blue,)),
                SizedBox(width: 2.w,),
                IconButton(onPressed: (){}, icon: Icon(Icons.call,color: Colors.blue,)),
                SizedBox(width: 2.w,),
                IconButton(onPressed: (){}, icon: Icon(Icons.info,color: Colors.blue,)),

              ],
            )
          ],
        )

      ),
      bottomSheet: SafeArea(
        child: Container(
          color: Colors.white,
          height: height*0.12,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.upload,color: Colors.black87,),
              SizedBox(width: 10.w,),
              Icon(Icons.camera_alt_rounded,color: Colors.black87,),
              SizedBox(width: 12.w,),
              Icon(Icons.camera,color: Colors.black87,),
              SizedBox(width: 11.w,),
              Icon(Icons.mic,color: Colors.black87,),
              SizedBox(width: 6.w,),
              Expanded(
                child: TextField(
                  controller: message,
                  decoration: InputDecoration(
                    hintText: "Message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
        
                    )
                  ),
                ),
              ),
              SizedBox(width: 4.w,),
              IconButton(onPressed: (){

                messageService.value.sendMessage(message.text, "068m0VRv8lQ7T4tFCmKN8bRTdVQ2");
                setState(() {
                  messages.add(ZIMTextMessage(message: message.text,));
                });


                

              },icon: Icon(Icons.send,color: Colors.blue,),)
            ],
        
          ),
        ),
      ),
      body:ListView.builder(
        itemCount: messages.length,
          itemBuilder: (context,index){
          final msg = messages[index];
          return Align(
            alignment: msg.senderUserID == authServices.value.currentUser!.uid ? Alignment.centerRight :
            Alignment.centerLeft,
                child:
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: msg.senderUserID == authServices.value.currentUser!.uid ? Colors.blue :
                        Colors.grey.shade300,
                  ),
                  child: Text(msg.message,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),


          ),


          );
          }
      )
    );
  }

}