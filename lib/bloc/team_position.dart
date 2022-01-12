import 'package:rxdart/rxdart.dart';

class TeamPosition{
  final PublishSubject<String> teamPositionFetcher = new PublishSubject<String>();
  Stream<String> get teamPositionStream => teamPositionFetcher.stream;
  void addToStream(String position){
    teamPositionFetcher.sink.add(position);
  }
  void dispose(){
    teamPositionFetcher.close();
  }
}
final TeamPosition teamPosition = TeamPosition();