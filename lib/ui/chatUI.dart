import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web/bloc/game_bloc.dart';
import 'package:web/models/player_model.dart';

class ChatUI extends StatefulWidget {
  final GameBloc gameBloc;
  final Function shrink;
  ChatUI(this.gameBloc, this.shrink);
  @override
  _ChatUIState createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  _scrollListener() {
    if (listScrollController.offset >=
        listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the bottom");
   //   chatBloc.getOlderMessages();
      setState(() {
        print("reach the bottom");
      });
    }
    if (listScrollController.offset <=
        listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    listScrollController.addListener(_scrollListener);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 150),
      width: 100,
      height: 600,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Stack(
            children:[

                    Align(
                        alignment: Alignment.topCenter,
                        child: buildChat()),




              Align(
                  alignment: Alignment.bottomCenter,
                  child: chatInput()
              ),
            ]
        ),
      ),
    );
  }

  Widget buildChat(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: StreamBuilder(
        stream: widget.gameBloc.chat,
        initialData: widget.gameBloc.chatList,
        builder: (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) {
          if(snapshot.hasData)
          {
            return ListView.builder(
              itemCount: snapshot.data.length,
              reverse: true,
              controller: listScrollController,
              itemBuilder: (context, int index){
                return chatItem(snapshot.data[index]);
              },
            );
          }
          else
          {
            return Container();
          }
        },
      ),
    );
  }
  Widget chatItem(Chat message){
    int _teamId = widget.gameBloc.teamId;
    //   print('user is  $_userId');
    if(message.teamId != _teamId)
        {
          return Container();
          /*
      return Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(child: messageBody(message.message, message.sender, true, Color.fromARGB(255, 48, 172, 32),Color.fromARGB(255, 115, 196, 32))),
          ],
        ),
      );

           */
    }
    else{
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 30.0, top: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(child: messageBody(message.message, message.sender, false,  Colors.white, Colors.white)),
          ],
        ),
      );
    }
  }
  Widget messageBody(String message, String sender, bool isSameTeam, Color colorFrom, Color colorTo){
    return Card(
      //color: color,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              sender,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
  Widget chatInput(){
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        print(event.data.logicalKey.keyId);
        if (event.runtimeType == RawKeyDownEvent && !event.isKeyPressed(LogicalKeyboardKey.shiftLeft) &&
            (event.logicalKey.keyId == 4295426088)) {onSendMessage();}

      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
        ),
        height: 50.0,

        child: Row(
            children: [
              Expanded(flex: 1, child: optionSuffix(0)),

              Expanded(
                //alignment: Alignment.centerLeft,
                flex: 6,
                child: TextField(
                  controller: textEditingController,
                  textCapitalization: TextCapitalization.sentences,
                  //keyboardType: TextInputType.multiline,
                 // expands: true,
                  minLines: 1,
                  maxLines: 30,
                  //textInputAction: TextInputAction.done,
                  autocorrect: false,
                  enableSuggestions: false,
                  onSubmitted: (value){onSendMessage();},
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 30.0, top: 5.0),
                    border: InputBorder.none,
                    hintText: 'Введите сообщение',
                    hintMaxLines: 2,
                    hintStyle: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 12.0,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.blue[600],
                  ),
                  cursorColor: Colors.blue[600],
                ),
              ),

              Expanded(flex: 1, child: optionSuffix(1)),


            ]
        ),

      ),
    );
  }

  Widget optionSuffix(int id){
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(id==1? Icons.send: Icons.chevron_left_rounded, color: Colors.blue[600],),
        onPressed: id==1? onSendMessage : onBack,
      ),
    );

  }
  void onSendMessage() async{
    //todo do send function
    if(textEditingController.text !='') {
    bool isOk = await widget.gameBloc.sendToChat(textEditingController.text);
    if(isOk)
      textEditingController.clear();
    }
  }
  void onBack(){
widget.shrink();
  }
}
