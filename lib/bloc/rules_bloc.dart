
import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:web/api/general_api.dart';
import 'package:web/models/search_model.dart';

class RulesBloc{
  final Function onlineChange;
  final Stream<bool> notEnough;
  final Stream<int> lobbyTimer;
  final String token;
  RulesBloc(this.onlineChange, this.notEnough, this.lobbyTimer, this.token);
  final GeneralApi _api = GeneralApi();
  SearchResult searchResult = SearchResult();
  List<FoundUser> searchList = [];
  SearchResult customGameList = SearchResult(users: []);
  Timer watch;
  int countdown = 0;
  final PublishSubject<SearchResult> _searchResultFetcher = new PublishSubject<SearchResult>();
  final PublishSubject<SearchResult> _customGameListFetcher = new PublishSubject<SearchResult>();
  final PublishSubject<String> _timerFetcher = new PublishSubject<String>();
  Stream<SearchResult> get search => _searchResultFetcher.stream;
  Stream<SearchResult> get customGameListUsers => _customGameListFetcher.stream;
  Stream<String> get timer => _timerFetcher.stream;

  /// handle isOnline
  void setReady(bool status) async{
    int _status = status? 1:0;
    onlineChange(status);
    print('set in bloc $_status');
    //isOnline = status? true : false;
   // doDebug('set ready is ', _status.toString());
    Map<String, dynamic> data = {'status_id':'$_status'};
    var response = await _api.post('set-ready', token, data);
    //print(response.toString());
    //doDebug('set ready', response.toString());
  }

  ///handle custom game setup
  void searchForPlayer(String email) async{
    Map<String, dynamic> data = {'query':'$email'};
    var response = await _api.post('search', token, data);
    var _result = SearchResult.fromJson(response);
    if(_result.users.length>0)
    {
      searchList = _result.users;
    }
    else{

    }
    searchResult =_result;
    addToStreamSearchResult();
  }
  void addToCustomGameList(FoundUser user){
    //doDebug('list of users custom', customGameList.users.length.toString());
    if(!customGameList.users.any((element) => element.id ==user.id))
    {
     // doDebug('added user', user.name);
      customGameList.users.add(user);
      //  addToCustomGameUser(user.id);
      //todo Show error
    }
    else
    {
      //doDebug('add to custom game list', 'user already in list');
    }
  }
  void clearSearchResult(){
    searchResult.users.clear();
  }
  Future<String> startCustomGame() async {
    List<int> _ids = [];
    customGameList.users.forEach((element) {_ids.add(element.id);});
    //doDebug('to json', Ids(ids: _ids).toJson().toString());
    var response = await _api.post('create-self-room', token, Ids(ids: _ids).toJson());
    //doDebug('start custom game', response.toString());
    if(response['success'] == false)
    {
      ErrorCallback callback = ErrorCallback.fromJson(response);
      String _tmp = '';
     // doDebug('error callback', callback.names.length.toString() + callback.names[0]);
      _tmp = callback.names.fold('', (previousValue, element) => previousValue + element + ' ');
      String finalText = 'Невозможно начать игру. Все игроки должны быть "Готовы к игре" и не находиться в процессе игры. Проверьте состояние этих игроков: $_tmp';
      //doDebug('error string', finalText);
      return finalText;
    }
    else{
      return 'success';
    }
  }

  void countDown(){
    print('start listen to count');
    lobbyTimer.listen((value) {countdown = value;});
    if(watch != null)
      watch.cancel();
    watch =  new Timer.periodic(new Duration(seconds: 1), (time) {
      if(countdown > 0) {
        countdown --;
        int _min = (countdown/60).floor();
        int _sec = countdown - _min*60;
        String time = _sec<10 ? '$_min:0$_sec':'$_min:$_sec';
        // print(time);
        addToStreamTimer(time);
      }
      else{
        String time = '0:00';
        addToStreamTimer(time);
      }
    });



  }
  /// handle streams
  void addToStreamSearchResult(){
    _searchResultFetcher.sink.add(searchResult);
  }
  void addToStreamCustomGameList(){
    _customGameListFetcher.sink.add(customGameList);
  }
  void addToStreamTimer(String value) {
    _timerFetcher.sink.add(value);
  }
  void dispose(){
    _searchResultFetcher.close();
    _customGameListFetcher.close();
    _timerFetcher.close();
    watch.cancel();
  }
}