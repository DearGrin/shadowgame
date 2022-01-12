import 'package:json_annotation/json_annotation.dart';

class MapModel{
  List<MapItem> mapItems;
  MapModel({this.mapItems});
  factory MapModel.fromJson(List<dynamic> parsedJson){
    var _list = parsedJson;
    List<MapItem> _tmp = _list.map((e) => MapItem.fromJson(e)).toList();
    return MapModel(
      mapItems: _tmp,
    );
  }
}

class MapItem{
  int id;
  int row;
  int column;
  String url;
  String position;
  String description;
  //bool hasTeam1;
  //bool hasTeam2;
  //bool hasClue1;
  //bool hasClue2;
  //bool hasPolice;
  //bool hasExit;
  MapItem({this.id, this.row, this.column, this.url,this.position, this.description});
  //this.hasTeam1, this.hasTeam2, this.hasClue1, this.hasClue2, this.hasPolice, this.hasExit
  factory MapItem.fromJson(Map<String, dynamic> parsedJson){
    return MapItem(
      id: parsedJson['id'],
      row: parsedJson['row'],
      column: parsedJson['column'],
      url: parsedJson['url'],
      position: parsedJson['position'],
     description: parsedJson['description'].toString(),

      //hasTeam1: parsedJson['hasTeam1'],
      //hasTeam2: parsedJson['hasTeam2'],
      //hasClue1: parsedJson['hasClue1'],
      //hasClue2: parsedJson['hasClue2'],
    //  hasPolice: parsedJson['hasPolice'],
  //    hasExit: parsedJson['hasExit'],
    );
  }
}
class NavigatorChoice{
  MapModel navigatorChoice1;
  MapModel navigatorChoice2;
  NavigatorChoice(this.navigatorChoice1, this.navigatorChoice2);
}

class ShowSelectedModel{
  List<MapItem> team1Cards;
  List<MapItem> team2Cards;
  ShowSelectedModel({this.team1Cards, this.team2Cards});
  factory ShowSelectedModel.fromJson(Map<String, dynamic> parsedJson){
    var _list1 = parsedJson['team1Cards'];
    var _list2 = parsedJson['team2Cards'];
    List<MapItem> _tmp1 = _list1.map((e) => MapItem.fromJson(e)).toList();
    List<MapItem> _tmp2 = _list2.map((e) => MapItem.fromJson(e)).toList();
    return ShowSelectedModel(
      team1Cards: _tmp1,
      team2Cards: _tmp2,
    );
  }
}