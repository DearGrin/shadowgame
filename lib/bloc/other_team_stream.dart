import 'package:rxdart/rxdart.dart';
import 'package:web/models/turn_model.dart';

class OtherTeamStream{
  final PublishSubject<StatusModel> _progressFetcher = new PublishSubject<StatusModel>();
  Stream<StatusModel> get otherTeamProgress => _progressFetcher.stream;
  StatusModel statusModel;
  void addToStream(){
    _progressFetcher.sink.add(statusModel);
  }
  void saveModel(StatusModel _statusModel){
    statusModel = _statusModel;
    addToStream();
  }
  void dispose(){
    _progressFetcher.close();
  }
}
final OtherTeamStream myTeamStream = OtherTeamStream();
