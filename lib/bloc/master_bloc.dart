

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/bloc/chat_stream.dart';
import 'package:web/bloc/highlight_stream.dart';
import 'package:web/bloc/my_nav_chosen_cards.dart';
import 'package:web/bloc/my_team_stream.dart';
import 'package:web/bloc/nav_cards_for_choice.dart';
import 'package:web/bloc/other_nav_chosen_cards.dart';
import 'package:web/bloc/other_team_stream.dart';
import 'package:web/bloc/select_button_state_stream.dart';
import 'package:web/bloc/sentry_cards_for_choice_stream.dart';
import 'package:web/bloc/status_stream.dart';
import 'package:web/models/highlight_model.dart';
import 'package:web/models/map_model.dart';
import 'package:web/models/player_model.dart';
import 'package:web/models/turn_model.dart';


class MasterBloc{
  Function getUStatus;
  MasterBloc(this.getUStatus);
  String token;
  final statusStream = StatusStream();
  MyTeamStream myTeamStream;
  final otherTeamStream = OtherTeamStream();
  final myNavChosenStream = MyNavChosenCards();
  final otherNavChosenStream = OtherNavChosenCards();
  NavCardsForChoice navCardsForChoice;
  SentryCardsForChoiceStream sentryCardsForChoice;
  final highlightStream = HighlightStream();
  final selectButtonState = SelectButtonStateStream();
  ChatStream chatStream;
  final PublishSubject<bool> _stopFetcher = new PublishSubject<bool>();
  final PublishSubject<List<dynamic>> _turnHintFetcher = new PublishSubject<List<dynamic>>();
  Stream<bool> get stop => _stopFetcher.stream;
  Stream<List<dynamic>> get turnHint => _turnHintFetcher.stream;
  int myTeamId; // todo set this
  int otherTeamId; // todo set this
  bool isNavigator;
  List<String> _teamPositions = [];
  MapModel mapModel = MapModel(); // map of cards on game board
  List<String> clues;
  List<String> police;
  int phase;
  int prevClues = 0;
  int prevPolice = 0;
  int currClues = 0;
  int currPolice = 0;

  MyTeamStream setStreams(){
    myTeamStream = MyTeamStream();
    chatStream = ChatStream(token, getIsNav);
    navCardsForChoice = NavCardsForChoice(token);
    sentryCardsForChoice = SentryCardsForChoiceStream(token);
    return myTeamStream;
  }
  void setToken(String _token){
    token = _token;
  }
void pushStreams(){
  print('push streams');
  myTeamStream.addToStream();
}
  Future<void> setGame(var jsonResponse) async{
    //todo get model instead of json string
    print('start to set game');
    GamerStatus _status = GamerStatus.fromJson(jsonResponse);
    //todo add police and clues
    /// cache setting info
    myTeamId = jsonResponse['team_id'];
    otherTeamId = jsonResponse['team_id'] == 1 ? 2 : 1;
    print('myTeam is $myTeamId other is $otherTeamId');
    isNavigator = _status.isNavigator;
    setValues(myTeamId, isNavigator);
    print('is navigator is $isNavigator');
    print(_status.cards);
    mapModel = _status.cards;
    print(mapModel.mapItems[0].url);
   ///get nav cards due to different model
    if(isNavigator) {
      navCardsForChoice.saveCards(_status.navigatorCards.mapItems, jsonResponse['phase_id']);
      clues = [jsonResponse['clue_cards'][0].toString(),jsonResponse['clue_cards'][1].toString(),jsonResponse['clue_cards'][2].toString()];
      police = [jsonResponse['police_cards'][0].toString(),jsonResponse['police_cards'][1].toString(),jsonResponse['police_cards'][2].toString()];
    }
    print('done nav cards');
    manageGame(jsonResponse, 0);
    List<dynamic> _tmp = [isNavigator, _status.phaseId, 0];
    _turnHintFetcher.sink.add(_tmp);
  }
  Future<void> getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _my = prefs.getInt('myTeam');
    int _other = _my==1? 2:1;
    bool _is = prefs.getBool('isNav');
    myTeamId = _my;
    otherTeamId = _other;
    isNavigator = _is;
    List<dynamic> _tmp = [isNavigator, phase != null? phase : 0, 0];
    _turnHintFetcher.sink.add(_tmp);
}
Future<void> setValues(int my, bool isNav) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('myTeam', my);
  prefs.setBool('isNav', isNav);
}
  Future<void> manageGame(var data, int mode) async {
    if(mode==1)
      {
        print('mode 1 and looking for prefs');
        await getValues();
      }
    print('start to manage data in mode $mode and my team is $myTeamId and isNav is $isNavigator');
   // print(data);
    print('here goes my data');
    print(data);
    print(data['room_id'].toString());
    print(data['team1_police_count'].toString());
    print(data['team2_police_count'].toString());
    print(data['team1_clue_count'].toString());
    print(data['team2_clue_count'].toString());

    ProgressModel _p = ProgressModel(clue1: data['team1_clue_count'], clue2: data['team2_clue_count'], police1: data['team1_police_count'], police2: data['team2_police_count'], phase: data['phase_id'], endTime: data['timeout']);

    print('progress model is: ' + _p.clue1.toString() + '/'+ _p.police1.toString() +'/'+  _p.clue2.toString() +'/'+  _p.police2.toString() +'/'+  _p.phase.toString() +'/'+  _p.endTime.toString());
    print(data['team1_police_count'].toString());
    /// handle turn status
    TurnModel _turnModel = TurnModel(
      phase: _p.phase,
      endTime: _p.endTime,
    );
    phase = _turnModel.phase;
    print('turn model is: ' + _turnModel.phase.toString() + '/'+  _turnModel.endTime.toString());

    /// handle my team status
    StatusModel _myTeamStatus = StatusModel(
      clue: myTeamId==1? _p.clue1:_p.clue2,
      police: myTeamId==1? _p.police1:_p.police2,
    );
    currClues = _myTeamStatus.clue;
    currPolice = _myTeamStatus.police;

    print('my status model is: ' + _myTeamStatus.clue.toString() + '/'+ _myTeamStatus.police.toString());

    /// handle other team status
    StatusModel _otherTeamStatus = StatusModel(
      clue: myTeamId==1? _p.clue2:_p.clue1,
      police: myTeamId==1? _p.police2:_p.police1,
    );

    print('other status model is: ' + _otherTeamStatus.clue.toString() + '/'+ _otherTeamStatus.police.toString());

    ///handle navigator choice
    print('handle nav choice in master');
    MapModel _tm2;
    MapModel _tm;
    if(data['navigator1_choice']!=null)
      _tm = MapModel.fromJson(data['navigator1_choice']);
    else
      _tm = MapModel(mapItems: []);
    if(data['navigator2_choice']!=null)
      _tm2 = MapModel.fromJson(data['navigator2_choice']);
    else
      _tm2 = MapModel(mapItems: []);

    print('nav choice is: ' + _tm.toString() + '/' + _tm2.toString());

    /// handle team positions and highlight
    print('handle highlight');
    _teamPositions = [data['position_team1'], data['position_team2']];

    print('team1 pos is: '+ _teamPositions[0] + '/' + _teamPositions[1]);

    String _myPosition = myTeamId==1? data['position_team1'] : data['position_team2'];

    print('my position is: ' + _myPosition);

    List<String> _high = [];
    if(data['phase_id']==1)
      {
        print('phase id is 1 - going for sentry cards');
        _high = getSentryCards(myTeamId==1? _tm.mapItems.length : _tm2.mapItems.length, myTeamId);
      }
    else{
      print('phase id is 0 not going for sentry cards');
      _high = [];
    }
    //List<String> _highlightCards = data['phase_id']==1? getSentryCards(myTeamId==1? _tm.mapItems.length : _tm2.mapItems.length): []; // todo get the list


    print('high cards');
    print(_high);

    HighlightModel _highlight = HighlightModel(_teamPositions, _myPosition, _high, mapModel.mapItems);

    print(_highlight);

    /// handle select button state
    if(data['phase_id'] == 0 && isNavigator || data['phase_id'] == 1 && !isNavigator)
    {
      print('button is ready');
      selectButtonState.saveStatus('ready');
    }
    else
    {
      print('button is locked');
      selectButtonState.saveStatus('locked');
    }

    /// handle cards for navigator choice
    if(isNavigator && mode==1) {
      print('handle mode1 for isNav in mode 1');
      MapModel _model1 = MapModel.fromJson(data['navigator1_cards']);
      MapModel _model2 = MapModel.fromJson(data['navigator2_cards']);

      print(_model1);
      print(_model2);

      navCardsForChoice.saveCards(myTeamId == 1 ? _model1.mapItems : _model2.mapItems, phase);
    }
    //NavigatorChoice _choice = NavigatorChoice(
    //    data['navigator1_choice'], data['navigator2_choice']);


   // PhaseEvent _status = PhaseEvent.fromJson(data);
    /// do progress model
     /*
    ProgressModel _progress = ProgressModel(
        clue1: _status.teamClue1,
        clue2: _status.teamClue2,
        police1: _status.teamPolice1,
        police2: _status.teamPolice2,
        phase: _status.phaseId,
        endTime: _status.timeout);
    */

    //print('clue1 is ' + _p.clue1.toString());

    statusStream.saveModel(_turnModel);


    // myTeamStream.addToStream(_myTeamStatus);

    myTeamStream.saveModel(_myTeamStatus);



    otherTeamStream.saveModel(_otherTeamStatus);


    myNavChosenStream.saveItems(myTeamId==1? _tm.mapItems : _tm2.mapItems);
    otherNavChosenStream.saveItems(myTeamId==1? _tm2.mapItems : _tm.mapItems);


   // List<dynamic> _t1 = data['navigator1_choice'];
   // MapModel _tm = MapModel.fromJson(data['navigator1_choice']);
   // print(_tm.mapItems.length.toString() + ' length is');
   // List<dynamic> _t2 = data['navigator2_choice'];
    /// handle cards for sentry choice





    highlightStream.saveCards(_highlight);
    //sentryCardsForChoice.saveCards(_highlight.cards);

    if(data['phase_id'] == 1) {
      print('handle phase 1');
      sentryCardsForChoice.saveCards(gSentryCards(
          getSentryCards(myTeamId == 1 ? _tm.mapItems.length : _tm2.mapItems.length, myTeamId))); // todo add count and team
    }
    else{
      sentryCardsForChoice.saveCards([]);
    }
    handleTurnHint();





  }
  bool getIsNav(){
    while(isNavigator == null)
      {
        Future.delayed(Duration(seconds:1),(){});
      }
        return isNavigator;
  }
  void showChat(var j){
    print('start to decode chat');
    //print(jsonDecode(message));
    //var j = jsonDecode(message);

    Chat _chat = Chat(teamId: j['team_id'], message: j['message'], sender: j['sender']);
    //Chat chat = Chat.fromJson(jsonDecode(message));
    if(myTeamId == _chat.teamId)
      {
        print(_chat.message);
        chatStream.getMessage(_chat);
      }


  }

  /// method to calculate sentry cards
  List<String> getSentryCards(int count, int teamId){ //todo add count and team and logic
    print('start to get cards for team $teamId and position in $_teamPositions for count $count');
    List<String> cardsId = [];
    int _row = int.parse(_teamPositions[teamId-1].substring(0,1));
    int _column = int.parse(_teamPositions[teamId-1].substring(1));
    if (count == 1)
      {
        int _r1 = _row + count;
        int _r2 = _row - count;
        int _c1 = _column + count;
        int _c2 = _column - count;
        int _c3 = _column + 2;
        int _c4 = _column -2;
        String a = _r1.toString() + _c1.toString();
        String b = _r1.toString() + _c2.toString();
        String c = _r2.toString() + _c1.toString();
        String d = _r2.toString() + _c2.toString();
        String e = _row.toString() + _c3.toString();
        String f = _row.toString() + _c4.toString();
        cardsId.add(a);
        cardsId.add(b);
        cardsId.add(c);
        cardsId.add(d);
        cardsId.add(e);
        cardsId.add(f);
      }
    else{
      int _r1 = _row + count;
      int _r2 = _row - count;
      int _r3 = _row - 1;
      int _r4 = _row + 1;
      int _c1 = _column + count;
      int _c2 = _column - count;
      int _c3 = _column --;
      int _c4 = _column ++;
      int _c5 = _column + 4;
      int _c6 = _column - 4;
      int _c7 = _column + 3;
      int _c8 = _column - 3;
      String a = _r1.toString() + _c1.toString();
      String b = _r1.toString() + _c2.toString();
      //String k = _r1.toString() + _c3.toString();
      //String m = _r1.toString() + _c4.toString();
      String n = _r1.toString() + _column.toString();

      String c = _r2.toString() + _c1.toString();
      String d = _r2.toString() + _c2.toString();
      String l = _r2.toString() + _column.toString();

      String e = _row.toString() + _c5.toString();
      String f = _row.toString() + _c6.toString();

      String g = _r3.toString() + _c7.toString();
      String h = _r3.toString() + _c8.toString();

      String i = _r4.toString() + _c7.toString();
      String j = _r4.toString() + _c8.toString();

      cardsId.add(a);
      cardsId.add(b);
      cardsId.add(c);
      cardsId.add(d);
      cardsId.add(e);
      cardsId.add(f);
      cardsId.add(g);
      cardsId.add(h);
      cardsId.add(i);
      cardsId.add(j);
      //cardsId.add(k);
      cardsId.add(l);
      //cardsId.add(m);
      cardsId.add(n);
    }

    return cardsId;
  }

  List<MapItem> gSentryCards(List<String> cardsId){
    print('got list of ids');
    print(cardsId);

    List<MapItem> _cards = [];
    cardsId.forEach((element) {
      var card = mapModel.mapItems.where((el) =>
      el.position == element);
      if (card.isNotEmpty)
        _cards.add(card.first);
    });
    print('and total cards: '+ _cards.length.toString());
    return _cards;
  }
  void handleStopGame(int winner){
  bool isWinner = winner==myTeamId? true:false;
  _stopFetcher.sink.add(isWinner);
  }
  void handleTurnHint(){
    int eventCase = 0;
    if(prevClues != currClues)
      {
        prevClues = currClues;
        eventCase = 1;
      }
    if(prevPolice != currPolice)
      {
        prevPolice = currPolice;
        eventCase = 2;
      }
    List<dynamic> _tmp = [isNavigator, phase, eventCase];
    _turnHintFetcher.sink.add(_tmp);
  }
  void getStatus(){
    getUStatus();
  }
void dispose(){
    _stopFetcher.close();
    statusStream.dispose();
    myTeamStream.dispose();
    myNavChosenStream.dispose();
    otherNavChosenStream.dispose();
    otherTeamStream.dispose();
    navCardsForChoice.dispose();
    sentryCardsForChoice.dispose();
    highlightStream.dispose();
    chatStream.dispose();
    selectButtonState.dispose();
    _turnHintFetcher.close();
}

}
//final MasterBloc masterBloc = MasterBloc();
