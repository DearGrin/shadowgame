import 'package:flutter/material.dart';
import 'package:web/bloc/game_bloc.dart';
import 'package:web/bloc/rules_bloc.dart';
import 'package:web/models/player_model.dart';
import 'package:web/models/search_model.dart';

class CustomGame extends StatefulWidget {
  final RulesBloc rulesBloc;
  CustomGame(this.rulesBloc);
  @override
  _CustomGameState createState() => _CustomGameState();
}

class _CustomGameState extends State<CustomGame> {
  int index = 0;
  String error = '';
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController searchScrollController = new ScrollController();
  final ScrollController customGameScrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 400,
      child: IndexedStack(
        index: index,
        children: [
          Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text('Добавьте миниум 3 игрков, чтобы начать игру', style: Theme.of(context).textTheme.bodyText1,)),
                      FlatButton(onPressed: (){setState(() {
                        index = 1;
                      });}, child: Icon(Icons.person_add, color: Colors.white,))
                    ],
                  ),
                ),
                Align(alignment: Alignment.bottomCenter, child: Padding(
                  padding: const EdgeInsets.only(bottom:50.0),
                  child: Text(error, style: TextStyle(color: Colors.red[600]),),
                )),
                Align(alignment: Alignment.topCenter, child: Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: listOfPlayers(),
                )),
                Align(alignment: Alignment.bottomCenter, child: startButton()),
              ]
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(' ', style: Theme.of(context).textTheme.bodyText1,)),
                    FlatButton(onPressed: (){setState(() {
                      index = 0;
                    });}, child: Icon(Icons.close, color: Colors.white,))
                  ],
                ),
              ),
              Align(alignment: Alignment.topCenter, child: searchPlayers()),
              Align(alignment: Alignment.bottomCenter, child: searchInput()),
            ]
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Widget listOfPlayers(){
  return  StreamBuilder(
    stream: widget.rulesBloc.customGameListUsers,
    initialData: widget.rulesBloc.customGameList,
    builder: (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
      if(snapshot.hasData&&snapshot.data.users.length>0)
      {
        return Scrollbar(
          isAlwaysShown: false,
          controller: customGameScrollController,
          child: ListView.builder(
            controller: customGameScrollController,
            itemCount: snapshot.data.users.length,
            reverse: false,
            //controller: listScrollController,
            itemBuilder: (context, int index){
              return playerItem(snapshot.data.users[index], false);
            },
          ),
        );
      }
      else if(snapshot.hasData)
        {
          return Center(
            child: Text('Список игроков пуст', style: Theme.of(context).textTheme.bodyText1,),
          );
        }
      else
      {
        return Center(
            child: Text('Список игроков пуст', style: Theme.of(context).textTheme.bodyText1,),);
        //return Container();
      }
    },
  );
  }
  Widget searchPlayers(){
    return  Padding(
      padding: const EdgeInsets.only(bottom: 50.0, top: 50.0),
      child: StreamBuilder(
        stream: widget.rulesBloc.search,
        initialData: widget.rulesBloc.searchResult,
        builder: (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
          if(snapshot.data.users!=null) {
            if (snapshot.hasData && snapshot.data.users.length > 0) {
              return Scrollbar(
                isAlwaysShown: false,
                controller: searchScrollController,
                child: ListView.builder(
                  controller: searchScrollController,
                  itemCount: snapshot.data.users.length,
                  reverse: false,
                  //controller: listScrollController,
                  itemBuilder: (context, int index) {
                    return playerItem(snapshot.data.users[index], true);
                  },
                ),
              );
            }
            else if (snapshot.hasData) {
              return Center(
                child: Text('Игроков не найдено', style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,),
              );
            }
            else{
              return Container();
            }
          }
          else
          {
            return Container();
          }
        },
      ),
    );
  }
  Widget playerItem(FoundUser player, bool isSearch){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(player.name, style: Theme.of(context).textTheme.bodyText1,),
        ),
        isSearch? FlatButton(onPressed: (){addUser(player);}, child: Text('+', style: Theme.of(context).textTheme.bodyText1,), color: Theme.of(context).primaryColor) :
        FlatButton(onPressed: (){deleteuser(player);},
          child: Text('-', style: Theme.of(context).textTheme.bodyText1,), color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
  Widget searchInput(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      height: 50.0,
      child: Row(
          children: [
            Expanded(
              //alignment: Alignment.centerLeft,
              flex: 6,
              child: TextField(
                controller: textEditingController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: false,
                enableSuggestions: false,
                onSubmitted: (value){onSearch();},
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 30.0, top: 5.0),
                  border: InputBorder.none,
                  hintText: 'Введите email',
                  hintStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(flex: 1, child: optionSuffix()),
          ]
      ),
    );
  }
  Widget optionSuffix(){
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(Icons.search, color: Theme.of(context).primaryColor,),
        onPressed: onSearch,
      ),
    );

  }
  Widget startButton(){
    return FlatButton(
      color: Theme.of(context).primaryColor,
      onPressed: widget.rulesBloc.customGameList.users.length>2?  onStart:null,
      child: Text('Начать игру', style: Theme.of(context).textTheme.bodyText1,),);
  }
  void onSearch(){
    if(textEditingController.text != '') {
      bool isSuccess = true;
      widget.rulesBloc.searchForPlayer(textEditingController.text);
      if (isSuccess) {
        textEditingController.clear();
      }
      else {
        // show message
      }
    }
  }
  void addUser(FoundUser user){
    widget.rulesBloc.addToCustomGameList(user);
   // widget.gameBloc.removeFromSearchList(user);
    //print('users length ' + widget.gameBloc.searchResult.users.length.toString());
    //widget.gameBloc.searchResult.users.remove(user);
   // print('users length ' + widget.gameBloc.searchResult.users.length.toString());
  //  widget.gameBloc.addToStreamSearchResult();
   //widget.gameBloc.searchResult.users.clear();
    setState(() {
      index = 0;
    });

   // Navigator.of(context).pop();
  }
  void deleteuser(FoundUser user){
    print('player is' + user.name + user.id.toString());
    widget.rulesBloc.customGameList.users.remove(user);
    widget.rulesBloc.addToStreamCustomGameList();
  }
  void onStart() async{
    setState(() {
      index = 2;
    });
  String isSuccess = await widget.rulesBloc.startCustomGame();
  if(isSuccess != 'success')
    {
      setState(() {
        index = 0;
        error = isSuccess;
      });
    }
  else{
    Navigator.of(context).pop();
  }
  }
}
