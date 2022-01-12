import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/api/general_api.dart';
import 'package:web/models/search_model.dart';

class ReadyListBloc extends GetxController{
  final GeneralApi _api = GeneralApi();
  SearchResult searchResult = SearchResult();
  SearchResult customGameList = SearchResult(users: []);
  final PublishSubject<SearchResult> _searchResultFetcher = new PublishSubject<SearchResult>();
  Stream<SearchResult> get search => _searchResultFetcher.stream;
  String searchInput;
  ValueNotifier<String> notify;
  Map<int,bool> getList = {0000000:false}.obs;

  void fetchReadyList() async {
    String token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    Map<String, dynamic> data = {};
    var response = await _api.post('all-ready', token, data);
    var _result = SearchResult.fromJson(response);
    searchResult = _result;
    addToStreamSearchResult();
  }
  void addToStreamSearchResult(){
    _searchResultFetcher.sink.add(searchResult);
  }
  void addToCustomGameList(FoundUser user){
    if(!customGameList.users.any((element) => element.id ==user.id))
    {
      customGameList.users.add(user);
      getList[user.id] = true;
      update([user.id]);
    }
    else
    {
      customGameList.users.remove(user);
      getList.remove(user.id);
      update([user.id]);
    }
  }
  Future<String> startCustomGame() async {
    String token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    List<int> _ids = [];
    customGameList.users.forEach((element) {_ids.add(element.id);});
    var response = await _api.post('create-self-room', token, Ids(ids: _ids).toJson());
    if(response['success'] == false)
    {
      //ErrorCallback callback = ErrorCallback.fromJson(response);
      print(response['message']);

      // doDebug('error callback', callback.names.length.toString() + callback.names[0]);
      //_tmp = callback.names.fold('', (previousValue, element) => previousValue + element + ' ');
      //String finalText = 'Невозможно начать игру. Все игроки должны быть "Готовы к игре" и не находиться в процессе игры. Проверьте состояние этих игроков: $_tmp';
      if(response['message'] == 'The ids field is required.' || response['message'] == 'The ids must be at least 3 characters.')
        {
          notify.value = 'требуется выбрать минимум 3х игроков для начала игры';
        }
      else {
        ErrorCallback callback = ErrorCallback.fromJson(response);
        String _tmp = '';
        _tmp = callback.names.fold('', (previousValue, element) => previousValue + element + ' ');
        String finalText = 'Невозможно начать игру. Все игроки должны быть "Готовы к игре" и не находиться в процессе игры. Проверьте состояние этих игроков: $_tmp';
        notify.value = finalText;
      }
      return response['message'].toString();
    }
    else{
      notify.value = 'успех! Игра сейчас начнется';
      return 'успех! Игра сейчас начнется';
    }
  }
  void changeInput(String value){
    searchInput = value;
    print('input is $searchInput');
  }
  void resetInput(){
    searchInput = '';
  }
  void addPlayerViaSearch(String value){
    FoundUser  u;
    try {
      u = searchResult.users.firstWhere((element) => element.name==value);
    } catch (e, s) {
      //print(s);
      u = FoundUser();
    } finally{
      print(u.name!=null);
    }

    if(u.name!=null)
      {
        if (!customGameList.users.any((element) => element.id ==u.id))
          {
            customGameList.users.add(u);
            getList[u.id] = true;
            update([u.id]);
            notify.value = 'игрок добавлен';
          }
        else{
          // already has user
          notify.value = 'этот игрок уже добавлен список игры';
        }
      }
    else{
      //no user
      notify.value='игрок не найден: проверьте имя или статус "готов" у данного игрока';
    }

   }
  void addPlayerViaSearchButton(){
    addPlayerViaSearch(searchInput);
  }
  void getNotifier (ValueNotifier<String> notifier){
   notify = notifier;
  }
  void dispose(){
    _searchResultFetcher.close();
  }
}