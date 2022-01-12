import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web/api/general_api.dart';
import 'package:web/models/player_model.dart';

class ChatStream{
  final String token;
  final Function isNav;
  ChatStream(this.token, this.isNav);
  final GeneralApi _api = GeneralApi();
  List<Chat> chat = [];
  final PublishSubject<List<Chat>> chatStreamFetcher = new PublishSubject<List<Chat>>();
  Stream<List<Chat>> get chatStream => chatStreamFetcher.stream;

  void addToStream(){
    chatStreamFetcher.sink.add(chat);
  }
  void getMessage(Chat message){
      chat.insert(0, message);
      addToStream();
  }
  Future<bool> sendMessage(String message) async{
    RegExp exp = RegExp(r'[a-zA-Zа-яА-Я0-9!@#\$&*~-]');
    if(message==null || message=='' || !message.contains(exp))
      {
        print('message is null');
        return false;
      }
    else{
      Map<String, dynamic> data = {'message':'$message'};
      var res = await _api.post('chat', token, data);
      return res['success'];
    }

    //doDebug('send message', res.toString());
   // print(res.toString());
    //print(res['success']);
    //print('////////////');

  }
  void dispose(){
    chatStreamFetcher.close();
  }
}
//final ChatStream teamPosition = ChatStream();