
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web/bloc/game_bloc.dart';
import 'package:web/models/map_model.dart';
import 'package:web/models/turn_model.dart';
import 'package:web/ui/HelpUI.dart';
import 'package:web/ui/chatUI.dart';
import 'package:web/ui/clue_indicator.dart';
import 'package:web/ui/game_board.dart';
import 'package:web/ui/game_card.dart';
import 'package:web/ui/gameover.dart';
import 'package:web/ui/highligt_movement.dart';
import 'package:web/ui/navigator_hint.dart';
import 'package:web/ui/navigator_team_position.dart';
import 'package:web/ui/police_indicator.dart';
import 'package:web/ui/team_position_ui.dart';

class GameUI extends StatefulWidget{
  final GameBloc gameBloc;
  double maxWidth;
  GameUI(this.gameBloc, this.maxWidth);
  @override
  State<StatefulWidget> createState() {
    return GameUIState();
  }
}

class GameUIState extends State<GameUI>{
  Function onSendCard;
  Function onShrink;
  Function onHideHelp;
  Function toLobby;
  bool isChatActive = false;
  bool isHelpActive = false;
  final ScrollController viewScrollController = ScrollController();
  final ScrollController gridScrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    widget.gameBloc.countDown();
    onSendCard = (value){selectCard(value);};
    onShrink = (){setState(() {
      isChatActive =!isChatActive;
    });};
    onHideHelp = (){setState(() {
      isHelpActive =!isHelpActive;
    });};
    toLobby = (){widget.gameBloc.getPlayerStatus();};
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            //width: 1000,
            child: Scrollbar(
              isAlwaysShown: true,
              controller: viewScrollController,
              child: SingleChildScrollView(
                controller: viewScrollController,
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [

                    StreamBuilder(
                        stream: widget.gameBloc.progress,
                        initialData: widget.gameBloc.progressModel,
                        builder: (context, AsyncSnapshot<ProgressModel> snapshot) {
                          if(snapshot.hasData) {
                            return ConstrainedBox(
                              //color: Colors.red,
                              constraints: BoxConstraints(maxWidth: 1000),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 30,
                                    child: Column(
                                      children: [
                                        ClueIndicator(snapshot.data.clue1),
                                        PoliceIndicator(snapshot.data.police1),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 204, 102, 255),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            '1',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 15,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .stretch,
                                      children: [
                                        Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  100.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Center(child: timer()),
                                            )),
                                        Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  100.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  snapshot.data.phase==0? 'Навигатор':'Разведчики',
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline1, textScaleFactor: widget.maxWidth<900? 0.5:1,
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 51, 204, 102),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            '2',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 30,
                                    child: Column(
                                      children: [
                                        ClueIndicator(snapshot.data.clue2),
                                        PoliceIndicator(snapshot.data.police2),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }
                          else{
                            return Container();
                          }
                        }
                    ),

                    divider(),

                    Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             // Expanded(flex: isHelpActive? 15:5, child: isHelpActive? HelpUi(widget.gameBloc, onHideHelp): Container(),),
                              Expanded(flex: 5, child: navigatorCards(1),),
                              Expanded(flex: 50, child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    int h = isHelpActive? 15:5;
                                    int c = isChatActive? 15:5;
                                    int q = 60+h+c;
                                    double size = MediaQuery.of(context).size.width/q*50;
                                    return Container(
                                      padding: size<700? EdgeInsets.only(left: 0.0): EdgeInsets.only(left: (size-700)/2) ,
                                      child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: StreamBuilder(
                                                stream: widget.gameBloc.cardsForVote,
                                                initialData: widget.gameBloc.cardsFVote,
                                                builder: (context, AsyncSnapshot<List<MapItem>> snapshot) {
                                                  return HighLightMovement(
                                                      snapshot.data);
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: StreamBuilder(
                                                  stream: widget.gameBloc.map,
                                                  initialData: widget.gameBloc
                                                      .mapModel,
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                          MapModel> snapshot) {
                                                    return GameBoard(
                                                        snapshot.data.mapItems);
                                                  }
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: StreamBuilder(
                                                stream: widget.gameBloc
                                                    .teamPosition,
                                                initialData: widget.gameBloc
                                                    .teamPositions,
                                                builder: (context, AsyncSnapshot<
                                                    List<String>> snapshot) {
                                                  return TeamPositionUi(
                                                      snapshot.data);
                                                },
                                              ),
                                            ),

                                          ]
                                      ),
                                    );
                                  }
                                ),
                              ),),
                              Expanded(flex: 5, child: navigatorCards(2),),
                              Expanded(flex: isChatActive? 15:5, child: isChatActive? ChatUI(widget.gameBloc, onShrink): Container()),
                              //Expanded(flex:15, child: childChat()),
                            ],
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 70,
                              constraints: BoxConstraints(maxWidth: 1000),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.gameBloc.teamId==1?
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.gameBloc.isNavigator? 'Команда 1, Навигатор':'Команда 1, Разведчик',
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                      ),
                                    ),
                                  ) : Container(),
                                  widget.gameBloc.teamId==2?
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.gameBloc.isNavigator? 'Команда 2, Навигатор':'Команда 2, Разведчик',
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                      ),
                                    ),
                                  ) : Container(),
                                ],
                              ),
                            ),
                          ),
                          /*
                          Row(
                            children: [
                              navigatorCards(1),
                              Expanded(
                                flex: 70,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Stack(
                                      children: [
                                        StreamBuilder(
                                            stream: widget.gameBloc.map,
                                            initialData: widget.gameBloc.mapModel,
                                            builder: (context, AsyncSnapshot<MapModel> snapshot) {
                                              return GameBoard(snapshot.data.mapItems);
                                            }
                                        ),
                                        StreamBuilder(
                                          stream: widget.gameBloc.teamPosition,
                                          initialData: widget.gameBloc.teamPositions,
                                          builder: (context, AsyncSnapshot<List<String>> snapshot){
                                            return TeamPositionUi(snapshot.data);
                                          },
                                        ),
                                      ]
                                  ),
                                ),
                              ),
                              navigatorCards(2),
                            ],
                          ),
                          */
                        ]
                    ),

                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: divider(),
                            )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: chatButton(),
                          /*
                          child: FloatingActionButton(
                              child: Icon(Icons.chat, color: Colors.white,size: 20.0,),
                              onPressed: (){setState(() {isChatActive =!isChatActive;});}
                          ),

                           */
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: helpButton(),
                          /*
                          Padding(
                            padding: MediaQuery.of(context).size.width<1000? EdgeInsets.only(left: 8.0): EdgeInsets.only(left: MediaQuery.of(context).size.width - 1500),
                            child: FloatingActionButton(
                                child: Icon(Icons.help_outline , color: Colors.white,size: 20.0,),
                                onPressed: (){setState(() {isHelpActive =!isHelpActive;});}
                            ),


                          ),

                           */
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: (){widget.gameBloc.submitSend();},
                        color: Colors.blue[600],
                        child: Text(
                          'Подтвердить выбор',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),

                    bottomPanel(widget.gameBloc.isNavigator),
                    endGame(),
                  ],
                ),
              ),
            ),
          ),
        ),
        /*
        Align(
          alignment: widget.maxWidth>300? Alignment.centerRight:Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 300,
              maxHeight: 900
            ),
              child: isChatActive? ChatUI(widget.gameBloc, onShrink): Container()),
        ),

         */
        /*
        Align(
          alignment: widget.maxWidth>300? Alignment.centerLeft:Alignment.centerRight,
          child: Container(
            /*
              constraints: BoxConstraints(
                  maxWidth: 300,
              ),

             */
              child: isHelpActive? HelpUi(widget.gameBloc, onHideHelp): Container()),
        ),

         */
      ],
    );
  }
  Widget childChat(){
    if(isChatActive){
      return ChatUI(widget.gameBloc, onShrink);
    }
    else{
      return Container();
    }
  }
  Widget teamRole(int team){
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth<1000){
          return Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Container()
          );
        }
        else{
          return Padding(
            padding: EdgeInsets.only(left: (constraints.maxWidth-1000).abs()/2),
            child: Container(),
          );
        }
      },
    );
  }
  Widget helpButton(){
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth<1000){
          return Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: FloatingActionButton(
                child: Icon(Icons.help_outline , color: Colors.white,size: 20.0,),
                onPressed: (){setState(() {isHelpActive =!isHelpActive;});}
            ),
          );
        }
        else{
          return Padding(
            padding: EdgeInsets.only(left: (constraints.maxWidth-1000).abs()/2),
            child: FloatingActionButton(
                child: Icon(Icons.help_outline , color: Colors.white,size: 20.0,),
                onPressed: (){setState(() {isHelpActive =!isHelpActive;});}
            ),
          );
        }
      },
    );

  }
  Widget chatButton(){
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth<1000){
          return Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: FloatingActionButton(
                child: Icon(Icons.chat, color: Colors.white,size: 20.0,),
                onPressed: (){setState(() {isChatActive =!isChatActive;});}
            ),
          );
        }
        else{
          return Padding(
            padding: EdgeInsets.only(right: (constraints.maxWidth-1000).abs()/2),
            child: FloatingActionButton(
                child: Icon(Icons.chat, color: Colors.white,size: 20.0,),
                onPressed: (){setState(() {isChatActive =!isChatActive;});}
            ),
          );
        }
      },
    );
  }
  Widget timer(){
    return StreamBuilder(
        stream: widget.gameBloc.timer,
        builder: (context, AsyncSnapshot<String> snapshot){
          if(snapshot.hasData)
          {
            return Text(snapshot.data, style: Theme.of(context).textTheme.headline1, textScaleFactor: widget.maxWidth<900? 0.5:1,);
          }
          else
          {
            return Container();
          }
        }
    );
  }
  Widget divider(){
    return Container(
      constraints: BoxConstraints(maxWidth: 1000),
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
    );
  }
  Widget navigatorCards(int teamId){
    return StreamBuilder(
      stream: widget.gameBloc.navChoice,
      initialData: widget.gameBloc.choice,
      builder: (context, AsyncSnapshot<NavigatorChoice> snapshot) {
        if(snapshot.hasData) {
          return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 150, minWidth: 50),
            //padding: EdgeInsets.symmetric(vertical: 50.0),
            //padding: widget.maxWidth > 1000 ? EdgeInsets.symmetric(vertical: 75.0, horizontal: 20.0) :EdgeInsets.symmetric(vertical: 75.0),
           // width: 150.0,
            //  color: Colors.green,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 10.0,
                    ),
                    teamId == 1
                        ? GameCard(snapshot.data.navigatorChoice1.mapItems[0].url, snapshot.data.navigatorChoice1.mapItems[0].id, 'select2')
                        : GameCard(snapshot.data.navigatorChoice2.mapItems[0].url, snapshot.data.navigatorChoice2.mapItems[0].id, 'select2'),
                    Container(
                      height: 10.0,
                    ),

                    teamId == 1
                        ?  snapshot.data.navigatorChoice1.mapItems.length>1? GameCard(snapshot.data.navigatorChoice1.mapItems[1].url, snapshot.data.navigatorChoice1.mapItems[0].id, 'select2'):GameCard('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',0,'select2')
                        : snapshot.data.navigatorChoice2.mapItems.length>1? GameCard(snapshot.data.navigatorChoice2.mapItems[1].url, snapshot.data.navigatorChoice2.mapItems[1].id, 'select2'):GameCard('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',0,'select2'),
                    Container(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        else
          {
            widget.gameBloc.addToStreamChoice();
            return Container();
          }
      }
    );
  }
  Widget bottomPanel(bool isNavigator){
    if(isNavigator)
      {
        return Container(
          // color: Colors.yellow,
          height: 500.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: constraints.maxWidth<500?  const EdgeInsets.only(right: 10.0): EdgeInsets.only(left: constraints.maxWidth - 350),
                      child: Stack(
                        children: [
                          Align(alignment: Alignment.topCenter, child: Text(
                            'Расположение ПОДАРКОВ и СНЕГОВИКОВ', style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1, textAlign: TextAlign.center,)),
                          NavigatorHint(
                              widget.gameBloc.clues, widget.gameBloc.police,
                              widget.maxWidth),
                          StreamBuilder(
                            stream: widget.gameBloc.teamPosition,
                            initialData: widget.gameBloc.teamPositions,
                            builder: (context, AsyncSnapshot<
                                List<String>> snapshot) {
                              return NavigatorHintteamPosition(
                                  snapshot.data, widget.gameBloc.teamId,
                                  widget.maxWidth);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                ),

                flex: 40,
              ),
              Expanded(
                flex: 60,
                child: StreamBuilder(
                  stream: widget.gameBloc.navCards,
                  initialData: widget.gameBloc.navigatorCards,
                  builder: (context, AsyncSnapshot<MapModel> snapshot) {
                    if(snapshot.hasData) {
                      return StreamBuilder(
                        stream: widget.gameBloc.selectedList,
                        initialData: [0,0],
                        builder: (context, AsyncSnapshot<List<int>> snap) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            //width: 700.0,
                            child: Scrollbar(
                              isAlwaysShown: true,
                              controller: gridScrollController,
                              child: GridView.extent(
                                controller: gridScrollController,
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 20.0,
                                children: snapshot.data.mapItems.map((e) =>
                                    GameCard(e.url, e.id, 'select', onSendCard, snap.data.length>0? snap.data.length>1? e.id==snap.data[0]||e.id==snap.data[1]? true:false : e.id==snap.data[0]? true:false : false)).toList(),
                              ),
                            ),
                          );
                        }
                      );
                    }
                    else
                      {
                        return Container();
                      }
                  }
                ),
              ),
            ],
          ),
        );
      }
    else{
      return Container(
      height: 250,
       child: StreamBuilder(
            stream: widget.gameBloc.cardsForVote,
            initialData: widget.gameBloc.cardsFVote,
            builder: (context, AsyncSnapshot<List<MapItem>> snapshot) {
              print('cards for vore length is' + snapshot.data.length.toString());
              if(snapshot.hasData&&snapshot.data.length>1) {
                return StreamBuilder(
                  stream: widget.gameBloc.selectedList,
                  initialData: [0],
                  builder: (context,AsyncSnapshot<List<int>> snap) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        width: 700.0,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: gridScrollController,
                          child: GridView.extent(
                            controller: gridScrollController,
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0,
                            children:
                            snapshot.data.map((e) =>
                                GameCard(e.url, e.id, 'select', onSendCard,
                                    snap.data.length > 0 ? e.id == snap.data[0]
                                        ? true
                                        : false : false)).toList(),


                          ),
                        ),


                      );


                  }
                );
              }
              else
              {
             //   widget.gameBloc.addToStreamCardsForVote();
                return Container();
              }
            }
        ),
      );
    }
  }
  void selectCard(int id){
    print('selected card $id');
    widget.gameBloc.selectHandler(id);
  }
  Widget endGame(){
    return StreamBuilder(
      stream: widget.gameBloc.winner,
      initialData: 0,
      builder: (context, AsyncSnapshot<int> snapshot){
        if(snapshot.hasData && snapshot.data > 0)
          {
            WidgetsBinding.instance.addPostFrameCallback((_) => _showDialog(context, snapshot.data));
            return Container();
          }
        else{
          return Container();
        }
      },
    );
  }
/*
  _showDialog(context, int teamId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Card(
            child: Container(
              width: 600,
              height: 400,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Игра окончена!',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      'Команда $teamId поведила!',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    RaisedButton(
                      child: Text('Назад в лобби', style: Theme.of(context).textTheme.bodyText1,),
                      color: Colors.blue[600],
                      onPressed: (){widget.gameBloc.goToLobby();},
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

 */
  _showDialog(context, int teamId, ){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: 500,
              height: 400,
              color: Theme.of(context).cardColor,
             // child: GameOver(teamId, toLobby),
            ),
          );
        }
    );
  }
}