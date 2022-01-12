import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web/bloc/chat_stream.dart';
import 'package:web/models/player_model.dart';

class ReChat extends StatefulWidget {
  final ChatStream chatStream;
  ReChat(this.chatStream);
  @override
  _ReChatState createState() => _ReChatState();
}

class _ReChatState extends State<ReChat> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  bool isChatBusy = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 97,
          child: Column(
            children: [

              Expanded(
                flex: 5,
                  child: FittedBox(
                    clipBehavior: Clip.none,
                    fit: BoxFit.contain,
                    child: Center(
                        child: Text(
                            'чат с командой',
                            style: Theme.of(context).textTheme.subtitle2,
                        )
                    ),
                  )
              ),

              Expanded(
                  flex: 5,
                  child: Container()),

              /// message area ////
              Expanded(
                flex: 80,
                child: buildChat(),
                ),
              /// chat input container ///
              Expanded(
                flex: 12,
                child: Container(
                 // color: Colors.black,
                  child: widget.chatStream.isNav()? restrict() : input(),
                ),
              ),
            ],
          ),
        ),
        /// right padding with scroll buttons ///
        Expanded(
          flex: 3,
          child: Column(
            children: [
              /// scroll buttons ///
              Expanded(flex: 30, child: Container()),
              Expanded(flex: 15, child: Container(
                constraints: BoxConstraints(maxWidth: 15),
                child: InkWell(
                  onTap: (){
                    listScrollController.jumpTo(listScrollController.offset+50);
                  },
                  child: Image.asset('assets/down.png'),
                ),
              )),
              Expanded(flex: 15, child: Container(
                constraints: BoxConstraints(maxWidth: 15),
                child: InkWell(
                  onTap: (){
                    listScrollController.jumpTo(listScrollController.offset-50);
                  },
                  child: Image.asset('assets/up.png'),
                ),
              )),
              Expanded(flex: 20, child: Container())

              /*
              Expanded(
                flex: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 45,
                      child: Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: (){
                              listScrollController.jumpTo(listScrollController.offset+50);
                            },
                            child: Image.asset('assets/up.png'),
                          ),
                        ),
                      ),
                    ),
                   /*
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 10,
                      ),
                    ),
                    */
                    Expanded(
                      flex: 45,
                      child: Container(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: InkWell(
                            onTap: (){
                              listScrollController.jumpTo(listScrollController.offset-50);
                            },
                            child: Image.asset('assets/down.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

               */

              /// padding for right center ///
              //Expanded(
               // flex: 10, // 20
               // child: Container(),
              //),
            ],
          ),
        ),
      ],
    );
  }
  Widget buildChat(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: StreamBuilder<List<Chat>>(
        stream: widget.chatStream.chatStream,
        //initialData: [Chat.fromJson(jsonDecode('{"sender":"Grin","team_id":1,"message":"some text hdfgjkdg dfgkdrgh dhgk djgd gfdhgdkf gbskjghskjghhgjsgh sdiogsigs"}')),Chat.fromJson(jsonDecode('{"sender":"Grin","team_id":1,"message":"some text"}')),Chat.fromJson(jsonDecode('{"sender":"Grin","team_id":1,"message":"some text"}')),Chat.fromJson(jsonDecode('{"sender":"Grin","team_id":1,"message":"some text"}')),Chat.fromJson(jsonDecode('{"sender":"Grin","team_id":1,"message":"some text"}')),Chat.fromJson(jsonDecode('{"sender":"Grin","team_id":1,"message":"some text"}'))],
        initialData: [],
        builder: (context, snapshot){
          return ListView.builder(
            itemCount: snapshot.data.length,
            reverse: true,
            controller: listScrollController,
            itemBuilder: (context, int index){
              return chatItem(snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
  Widget chatItem(Chat message){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 30.0, top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(child: messageBody(message.message, message.sender)),
        ],
      ),
    );
  }
  Widget messageBody(String message, String sender){
    return Card(
      //color: color,
      shadowColor: Colors.transparent,
      color: Color.fromRGBO(216, 196, 222, 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
     // color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 20,
              child: Text(
                sender,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 60,
              child: Text(
                message!=null? message : '   ',
                style: Theme.of(context).textTheme.headline3,
                  //backgroundColor: Color.fromARGB(255, 252, 219, 220)

              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget input(){
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        print(event.data.logicalKey.keyId);
        if (event.runtimeType == RawKeyDownEvent && !event.isKeyPressed(LogicalKeyboardKey.shiftLeft) &&
            (event.logicalKey.keyId == 4295426088)) {onSendMessage();}
      },
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 3.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            flex: 98,
            child: Row(
              children: [
                Expanded(
                  flex: 90,
                  child: TextField(
                    controller: textEditingController,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 5,
                    autocorrect: false,
                    enableSuggestions: false,
                    onSubmitted: (value){onSendMessage();},
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 5.0, top: 5.0),
                      border: InputBorder.none,
                      hintText: 'введите текст',
                      hintMaxLines: 2,
                      hintStyle: Theme.of(context).textTheme.bodyText2
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                    cursorColor: Colors.white,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: IconButton(
                      icon: Icon(Icons.check, color: Theme.of(context).primaryColor,),
                      iconSize: 36,
                      onPressed: onSendMessage,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget restrict(){
    return Text(
      'навигатор не может писать в чат',
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  Future<void> onSendMessage() async {
    if(!isChatBusy) {
      isChatBusy = true;
      print(textEditingController.text);

      print('send' + ' ' + textEditingController.text);
      bool result = await widget.chatStream.sendMessage(
          textEditingController.text);
      if (result) {
        textEditingController.clear();
        isChatBusy = false;
      }
      else {
        isChatBusy = false;
      }
    }
    else{
      print('chat is busy - wait for callback');
    }

  }
}
