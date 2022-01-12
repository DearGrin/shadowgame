

import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/models/evnet_model.dart';
import 'package:web/models/map_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web/models/php_list.dart';
import 'package:web/models/player_model.dart';
import 'package:web/models/search_model.dart';
import 'package:web/models/turn_model.dart';
import 'dart:convert' show json, jsonDecode;
import 'dart:async' show Timer;
import 'package:web_socket_channel/html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;

class GameBloc{
  String token;
  int _statePage = 0;
  int _team1Position;
  int _team2Position;
  Dio dio = Dio();
  int a;
  List<int> selectedCards = new List<int>();
  String uid;
  bool isSelectionSent  = false;
  int countdown; //todo pass the value

  HtmlWebSocketChannel socket;

  PhpList _phpList = PhpList();
  MapModel mapModel = MapModel();
  MapModel navigatorCards = MapModel();
  ProgressModel progressModel = ProgressModel();
  TurnModel _turnModel = TurnModel();
  ShowSelectedModel showSelectedModel = ShowSelectedModel(team1Cards: [MapItem(), MapItem()], team2Cards: [MapItem(), MapItem()]);
  TeamPosition _teamPosition = TeamPosition();
  NavigatorChoice choice = NavigatorChoice(MapModel(), MapModel());
  List<String> teamPositions = ['0','0'];
  bool isNavigator;
  bool isOnline = false;
  int teamId;
  int phase;
  List<String> clues;
  List<String> police;
  List<MapItem> cardsFVote = [MapItem()];
  List<Chat> chatList = [];
  List<Player> playersList =[];


  SearchResult searchResult = SearchResult();
  SearchResult customGameList = SearchResult(users: []);//todo users: []
  List<FoundUser> searchList = [];

  final PublishSubject<int> _statePageFetcher = new PublishSubject<int>();
  final PublishSubject<MapModel> _mapFetcher = new PublishSubject<MapModel>();
  final PublishSubject<ProgressModel> _progressFetcher = new PublishSubject<ProgressModel>();
  final PublishSubject<TurnModel> _turnFetcher = new PublishSubject<TurnModel>();
  final PublishSubject<ShowSelectedModel> _showSelectedFetcher = new PublishSubject<ShowSelectedModel>();
  final PublishSubject<List<String>> _teamPositionFetcher = new PublishSubject<List<String>>();
  final PublishSubject<String> _timerFetcher = new PublishSubject<String>();
  final PublishSubject<NavigatorChoice> _choiceFetcher = new PublishSubject<NavigatorChoice>();
  final PublishSubject<MapModel> _navigatorCardsFetcher = new PublishSubject<MapModel>();
  final PublishSubject<List<MapItem>> _cardsForVoteFetcher = new PublishSubject<List<MapItem>>();
  final PublishSubject<int> _teamWinnerFetcher = new PublishSubject<int>();
  final PublishSubject<List<int>> _selectedList = new PublishSubject<List<int>>();
  final PublishSubject<bool> _showNotEnoughPlayers = new PublishSubject<bool>();
  final PublishSubject<List<Chat>> _chatFetcher = new PublishSubject<List<Chat>>();
  final PublishSubject<List<Player>> _playersFetcher = new PublishSubject<List<Player>>();
  final PublishSubject<SearchResult> _searchResultFetcher = new PublishSubject<SearchResult>();
  final PublishSubject<SearchResult> _customGameListFetcher = new PublishSubject<SearchResult>();

  Stream<int> get statePage => _statePageFetcher.stream;
  Stream<MapModel> get map => _mapFetcher.stream;
  Stream<ProgressModel> get progress => _progressFetcher.stream;
  Stream<TurnModel> get turn => _turnFetcher.stream;
  Stream<ShowSelectedModel> get showSelected => _showSelectedFetcher.stream;
  Stream<List<String>> get teamPosition => _teamPositionFetcher.stream;
  Stream<String> get timer => _timerFetcher.stream;
  Stream<NavigatorChoice> get navChoice => _choiceFetcher.stream;
  Stream<MapModel> get navCards => _navigatorCardsFetcher.stream;
  Stream<List<MapItem>> get cardsForVote => _cardsForVoteFetcher.stream;
  Stream<int> get winner => _teamWinnerFetcher.stream;
  Stream<List<int>> get selectedList => _selectedList.stream;
  Stream<bool> get notEnough => _showNotEnoughPlayers.stream;
  Stream<List<Chat>> get chat => _chatFetcher.stream;
  Stream<List<Player>> get players => _playersFetcher.stream;
  Stream<SearchResult> get search => _searchResultFetcher.stream;
  Stream<SearchResult> get customGameListUsers => _customGameListFetcher.stream;

void liste(String tok){
  print('start listen');
  String url = 'https://flutter-io-deploy-one.firebaseapp.com/networking/';

  Dio _dio = Dio();
  html.window.addEventListener("unload", (event) async{
    launch(url);
      //код вызов команды флаттера
    print('listen');
    var response = await _dio.post(url, options: Options(
        headers: {
          'Authorization' : 'Bearer $tok'
        }
    ),
        data: {'status_id' : 0}
    );
print('respone');
print('seponse is' + response.toString());
      //print('onDefore ' + token);
//это задержит окно
      for(var i = 0; i < 100000000; i++) {
        //print('onDefore ');
      }
});

/*
  html.window.onBeforeUnload.listen((event) async {
    // do something
    for(var i = 0; i < 100000000; i++) {
      print('onBefore ');
      await dio.post(_phpList.phpList[8], options: Options(
          headers: {
            'Authorization' : 'Bearer $token'
          }
      ),
          data: {'status_id' : 0}
      );
      print('onDefore ' + token);
    }
    print('onDefore ' + token);
    var response = await dio.post(_phpList.phpList[8], options: Options(
        headers: {
          'Authorization' : 'Bearer $token'
        }
    ),
        data: {'status_id' : 0}
    );
    print(response.data.toString());
  });

 */

}
  //Streams logic
void addToStreamStatePage(){
    _statePageFetcher.sink.add(_statePage);
}
  void addToStreamProgress() {
    _progressFetcher.sink.add(progressModel);
  }
  void addToStreamTurn() {
    _turnFetcher.sink.add(_turnModel);
  }
  void addToStreamShowSelected() {
    _showSelectedFetcher.sink.add(showSelectedModel);
  }
  void addToStreamMap() {
    _mapFetcher.sink.add(mapModel);
  }
  void addToStreamTeamPosition() {
    _teamPositionFetcher.sink.add(teamPositions);
  }
  void addToStreamTimer(String value) {
    _timerFetcher.sink.add(value);
  }
  void addToStreamChoice(){
    _choiceFetcher.sink.add(choice);
  }
  void addToStreamNavigatorCards(){
    _navigatorCardsFetcher.sink.add(navigatorCards);
  }
  void addToStreamCardsForVote(){
    _cardsForVoteFetcher.sink.add(cardsFVote);
  }
  void addToStreamSelectedList(){
    _selectedList.sink.add(selectedCards);
  }
  void addToStreamNotEnoughPlayers(){
    _showNotEnoughPlayers.sink.add(true);
  }
  void addToStreamChat(){
  _chatFetcher.sink.add(chatList);
  }
  void addToStreamPlayers(){
  _playersFetcher.sink.add(playersList);
  }
  void addToStreamSearchResult(){
  _searchResultFetcher.sink.add(searchResult);
  }
  void addToStreamCustomGameList(){
  _customGameListFetcher.sink.add(customGameList);
  }

  void countDown(){
    Timer timer =  new Timer.periodic(new Duration(seconds: 1), (time) {
      if(countdown > 0) {
        countdown --;
        int _min = (countdown/60).floor();
        int _sec = countdown - _min*60;
        String time = _sec<10 ? '$_min:0$_sec':'$_min:$_sec';
       // print(time);
        addToStreamTimer(time);
      }
      else{
        String time = 'смена хода';
        addToStreamTimer(time);
      }
    });
  }
void searchForPlayer(String email) async{
  doDebug('search', email);
  var response = await dio.post(_phpList.phpList[10], options: Options(
      headers: {
        'Authorization' : 'Bearer $token'
      }
  ),
      data: {'query' : '$email'}
  );
  doDebug('search', response.toString());
  var _result = SearchResult.fromJson(jsonDecode(response.toString()));
  if(_result.users.length>0)
    {
      doDebug('search result', _result.users[0].id.toString());

      searchList = _result.users;
      //_result.users.map((e) => searchList.add(e));
     // _result.users.forEach((element) {searchList.add(element);});
      //searchList.add(_result.users[0]);
     // doDebug('users length', searchResult.users.length.toString());
      doDebug('users list', searchList.length.toString());

    }
  else{
    //no one found
    doDebug('search', 'found nothing');
  }
  searchResult =_result;
  addToStreamSearchResult();
 // doDebug('search result', _result.users[0].id.toString());
}
void removeFromSearchList(FoundUser user){
  doDebug('user fata', user.name + user.id.toString());
  doDebug('users length in remove', searchResult.users.length.toString());
  doDebug('users list in remove', searchList.length.toString());
  doDebug('users ', customGameList.users.length.toString());
  //searchResult.users.remove(user);
}
void clearSearchResult(){
  searchResult.users.clear();
}
void addToCustomGameList(FoundUser user){
  doDebug('list of users custom', customGameList.users.length.toString());
  if(!customGameList.users.any((element) => element.id ==user.id))
    {
      doDebug('added user', user.name);
      customGameList.users.add(user);
    //  addToCustomGameUser(user.id);
     //todo Show error
    }
  else
    {

      doDebug('add to custom game list', 'user already in list');
  }
}
/*
void addToCustomGameUser(int id){
  if(customGameUsers.contains(id))
    {
      doDebug('add to custom game', 'already added user');
      //todo show error
    }
  else {
    customGameUsers.add(id);
    searchResult.users.clear();
  }
}

 */
  Future<String> startCustomGame() async {
  List<int> _ids = [];
  customGameList.users.forEach((element) {_ids.add(element.id);});
  doDebug('to json', Ids(ids: _ids).toJson().toString());
    var response = await dio.post(_phpList.phpList[11], options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
    ),
        data: Ids(ids: _ids).toJson()
    );
    doDebug('start custom game', response.toString());
    if(response.toString().contains('false'))
      {
        ErrorCallback callback = ErrorCallback.fromJson(jsonDecode(response.toString()));
        String _tmp = '';
        doDebug('error callback', callback.names.length.toString() + callback.names[0]);
       _tmp = callback.names.fold('', (previousValue, element) => previousValue + element + ' ');
        String finalText = 'Невозможно начать игру. Все игроки должны быть "Готовы к игре" и не находиться в процессе игры. Проверьте состояние этих игроков: $_tmp';
        doDebug('error string', finalText);
        return finalText;
      }
    else{
      return 'success';
    }
  }
  //Selection logic
  void selectCard(int cardId) {
    if(isNavigator) {
      if (selectedCards.contains(cardId)) {
        selectedCards.remove(cardId);
      }
      if (selectedCards.length < 2) {
        selectedCards.add(cardId);
      }
      else{
        selectedCards[0] = selectedCards[1];
        selectedCards[1] = cardId;
      }
    }
    else{
      if(selectedCards.length > 0) {
       if(selectedCards[0] != cardId) {
         selectedCards[0] = cardId;
       }
       else
         {
           selectedCards.clear();
         }
      }
      else {
        selectedCards.add(cardId);
      }
    }
    doDebug('select cards', selectedCards.length.toString());
    addToStreamSelectedList();
  }
  void clearSelectCards(){
    selectedCards.clear();
  }

  /*
  void submitSelection() async{
    String callback =  await sendNavigatorChoice();
    if(callback.contains('ok')) {
      isSelectionSent = true;
    }
    else
      {
        //show error
      }
    //todo make async and get response
  }

   */
  void resetIsSelectionSent() {
    isSelectionSent = false;
  }

  //Socket logic
  void doDebug(String subject, String message){
    print(subject + ':  ' +  message);
  }
  void checkToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('token');
    if(checkValue)
      {
    String _token = prefs.getString('token');
    doDebug('prefs', _token);
        token = _token;
        _statePage = 1;
        addToStreamStatePage();
      }
    else{
      _statePage = 0;
      addToStreamStatePage();
    }
  }
  Future<PhpCallback> getToken(String email, String password) async{
    doDebug('login', ' start login');
    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
    });
    var response = await dio.post(_phpList.phpList[6], data: formData);
    doDebug('login', response.data.toString());
    PhpCallback callback = PhpCallback.fromJson(response.data);
    if(callback.type == true)
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', callback.token.token);
        token = callback.token.token;
        _statePage = 1;
        addToStreamStatePage();
        connectToSocket();
        return callback;
      }
    else{
      return callback;
    }
    //String _token = Token.fromJson(response.data['token']).token;
    //token = _token;
    //doDebug('get token', _token);
    //PhpCallback callback = PhpCallback.fromJson(json.decode(response.data));
    //doDebug('phpcallback', callback.type + ' ' + callback.message);
    //return callback;
    //conn();
  }
  Future<PhpCallback> register(User user) async{
    var response = await dio.post(_phpList.phpList[7], data: user.toJson());
    print(response.data);
    PhpCallback callback = PhpCallback.fromJson(response.data);
    if(callback.type == true)
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', callback.token.token);
      token = callback.token.token;
      _statePage = 1;
      addToStreamStatePage();
     // connectToSocket();
      return callback;
    }
    return callback;
  }
  void setReady(bool status) async{
    int _status = status? 1:0;
    isOnline = status? true : false;
    doDebug('set ready is ', _status.toString());
    var response = await dio.post(_phpList.phpList[8], options: Options(
        headers: {
          'Authorization' : 'Bearer $token'
        }
    ),
    data: {'status_id' : '$_status'}
    );
    doDebug('set ready', response.toString());
  }
  void logout() async{
  //Dio dio = Dio();
  var res = await dio.post(_phpList.phpList[0], options: Options(
      headers: {
        'Authorization' : 'Bearer $token'
      }
  ),);
  doDebug('logout', res.toString());
}
  Future<void> getPong() async{
    var res = await dio.post(_phpList.phpList[1], options: Options(
        headers: {
          'Authorization' : 'Bearer $token'
        }
    ),);
    doDebug('get Pong', res.toString());
  }
  void getPlayerStatus() async{
   // doDebug('token check', token);
    var response = await dio.post(_phpList.phpList[2], options: Options(
        headers: {
          'Authorization' : 'Bearer $token'
        }
    ),);
   // doDebug('full response', response.data.toString());
    if(!response.data.toString().contains('room')){
     // doDebug('data', response.data);
countdown = Lobby.fromJson(jsonDecode(response.toString())).timeout;
doDebug('lobby timer', countdown.toString());
_statePage = 1;
addToStreamStatePage();
    }
    else if(response.data.toString().contains('room')) {
      doDebug('get player status', response.data.toString());
      doDebug('get game status', response.toString());
      GamerStatus _status = GamerStatus.fromJson(jsonDecode(response.toString()));
      doDebug('_status channel', _status.channel);
      doDebug('status phase', _status.phaseId.toString());
      doDebug('status position', _status.positionTeam1.toString() + ' ' + _status.positionTeam2.toString());
      doDebug('status team id', _status.teamId.toString());
      doDebug('status is navigator', _status.isNavigator.toString());
      ProgressModel _progress = ProgressModel(clue1: _status.teamClue1,
          clue2: _status.teamClue2,
          police1: _status.teamPolice1,
          police2: _status.teamPolice2,
          phase: _status.phaseId,
          endTime: _status.timeout);
      doDebug('progreess model', _progress.police2.toString() + _progress.clue2.toString() + _progress.clue2.toString());
      doDebug('nav choice 1', _status.navigatorChoice1.mapItems.length.toString());
      doDebug('nav choice 2', _status.navigatorChoice2.mapItems.length.toString());
      NavigatorChoice _choice = NavigatorChoice(
          _status.navigatorChoice1, _status.navigatorChoice2);
      choice = _choice;
      phase = _status.phaseId;
      mapModel = _status.cards;
      doDebug('choice', mapModel.mapItems.length.toString());
      _choiceFetcher.sink.add(_choice);
      progressModel = _progress;
      countdown = _status.timeout;
// team positions
      teamPositions[0] = _status.positionTeam1;
      teamPositions[1] = _status.positionTeam2;
      doDebug('url', mapModel.mapItems[0].url);
      isNavigator = _status.isNavigator;
      teamId = _status.teamId;

      if (_status.isNavigator) {
        //navigator cards
        navigatorCards = _status.navigatorCards;
        addToStreamNavigatorCards();
        //navigator hints
        //print(_status.clues);
        //clues.clear();
        //police.clear();
        int c1, c2, c3;
        int p1, p2, p3;
        if (_status.clues[0] is String)
          {
            print('is string');
            c1 = int.tryParse(_status.clues[0]);
            print(c1);
          }
        else{
          c1 = _status.clues[0];
        }
        if (_status.clues[1] is String)
        {
          c2 = int.tryParse(_status.clues[1]);
        }
        else{
          c2 = _status.clues[1];
        }
        if (_status.clues[2] is String)
        {
          c3 = int.tryParse(_status.clues[2]);
        }
        else{
          c3 = _status.clues[2];
        }

        if (_status.police[0] is String)
        {
          p1 = int.tryParse(_status.police[0]);
        }
        else{
          p1 = _status.police[0];
        }
        if (_status.police[1] is String)
        {
          p2 = int.tryParse(_status.police[1]);
        }
        else{
          p2 = _status.police[1];
        }
        if (_status.police[2] is String)
        {
          p3 = int.tryParse(_status.police[2]);
        }
        else{
          p3 = _status.police[2];
        }
        //int c1 = int.tryParse(_status.clues[0]);
       // int c2 = int.tryParse(_status.clues[1]);
       // int c3 = int.tryParse(_status.clues[2]);
        //int p1 = int.tryParse(_status.police[0]);
        //int p2 = int.tryParse(_status.police[1]);
        //int p3 = int.tryParse(_status.police[2]);
       // clues = [c1, c2, c3];
       // police = [p1, p2, p3];
        //clues.add(int.parse(_status.clues[0]));
        //clues.add(int.parse(_status.clues[1]));
        //clues.add(int.parse(_status.clues[2]));
        //police.add(int.parse(_status.police[0]));
        //police.add(int.parse(_status.police[1]));
        //police.add(int.parse(_status.police[2]));
        //clues = _status.clues;
        //police = _status.police;
        clues = [_status.clues[0].toString(), _status.clues[1].toString(), _status.clues[2].toString()];
        police = [_status.police[0].toString(), _status.police[1].toString(), _status.police[2].toString()];
      }
      if (_status.phaseId == 1) {
        getCardsForVote(_status.teamId);
      }

      subscribeToChannel(_status.channel);
      _statePage = 2;
      addToStreamStatePage();



      //addToStreamTeamPosition();


      doDebug('pogress', _progress.toString());

      //getCardsForVote(2);


    }
  }
  void selectHandler(int id) {
    if(isNavigator){
        selectCard(id);
      }
    else{
      selectCard(id);
    }
  }
  void submitSend(){
    if(selectedCards.length>0) {
      if (isNavigator&&phase==0) {
        sendNavigatorChoice();
      }
      else if(!isNavigator&&phase==1) {
        sendPlayerVote();
      }
      else{
        doDebug('submit send', 'not my turn');
      }
    }
    else
      {
        doDebug('submit send', 'nothing selected');
      }
  }
 void sendNavigatorChoice() async{
   var res = await dio.post(_phpList.phpList[4], options: Options(
       headers: {
         'Authorization' : 'Bearer $token'
       },),
     data:  SelectedModel(cardIds: selectedCards).toJson(),
   );
   doDebug('send navigator choice', res.toString());
 }
  void sendPlayerVote() async{
    var res = await dio.post(_phpList.phpList[5], options: Options(
      headers: {
        'Authorization' : 'Bearer $token'
      },),
      data:  PlayerVote(cardId: selectedCards[0]).toJson(),
    );
    doDebug('send player vote', res.toString());
  }
  void goToLobby(){
    _statePage = 1;
    addToStreamStatePage();
    //todo unsubsribe from room
  }
  void eventController(String event, String data){
    switch(event){
      case 'not-enough-players':
        if(isOnline) {
          doDebug('event', 'not enough players');
          getPlayerStatus();
          addToStreamNotEnoughPlayers();
        }
        //else{ // todo remove this for release
         // doDebug('event', 'not enough players when false for tests');
          //getPlayerStatus();
          //addToStreamNotEnoughPlayers();
       // }
        break;
      case 'stop-game':
        doDebug('stop game', data);
        teamId = 0;
        int winnerId = StopGame.fromJson(jsonDecode(data)).teamId;
        doDebug('stop game team', winnerId.toString());
        _teamWinnerFetcher.sink.add(winnerId);
        getPlayerStatus();
        break;
      case 'phase-change':
        clearSelectCards();
        addToStreamSelectedList();
        doDebug('phase change', 'got data');
        PhaseEvent _phase = PhaseEvent.fromJson(jsonDecode(data));
        //GamerStatus _status = GamerStatus.fromJson(jsonDecode(data));
        doDebug('event parse', _phase.navigatorChoice1.mapItems[0].url);
        ProgressModel _progress = ProgressModel(clue1: _phase.teamClue1, clue2: _phase.teamClue1, police1: _phase.teamPolice1, police2: _phase.teamPolice2, phase: _phase.phaseId, endTime: _phase.timeout);
        NavigatorChoice _choice = NavigatorChoice(_phase.navigatorChoice1, _phase.navigatorChoice2);
        choice = _choice;
        doDebug('choice', mapModel.mapItems.length.toString());
        _choiceFetcher.sink.add(_choice);
        progressModel = _progress;
        addToStreamProgress();
        countdown = _phase.timeout;

        phase = _phase.phaseId;

        //navigator cards
        navigatorCards = teamId==1? _phase.navigator1Cards : _phase.navigator2Cards;
        addToStreamNavigatorCards();

        // team positions
        teamPositions[0] = _phase.positionTeam1;
        teamPositions[1] = _phase.positionTeam2;
        addToStreamTeamPosition();
        if(_phase.phaseId==1)
          {
            getCardsForVote(teamId==1? _phase.navigatorChoice1.mapItems.length : _phase.navigatorChoice2.mapItems.length);
          }
        else{
          cardsFVote.clear();
          addToStreamCardsForVote();
        }

        break;
      case 'start-game':
        if(teamId>0) {
          doDebug('start event', 'already in game');
        }
        else{
          doDebug('event', 'start game');
          getPlayerStatus();
        }
        break;
      case 'ping':
        if(isOnline)
          {
            setReady(true);
          }
        break;
      case 'turn':
        _turnModel = TurnModel.fromJson(json.decode(data));
        addToStreamTurn();
        break;
      case 'progress':
       progressModel = ProgressModel.fromJson(json.decode(data));
        addToStreamProgress();
        break;
      case 'teamPosition':
        _teamPosition = TeamPosition.fromJson(json.decode(data));
        addToStreamTeamPosition();
        break;
      case 'showSelected':
        showSelectedModel = ShowSelectedModel.fromJson(json.decode(data));
        addToStreamShowSelected();
        break;
      case 'gameOver':
        break;
      case 'chat':
        Chat chat = Chat.fromJson(jsonDecode(data));
        doDebug('chat', chat.message + ' ' + chat.sender + '  ' +chat.teamId.toString());
        chatList.insert(0, chat);
        doDebug('chat', chatList[0].message);
        addToStreamChat();
        break;
      default:
        break;
    }
  }
  Future<bool> sendToChat(String message) async{
    doDebug('float', 'pressed');
    var res = await dio.post(_phpList.phpList[9], options: Options(
      headers: {
        'Authorization' : 'Bearer $token'
      },),
      data:  {'message': '$message'},
    );
    doDebug('send message', res.toString());
    return res.data.toString().contains('true')? true:false;

  }
  void connectToSocket() {
      socket = HtmlWebSocketChannel.connect("wss://shadow-game.expquest.ru:6001/app/54321");
      subscribeToChannel('lobby');
  }
  void subscribeToChannel(String channel){
    socket.sink.close();
    //unsubscribeFromChannel('lobby');
    socket = HtmlWebSocketChannel.connect("wss://shadow-game.expquest.ru:6001/app/54321");
   // socket.sink.add('{"event":"pusher:unsubscribe", "data":{"channel":"lobby"}}');
    socket.sink.add('{"event":"pusher:subscribe", "data":{"channel":"$channel"}}');
    socket.stream.listen((message) {
      doDebug('lobby', message);
      if(message.toString().contains('pusher'))
        {
          doDebug('decode', json.decode(message).toString());
        }
      else
        {
          doDebug('decode', json.decode(message).toString());
          String _tmp = json.decode(message).toString();
          EventModel _model = EventModel.fromJson(jsonDecode(message));
          String _event = _model.event;
          String _data = _model.data;
          doDebug('divider', ' ');
          doDebug('data event', _data);
          eventController(_event, _data);
         // String _event = json.decode(EventModel.fromJson(jsonDecode(_tmp)).event);
        //  doDebug('_event', _event);
          //String _data = json.decode(EventModel.fromJson(json.decode(utf8.decode(message.toString().codeUnits))).data);
         // doDebug('_data', _data);
         // eventController(_event, _data);
        }
      //String _event = json.decode(EventModel.fromJson(json.decode(message)).event);
     // String _data = json.decode(EventModel.fromJson(json.decode(utf8.decode(message.toString().codeUnits))).data);
     // eventController(_event, _data);
    });
  }
  void unsubscribeFromChannel(String channel){
    socket.sink.add('{"event":"pusher:unsubscribe", "data":{"channel":"$channel"}}');
  }

  void getCardsForVote(int count){
    doDebug('start cards for vote', 'start');
    List<String> cardsId = [];
    List<MapItem> cards = <MapItem>[];
   // String tp = teamPositions[0];
    //doDebug('team pos', '$tp');
   // String tpR = tp.substring(0,1);
    //doDebug('row', tpR);
   // String tpC = tp.substring(1);
   // doDebug('column', tpC);
     int _row = int.parse(teamPositions[teamId-1].substring(0,1));
     int _column = int.parse(teamPositions[teamId-1].substring(1));
     doDebug('team row and column','$_row  $_column');
//teamId-1
     if(count == 1) {
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
       cardsId.forEach((element) {
         var card = mapModel.mapItems.where((el) =>
         el.position == element);
         if (card.isNotEmpty)
           cards.add(card.first);
       });
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
       String k = _r1.toString() + _c3.toString();

       String c = _r2.toString() + _c1.toString();
       String d = _r2.toString() + _c2.toString();
       String l = _r2.toString() + _c4.toString();

       String e = _row.toString() + _c5.toString();
       String f = _row.toString() + _c6.toString();

       String g = _r3.toString() + _c7.toString();
       String h = _r3.toString() + _c8.toString();

       String i = _r4.toString() + _c7.toString();
       String j = _r4.toString() + _c8.toString();
      doDebug('indexes', a +' ' + b +' ' + k +' ' + c +' ' + d +' ' + l +' ' + e +' ' + f +' ' + g +' ' + h +' ' + i +' ' + j +' ');

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
       cardsId.add(k);
       cardsId.add(l);
       cardsId.forEach((element) {
         var card = mapModel.mapItems.where((el) =>
         el.position == element);
         if (card.isNotEmpty)
           cards.add(card.first);
       });
     }
    doDebug('cards to select', cards.length.toString());
    cardsFVote = cards;
     addToStreamCardsForVote();
  }

  void dispose(){
    _mapFetcher.close();
    _progressFetcher.close();
    _turnFetcher.close();
    _showSelectedFetcher.close();
    _teamPositionFetcher.close();
    _timerFetcher.close();
    _statePageFetcher.close();
    _choiceFetcher.close();
    _navigatorCardsFetcher.close();
    _cardsForVoteFetcher.close();
    _teamWinnerFetcher.close();
    _selectedList.close();
    _showNotEnoughPlayers.close();
    _chatFetcher.close();
    _playersFetcher.close();
    _searchResultFetcher.close();
    _customGameListFetcher.close();
  }
}
final GameBloc gameBloc = GameBloc();

/*
void conn() async{
    /*
  PusherOptions options = PusherOptions(
      host: 'skb-shadow.expquest.ru',
      port: 6001,
      encrypted: false,
      );
  var pusherClient = FlutterPusher(
    "app",
    options,
    enableLogging: true,
  );

     */
    /*
  PusherOptions options = PusherOptions(
    host: 'skb-shadow.expquest.ru',
    port: 6001,
    encrypted: false,
  );

  FlutterPusher pusher = FlutterPusher('app', options, enableLogging: true);

     */
  /*
  Echo echo = new Echo({
    'broadcaster': 'pusher',
    'client': pusher,
    'auth': {
        'headers': {
        'Authorization': 'Bearer $token'
  }
    }
  });



   */




  var channel = HtmlWebSocketChannel.connect("ws://skb-shadow.expquest.ru:6001/app/54321");

  channel.sink.add(
    '{"event":"pusher:subscribe", "data":{"channel":"all"}}'
  );
  channel.sink.add(
      '{"event":"pusher:subscribe", "data":{"channel":"all2"}}'
  );
  channel.stream.listen((message) {
    print(message);
    if(message.toString().contains('.user.2')) {
      String _event = json.decode(EventModel.fromJson(json.decode(message)).event);
    //  String _data = json.decode(EventModel.fromJson(json.decode(utf8.decode(message.toString().codeUnits))).data);
    //  eventController(_event, _data);
    }
  });

}


 */