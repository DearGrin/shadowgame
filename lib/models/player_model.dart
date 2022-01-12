
import 'package:json_annotation/json_annotation.dart';
import 'package:web/models/map_model.dart';

class PlayerModel{
  String uid;
  String role;
  int teamNumber;
  PlayerModel({this.uid, this.role, this.teamNumber});
  factory PlayerModel.fromJson(Map<String, dynamic> parsedJson){
    return PlayerModel(
      uid: parsedJson['uid'],
      role: parsedJson['role'],
      teamNumber: parsedJson['teamNumber'],
    );
  }
}

class SelectedModel{
  List<int> cardIds;
  SelectedModel({this.cardIds});
  Map<String, dynamic> toJson ()=>
      {
        'cardIds': cardIds
      };
}
class PlayerVote{
  int cardId;
  PlayerVote({this.cardId});
  Map<String, dynamic> toJson ()=>
      {
        'cardId': cardId
      };
}

class TeamPosition{
  int team1Position;
  int team2Position;
  TeamPosition({this.team1Position, this.team2Position});
  factory TeamPosition.fromJson(Map<String, dynamic> parsedJson){
    return TeamPosition(
      team1Position: parsedJson['team1Position'],
      team2Position: parsedJson['team2Position'],
    );
  }
}

class User{
  String name;
  String email;
  String password;
  User({this.name, this.email, this.password});
  Map<String, dynamic> toJson ()=>
      {
        'name': name,
        'email': email,
        'password': password,
      };
}

class GamerStatus{
  String channel;
  int teamId;
  bool isNavigator;
  String positionTeam1;
  String positionTeam2;
  int phaseId;
  int teamClue1;
  int teamClue2;
  int teamPolice1;
  int teamPolice2;
  int timeout;
  MapModel navigatorChoice1;
  MapModel navigatorChoice2;
  MapModel cards;
  MapModel navigatorCards;
  List<dynamic> clues;
  List<dynamic> police;
  GamerStatus({this.channel, this.teamId, this.isNavigator, this.positionTeam1, this.positionTeam2, this.phaseId, this.teamClue1, this.teamClue2, this.teamPolice1, this.teamPolice2, this.timeout, this.cards, this.navigatorChoice1, this.navigatorChoice2, this.navigatorCards, this.clues, this.police});
  factory GamerStatus.fromJson(Map<String, dynamic> parsedJson){
    bool isNull = parsedJson['navigator1_choice'].toString().contains('null');
    if(parsedJson['clue_cards'] != null){

      var _list = parsedJson['clue_cards'];
      List<dynamic> _tmp = _list.map((e) => e).toList();
      var _list2 = parsedJson['police_cards'];
      List<dynamic> _tmp2 = _list2.map((e) => e).toList();
      return GamerStatus(
        channel: parsedJson['channel'],
        teamId: parsedJson['team_id'],
        isNavigator: parsedJson['is_navigator'],
        //cards: _tmp,
        positionTeam1: parsedJson['position_team1'],
        positionTeam2: parsedJson['position_team2'],
        phaseId: parsedJson['phase_id'],
        teamClue1: parsedJson['team1_clue_count'],
        teamClue2: parsedJson['team2_clue_count'],
        teamPolice1: parsedJson['team1_police_count'],
        teamPolice2: parsedJson['team2_police_count'],
        timeout: parsedJson['timeout'],
        cards: MapModel.fromJson(parsedJson['cards']),
        navigatorCards: MapModel.fromJson(parsedJson['navigator_cards']),
        navigatorChoice1: isNull ? MapModel(mapItems: [
          MapItem(
              url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'),
          MapItem(
              url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album')
        ]) : MapModel.fromJson(parsedJson['navigator1_choice']),
        navigatorChoice2: isNull ? MapModel(mapItems: [
          MapItem(
              url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'),
          MapItem(
              url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album')
        ]) : MapModel.fromJson(parsedJson['navigator2_choice']),
        clues: _tmp,
        police: _tmp2,
      );
    }
    else{
      return GamerStatus(
        channel: parsedJson['channel'],
        teamId: parsedJson['team_id'],
        isNavigator: parsedJson['is_navigator'],
        //cards: _tmp,
        positionTeam1: parsedJson['position_team1'],
        positionTeam2: parsedJson['position_team2'],
        phaseId: parsedJson['phase_id'],
        teamClue1: parsedJson['team1_clue_count'],
        teamClue2: parsedJson['team2_clue_count'],
        teamPolice1: parsedJson['team1_police_count'],
        teamPolice2: parsedJson['team2_police_count'],
        timeout: parsedJson['timeout'],
        cards: MapModel.fromJson(parsedJson['cards']),
        navigatorChoice1: isNull ? MapModel(mapItems: [
          MapItem(
              url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'),
          MapItem(
              url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album')
        ]) : MapModel.fromJson(parsedJson['navigator1_choice']),
        navigatorChoice2: isNull ? MapModel(mapItems: [
          MapItem(
              url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'),
          MapItem(
              url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album')
        ]) : MapModel.fromJson(parsedJson['navigator2_choice']),

      );
    }
  }
}
class PhaseEvent{ // todo check for null in nav cards 1 and 2
  int phaseId;
  int timeout;
  int teamClue1;
  int teamClue2;
  int teamPolice1;
  int teamPolice2;
  String positionTeam1;
  String positionTeam2;
  MapModel navigatorChoice1;
  MapModel navigatorChoice2;
  MapModel navigator1Cards;
  MapModel navigator2Cards;
  PhaseEvent({this.phaseId, this.timeout, this.teamClue1, this.teamClue2, this.teamPolice1, this.teamPolice2, this.positionTeam1, this.positionTeam2, this.navigatorChoice1, this.navigatorChoice2, this.navigator1Cards, this.navigator2Cards});
  factory PhaseEvent.fromJson(Map<String, dynamic> parsedJson){
    bool isNull = parsedJson['navigator1_choice'].toString().contains('null');
    return PhaseEvent(
      phaseId: parsedJson['phase_id'],
      teamClue1: parsedJson['team1_clue_count'],
      teamClue2: parsedJson['team2_clue_count'],
      teamPolice1: parsedJson['team1_police_count'],
      teamPolice2: parsedJson['team2_police_count'],
      timeout: parsedJson['timeout'],
      positionTeam1: parsedJson['position_team1'],
      positionTeam2: parsedJson['position_team2'],
      navigatorChoice1: isNull?  MapModel(mapItems: [MapItem(url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'), MapItem(url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album')]) : MapModel.fromJson(parsedJson['navigator1_choice']),
      navigatorChoice2: isNull?  MapModel(mapItems: [MapItem(url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'), MapItem(url: 'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album')]) : MapModel.fromJson(parsedJson['navigator2_choice']),
      navigator1Cards: !isNull? MapModel.fromJson(parsedJson['navigator1_cards']) : [], // todo check this line
      navigator2Cards: !isNull? MapModel.fromJson(parsedJson['navigator2_cards']) : [], // todo check this line
    );
  }
}
class StopGame{
  int teamId;
  StopGame({this.teamId});
  factory StopGame.fromJson(Map<String, dynamic> parsedJson){
    return StopGame(
      teamId: parsedJson['team_id'],
    );
  }
}
class Chat{
  String sender;
  int teamId;
  String message;
  Chat({this.sender, this.teamId, this.message});
  factory Chat.fromJson(Map<String, dynamic> parsedJson){
    return Chat(
      sender: parsedJson['sender'],
      teamId: parsedJson['team_id'],
      message: parsedJson['message'],
    );
  }
}
class Player{
  String email;
  int id;
  Player({this.email, this.id});
  factory Player.fromJson(Map<String, dynamic> parsedJson){
    return Player(
      email: parsedJson['email'],
      id: parsedJson['id'],
    );
  }
}
class Lobby {
  int timeout;

  Lobby({this.timeout});

  factory Lobby.fromJson(Map<String, dynamic> parsedJson){
    return Lobby(
      timeout: parsedJson['timeout'],
    );
  }
}
class DefaultCard{
  MapModel cards = new MapModel(mapItems: [MapItem(url: 'https://sun9-8.userapi.com/impf/c855020/v855020144/1488ee/wYDeNxoxEI4.jpg?size=312x312&quality=96&proxy=1&sign=bc8172bb11057ab0f302ee6fdf46e433'), MapItem(url: 'https://sun9-8.userapi.com/impf/c855020/v855020144/1488ee/wYDeNxoxEI4.jpg?size=312x312&quality=96&proxy=1&sign=bc8172bb11057ab0f302ee6fdf46e433')]);
}