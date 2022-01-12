class TurnModel{
  int phase;
  int endTime;
  TurnModel({this.phase,this.endTime});
  //todo remove if possible this under
  factory TurnModel.fromJson(Map<String, dynamic> parsedJson){
    return TurnModel(
      phase: parsedJson['phase'],
      endTime: parsedJson['endTime'],
    );
  }
}

class ProgressModel{
  int clue1;
  int clue2;
  int police1;
  int police2;
  int phase;
  int endTime;
 // ProgressModel(this.clue1, this.clue2, this.police1, this.police2, this.phase, this.endTime);

  ProgressModel({this.clue1, this.clue2, this.police1, this.police2, this.phase, this.endTime});
  factory ProgressModel.fromJson(Map<String, dynamic> parsedJson){
    return ProgressModel(
      clue1: parsedJson['clue1'],
      clue2: parsedJson['clue2'],
      police1: parsedJson['police1'],
      police2: parsedJson['police2'],
      phase: parsedJson['phase'],
      endTime: parsedJson['endTime'],
    );
  }


}

class StatusModel{
  int clue;
  int police;
  StatusModel({this.clue, this.police});
}
