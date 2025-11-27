import 'package:flutter/cupertino.dart';
import 'package:zego_zim/zego_zim.dart';

ValueNotifier<MessageService> messageService = ValueNotifier(MessageService());

class MessageService
{
  void sendMessage(String message, String receiver)
  {
    final messageObj = ZIMTextMessage(message: message);
    ZIM.getInstance()!.
    sendMessage(
        messageObj,
        receiver,
        ZIMConversationType.peer,
        ZIMMessageSendConfig());
  }

}