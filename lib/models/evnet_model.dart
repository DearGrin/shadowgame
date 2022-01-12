class EventModel{
String channel;
String event;
String data;
EventModel({this.channel, this.event, this.data});
factory EventModel.fromJson(Map<String, dynamic> parsedJson){
  return EventModel(
    channel: parsedJson['channel'],
    event:  parsedJson['event'],
    data: parsedJson['data'],
    );
  }
}

class EventData{
  String data;
  EventData({this.data});
  factory EventData.fromJson(Map<String, dynamic> parsedJson){
    return EventData(
      data: parsedJson['data']
    );
  }
}

class Token{
  String token;
  Token({this.token});
  factory Token.fromJson(Map<String, dynamic> parsedJson){
    return Token(
      token: parsedJson['token']
    );
  }
}
class Email{
  List<String> email;
  Email({this.email});
  factory Email.fromJson(Map<String, dynamic> parsedJson){
    var streetsFromJson  = parsedJson['email'];
    List<String> streetsList = streetsFromJson.cast<String>();
    return Email(
      email: streetsList,
    );
  }
}

class PhpCallback{
  bool type;
  String message;
  Token token;
  PhpCallback({this.type, this.message, this.token});
  factory PhpCallback.fromJson(Map<String, dynamic> parsedJson){
    return PhpCallback(
      type: parsedJson['success'],
      message: parsedJson['success']==true? '': parsedJson['message'],
      token: parsedJson['success']==true? Token.fromJson(parsedJson['token']): Token(),
    );
  }
}
class PhpRegCallback{
  bool type;
  List<String> emails;
  Token token;
  PhpRegCallback({this.type, this.emails, this.token});
  factory PhpRegCallback.fromJson(Map<String, dynamic> parsedJson){
    return PhpRegCallback(
      type: parsedJson['success'],
      emails: parsedJson['success']==true? '': parsedJson['message'],
      token: parsedJson['success']==true? Token.fromJson(parsedJson['token']): Token(),
    );
  }
}
