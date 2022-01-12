import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/bloc/chat_stream.dart';
import 'package:web/bloc/master_bloc.dart';
import 'package:web/bloc/nav_cards_for_choice.dart';
import 'package:web/bloc/team_position.dart';
import 'package:web/ui/HelpUI.dart';
import 'package:web/ui/gameover.dart';
import 'package:web/ui/new_pop_up.dart';
import 'package:web/ui/re_hex_form.dart';
import 'package:web/ui/re_nav_other_choice.dart';
import 'package:web/ui/re_other_team_status.dart';
import 'package:web/ui/re_chat.dart';
import 'package:web/ui/re_my_team_status.dart';
import 'package:web/ui/re_nav_hint.dart';
import 'package:web/ui/re_sentry_cards_for_choice.dart';
import 'package:web/ui/re_status_bar.dart';
import 'package:web/ui/re_game_board.dart';
import 'package:web/ui/re_nav_choice.dart';
import 'package:web/ui/re_cards_for_choice.dart';
import 'package:web/ui/turn_hint.dart';

import '../models/map_model.dart';
import '../models/map_model.dart';

class GameLayout extends StatefulWidget {
  final MasterBloc masterBloc;
  GameLayout(this.masterBloc);
  @override
  _GameLayoutState createState() => _GameLayoutState();
}

class _GameLayoutState extends State<GameLayout> {
  //final MasterBloc masterBloc = MasterBloc();
  bool isHintActive = false;
  Function cancelHint;
  String j;
  List<MapItem> cards = [];
  final ValueNotifier<bool> isSubmitted = ValueNotifier<bool>(false);


  //final NavCardsForChoice navCardsForChoice = NavCardsForChoice();
  final TeamPosition teamPosition = TeamPosition();


  @override
  void initState() {
    //startTime();
    cancelHint = (){isHintActive = false;};
    widget.masterBloc.stop.listen((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showDialog(context, event));
    });
    widget.masterBloc.turnHint.listen((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showTurnHint(context, event[0], event[1], event[2]));
      });
    // TODO: implement initState
    j = '{"id": 1, "row":1, "column":1, "url":"https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album", "position":"01", "description":"text"}';

    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));
    cards.add(MapItem.fromJson(json.decode(j)));


    //navCardsForChoice.saveCards(cards);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //print(widget.masterBloc.myTeamId.toString() + 'is data in widget from master');
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 125, 133, 188),
              Color.fromARGB(255, 234, 201, 223),
            ]
          )
        ),



        child: Row(
          children: [
            /// left padding ///
            Expanded(
              flex: 5,
              child: Container(),
            ),

            /// work space ///
            Expanded(
              flex: 90,
              child: Column(
                children: [
                  Expanded(
                    flex: 82,
                    child: Container(
                     // color: Colors.red,
                      child: Stack(
                        children: [
                          /// game board, turn status and navigator choice ///
                          Row(
                            children: [
                              /// left padding ///
                              Expanded(
                                flex: 18,
                                child: Container(
                                //  color: Colors.blue,
                                ),
                              ),
                              /// turn and game board ///
                              Expanded(
                                flex: 64,
                                child: Container(
                                  child: Column(
                                    children: [
                                      /// turn status bar ///
                                      Expanded(
                                        flex: 15,
                                        child: Container(
                                      //    color: Colors.yellow,
                                          child: Row(
                                            children: [
                                              /// left padding ///
                                              Expanded(
                                                flex: 17,
                                                child: Container(),
                                              ),
                                              /// turn status display ///
                                              Expanded(
                                                flex: 66,
                                                child: Container(
                                            //      color: Colors.white,
                                                  child: ReStatusBar(widget.masterBloc.statusStream),
                                                ),
                                              ),
                                              /// right padding ///
                                              Expanded(
                                                flex: 17,
                                                child: Container(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      /// game board ///
                                      Expanded(
                                        flex: 85,
                                        child: Stack(
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: ReNavChoice(1, widget.masterBloc.myNavChosenStream, widget.masterBloc.otherNavChosenStream)),
                                            Container(
                                              child: ReGameBoard(widget.masterBloc.highlightStream, widget.masterBloc.mapModel.mapItems),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                                child: ReOtherNavChoice(2, widget.masterBloc.myNavChosenStream, widget.masterBloc.otherNavChosenStream)
                                               ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              /// right padding ///
                              Expanded(
                                flex: 18,
                                child: Container(
                                 // color: Colors.blue,
                                ),
                              ),
                            ],
                          ),

                          /// overlay for right and left panels
                          Row(
                            children: [
                              /// left panel ///
                              Expanded(
                                flex: 26,
                                child: Container(
                               //   color: Color.fromRGBO(200, 200, 200, 0.3),
                                  child: Column(
                                    children: [
                                      /// team 1 status ///
                                      Expanded(
                                        flex: 37,
                                       child: MyTeamStatus(widget.masterBloc.myTeamStream, widget.masterBloc.myTeamId, getIsNav()? 'навигатор':'разведчик'),
                                      ),
                                      /// nav hint display and help ///
                                      Expanded(
                                        flex: 63,
                                        child: Column(
                                          children: [
                                            /// nav hint
                                            Expanded(
                                              flex: 65,
                                              child: Container(
                                             //   color: Colors.green,
                                           //     color: Color.fromRGBO(25, 25, 210, 0.3),
                                                child: getIsNav()? ReNavHint(widget.masterBloc.clues,widget.masterBloc.police,widget.masterBloc.highlightStream, widget.masterBloc.mapModel.mapItems):Container(),
                                              ),
                                            ),
                                            /// help placeholder: button and popup
                                            Expanded(
                                              flex: 35,
                                              child: Container(

                                                child: OtherTeamStatus(widget.masterBloc.otherTeamStream, widget.masterBloc.otherTeamId),
                                                /*
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                   child: LayoutBuilder(builder: (context, constraints){
                                                      return InkWell(
                                                        onTap: (){
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext context){
                                                                return Dialog(
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(8.0),
                                                                    //width: 500,
                                                                    //height: 400,
                                                                    color: Theme.of(context).cardColor,
                                                                    child: HelpUi(),
                                                                  ),
                                                                );
                                                              }
                                                          );
                                                        },
                                                        child: ReHexForm(
                                                          Container(
                                                            color: Theme.of(context).cardColor,
                                                            width: constraints.maxHeight*0.4,
                                                            height: constraints.maxHeight*0.4,
                                                            child: Container(
                                                              padding: EdgeInsets.all(6.0),
                                                              child: ReHexForm(
                                                                  Container(
                                                                    color: Theme.of(context).primaryColor,
                                                                    child: ReHexForm(
                                                                        //Icon(Icons.help_outline, color: Colors.white, size: constraints.maxHeight*0.20,)
                                                                      Center(child: Text('?', style: Theme.of(context).textTheme.subtitle2,))
                                                                    ),
                                                                  )
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                ),
                                              ),

                                                 */

                                            ),
                                            ),
                                          ],

                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              /// reserved empty space above game board ///
                              Expanded(
                                flex: 52,
                                child: Container(),
                              ),
                              /// right panel ///
                              Container(
                                child: Expanded(
                                  flex: 26,
                                  child: Column(
                                    children: [
                                      /// team 2 status ///
                                      Expanded(
                                        flex: 5,
                                        child: Container(),
                                        //child: OtherTeamStatus(widget.masterBloc.otherTeamStream, widget.masterBloc.otherTeamId)
                                      ),
                                      /// chat ///
                                      Expanded(
                                        flex: 95,
                                        child: Container(
                                            child: ReChat(widget.masterBloc.chatStream)),
                                        /*
                                        child: Container(
                                          color: Color.fromRGBO(25, 25, 210, 0.3),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 95,
                                                child: Column(
                                                  children: [
                                                    /// message area ////
                                                    Expanded(
                                                      flex: 80,
                                                      child: Column(),
                                                    ),
                                                    /// chat input container ///
                                                    Expanded(
                                                      flex: 20,
                                                      child: Container(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              /// right padding with scroll buttons ///
                                              Expanded(
                                                flex: 5,
                                                child: Column(
                                                  children: [
                                                    /// scroll buttons ///
                                                    Expanded(
                                                      flex: 80,
                                                      child: Column(),
                                                    ),
                                                    /// padding for right center ///
                                                    Expanded(
                                                      flex: 20,
                                                      child: Container(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        */
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// bottom panel with cards to pick///
                  Expanded(
                    flex: 18,
                    //child: masterBloc.isNavigator? CardsForChoice(widget.masterBloc.navCardsForChoice): SentryCardsForChoiceUI(widget.masterBloc.sentryCardsForChoice),
                    child: getIsNav()? CardsForChoice(widget.masterBloc.navCardsForChoice, widget.masterBloc.selectButtonState, isSubmitted): SentryCardsForChoiceUI(widget.masterBloc.sentryCardsForChoice, widget.masterBloc.selectButtonState, isSubmitted),
                  ),
                  /*
                  Expanded(
                    flex: 20,
                    child: Container(
                      color: Colors.green,
                      child: Row(
                        children: [
                          /// left arrow ///
                          Expanded(
                            flex: 10,
                            child: Container(
                              color: Colors.blueGrey,
                            ),
                          ),

                          /// panel with cards ///
                          Expanded(
                            flex: 80,
                            child: Container(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.2*0.6,
                                      /// main row with cards ///
                                      child: Row(
                                        children: [
                                          /// padding left
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                          /// place for cards ///
                                          Expanded(
                                            flex: 96,
                                            child: Container(
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                          /// padding right ///
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  /// submit button ///
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      color: Colors.white,
                                      height:  MediaQuery.of(context).size.height*0.2*0.3,
                                      width: MediaQuery.of(context).size.height*0.2*0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// right arrow ///
                          Expanded(
                            flex: 10,
                            child: Container(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  */
                ],
              ),
            ),



            /// right padding ///
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
  bool getIsNav(){
    while(widget.masterBloc.isNavigator == null)
      {
        Future.delayed(Duration(seconds: 1),(){});
      }
    return widget.masterBloc.isNavigator;
    /*
    if(widget.masterBloc.isNavigator != null)
      {

      }
    else{
      Future.delayed(Duration(seconds: 1),getIsNav);
    }

     */

  }
  /*
  Widget endGame(){
    return StreamBuilder(
      stream: widget.masterBloc.stop,
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

   */
  _showDialog(context, bool isWinner, ){
    showDialog(
        barrierDismissible: false,
        context: context,

        builder: (BuildContext context){
          return Dialog(
            //child: Container(
            //  padding: EdgeInsets.all(8.0),
            //  width: 500,
             // height: 400,
           //   color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35)
            ),
              child: GameOver(isWinner, (){widget.masterBloc.getStatus();}),
            );
        //  );
        }
    );
  }
  _showTurnHint(context, bool isNavigator, int phase, int eventCase){
    if(isHintActive)
      {
        Navigator.pop(context);
      }
    isSubmitted.value = false;
    showDialog(

      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35)
          ),
          child: TurnHint(isNavigator, phase, eventCase, cancelHint),
          );
      }
    );
    isHintActive = true;
  }
  /*
  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

   */
  /*
  void route(){
    print('timer');
    navCardsForChoice.addToStream(cards);
  }

   */
}
