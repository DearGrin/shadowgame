
import 'dart:convert';
import 'package:web/bloc/auth.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/api/general_api.dart';
import 'package:web/bloc/login_bloc.dart';
import 'package:web/bloc/master_bloc.dart';
import 'package:web/bloc/ready_list_bloc.dart';
import 'package:web/bloc/rules_bloc.dart';
import 'package:web/models/evnet_model.dart';
import 'package:web/models/player_model.dart';
import 'package:web_socket_channel/html.dart';

class Controller{
  final Auth auth = Auth();
  bool isOnline = false;
  int currentPage = 0;
  String token;
  HtmlWebSocketChannel socket;
  Function onChangePage;
  Function onOnlineChange;
  Function onToken;
  Function onCheck;
  MasterBloc masterBloc;
 // final Auth auth = Auth();
  final GeneralApi _api = GeneralApi();
  final PublishSubject<int> _statePageFetcher = new PublishSubject<int>();
  final PublishSubject<bool> _showNotEnoughPlayers = new PublishSubject<bool>();
  final PublishSubject<int> _lobbyTimer = new PublishSubject<int>();

  Stream<bool> get notEnough => _showNotEnoughPlayers.stream;
  Stream<int> get statePage => _statePageFetcher.stream;
  Stream<int> get lobbyT => _lobbyTimer.stream;

  var response;

  //final LoginBloc loginBloc = LoginBloc(t);

  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('token');

    if(checkValue)
    {
      print('found token');
      token = prefs.getString('token');
      changePage(1);
    }
    else{
      print('found no token');
      changePage(0);
     //checkUri();
     // var r = await auth.testGoogle();
      //response = r;
     // print(response);
      //currentPage = 0;
      //addToStreamPage();
    }
  }
  Future<void> checkUri() async {
   // html.Location currentLocation = html.window.location;
    //var h = currentLocation.href;
   // print(h);
    /*
    if(h.contains('token'))
    {
      print('contains token');
      final JWTConvert jwt = JWTConvert();
      String user = await jwt.convertJWT(h.substring(32));
     await logOrRegister(user);
    }
    else
      {

     */
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print('storage has key' + prefs.containsKey('sub').toString());
        if(prefs.containsKey('sub'))
        {
          print('storage contains sub');
          String sub = prefs.getString('sub');
          await  logOrRegister(sub);
        }
        else
          {
          print('storage contains NO sub');
          auth.testKontur();
        }
      //}
  }
  Future<void> logOrRegister(String user) async{
    print('log in $user');
    print(user.split('\\')[1]);
    String name = user.split('\\')[1];
    String email = '$name'+ '@skbkontur.ru';
    print(email);
    FormData formData = FormData.fromMap({
      'email': email,
      'password': '987456321',
    });
    var r = await _api.postLogin('login', formData);
    PhpCallback callback = PhpCallback.fromJson(r.data);
    if(callback.type == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', callback.token.token);
      prefs.setString('sub', name);
      token = callback.token.token;
      changePage(1);
    }
    else {
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'password': '987456321',
      });
      var r = await _api.postLogin('register', formData);
      PhpCallback callback = PhpCallback.fromJson(r.data);
      if(callback.type == true){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', callback.token.token);
        prefs.setString('sub', name);
        token = callback.token.token;
        changePage(1);
      }
      else{
        print('error');
        print(callback.message);
      }
    }
  }
  LoginBloc setLoginBloc(){
    onChangePage = (){getUserStatus();};
    onToken = (value){token = value;};
    onCheck = (){checkUri();};
    final LoginBloc loginBloc = LoginBloc(onChangePage, onToken, onCheck);
    return loginBloc;
  }
  RulesBloc setRulesBloc() {
    print('setting rules bloc');
    onOnlineChange = (value){isOnline = value;};
    //connectToSocket();
    final RulesBloc rulesBloc = RulesBloc(onOnlineChange, notEnough, lobbyT, token);
    rulesBloc.countDown();
    getUserStatus();
    return rulesBloc;
  }
  MasterBloc setMasterBloc(){
    final MasterBloc bloc = MasterBloc((){getUserStatus();});
    masterBloc = bloc;
    bloc.setToken(token);
    bloc.setStreams();
    //getUserStatus();
    return bloc;
  }
  void addToStreamPage(){
    _statePageFetcher.sink.add(currentPage);
  }
  void addToStreamNotEnoughPlayers(bool _){
    _showNotEnoughPlayers.sink.add(_);
    Future.delayed(Duration(seconds: 1), (){_showNotEnoughPlayers.sink.add(false);});
  }
  void addToStreamCountDown(int count){
    _lobbyTimer.sink.add(count);
  }

  ///socket connections
  void connectToSocket() {
    //socket = HtmlWebSocketChannel.connect("wss://shadow-game.expquest.ru:6001/app/54321");
    print('connect to socket');
    subscribeToChannel('lobby');
  }
  Future<void> subscribeToChannel(String channel) async {
    print('sub to channel');
    if(socket != null)
      {
        socket.sink.close(1000);
      }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String p = prefs.getString('path') +':6001/app/54321';
    String path = 'wss://' + p;
    //socket = HtmlWebSocketChannel.connect("wss://shadow-game.expquest.ru:6001/app/54321");
    socket = HtmlWebSocketChannel.connect(path);
    //socket.sink.close();
   // socket = HtmlWebSocketChannel.connect("wss://shadow-game.expquest.ru:6001/app/54321");
    socket.sink.add('{"event":"pusher:subscribe", "data":{"channel":"$channel"}}');
    socket.stream.listen((message) {
      if(message.toString().contains('pusher'))
      {
        //doDebug('decode', json.decode(message).toString());
      }
      else
      {
       // doDebug('decode', json.decode(message).toString());
        String _tmp = json.decode(message).toString();
        EventModel _model = EventModel.fromJson(jsonDecode(message));
        String _event = _model.event;
        String _data = _model.data;
        //doDebug('divider', ' ');
        //doDebug('data event', _data);
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

  /// handle events from socket
  void eventController(String event, var data){
    print('got event $event');
    switch(event){
      case 'not-enough-players':
        if(isOnline && currentPage ==1){
          handleNotEnoughPlayers(true);
          addToStreamCountDown(1800);
        }
        else if (!isOnline && currentPage == 1)
          {
            addToStreamCountDown(1800);
            handleNotEnoughPlayers(false);
          }
        break;
      case 'stop-game':
        var _r4 = jsonDecode(data);
        handleGameOver(_r4);
        break;
      case 'phase-change':
        //Response _r = data as Response;
        var _r2 = jsonDecode(data);
        print('got phase change');
        //print(_r2['room_id'].toString());
        //masterBloc.manageGame(data, 1);
        handleTurn(_r2);
        break;
      case 'start-game':
        handleStartGame();
        break;
      case 'ping':
        if (isOnline && currentPage == 1)
          handlePing();
        break;
      case 'chat':
        print('????//////////');
        var _r3 = jsonDecode(data);
        handleChat(_r3);
        break;
      default:
        break;
    }
  }

  void getUserStatus() async {
    //some stuff here
    Map<String, dynamic> data = {'empty':'empty'};
    var response = await _api.post('gamer-status', token, data);
    //if room and other things
    if (response.toString().contains('room')){
      setMasterBloc();
      await masterBloc.setGame(response);
      subscribeToChannel(response['channel']);
      changePage(2);
      masterBloc.pushStreams();
    }
    //if not room
    else {
      int countdown = Lobby
          .fromJson(response)
          .timeout;
      changePage(1);
      addToStreamCountDown(countdown);
      connectToSocket();
      print(countdown);
      //addToStreamCountDown(countdown);
    }
  }
  void handleTurn(var data){
    //some stuff here
    masterBloc.manageGame(data, 1);
  }
  void handleChat(var data){
    //some stuff here
    //print('got message of ' + data.runtimeType.toString());
    //String response = '';
    //Chat mes = Chat.fromJson(data);
    //print(data);
    masterBloc.showChat(data);
  }
  void handleGameOver(var data){
    StopGame stop = StopGame.fromJson(data);
    masterBloc.handleStopGame(stop.teamId);
    isOnline = false;
    //getUserStatus();
  }
  void handleNotEnoughPlayers(bool _isOnline){
    if(_isOnline) {
      addToStreamNotEnoughPlayers(_isOnline);
      getUserStatus();
    }
    else{
      addToStreamNotEnoughPlayers(_isOnline);
    }
  }
  void handleStartGame() async{
    await Future.delayed(const Duration(seconds: 1), (){getUserStatus();});
  }
  void handlePing(){
    print('handle ping');
    if(isOnline)
    {
      setReady(true);
    }
  }
  void setReady(bool status) async{
    int _status = status? 1:0;
    isOnline = true;
    print('set in bloc $_status');
    //isOnline = status? true : false;
    // doDebug('set ready is ', _status.toString());
    Map<String, dynamic> data = {'status_id':'$_status'};
    var response = await _api.post('set-ready', token, data);
    print(response.toString());
    //doDebug('set ready', response.toString());
  }

  void changePage(int value){
    currentPage = value;
    //print('change page to $value');
    addToStreamPage();
  }
  void dispose(){
    _statePageFetcher.close();
    _showNotEnoughPlayers.close();
    _lobbyTimer.close();
    socket.sink.close();
  }
}