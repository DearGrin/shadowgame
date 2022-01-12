import 'package:flutter/cupertino.dart';

class FoundUser{
  String name;
  int id;
  FoundUser({this.name, this.id});
  factory FoundUser.fromJson(Map<String, dynamic> parsedJson){
    return FoundUser(
      id: parsedJson['id'],
      name: parsedJson['name'],
    );
  }
}
class SearchResult{
  List<FoundUser> users;
  SearchResult({this.users});
  factory SearchResult.fromJson(Map<String, dynamic> parsedJson){
    var _list = parsedJson['users'] as List;
    List<FoundUser> _tmp = _list.map((e) => FoundUser.fromJson(e)).toList();
    return SearchResult(
      users: _tmp,
    );
  }
}
class Ids{
  List<int> ids;

  Ids({this.ids});

  Map<String, dynamic> toJson () =>{
    'ids':ids,
  };
}
class ErrorCallback{
  List<dynamic> names;
  ErrorCallback({this.names});
  factory ErrorCallback.fromJson(Map<String, dynamic> parsedJson){
    var _list = parsedJson['message'] as List;
    var _tmp = _list.map((e) => e).toList();
    return ErrorCallback(
      names: _tmp,
    );
  }
}