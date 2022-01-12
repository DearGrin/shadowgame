import 'package:rxdart/rxdart.dart';
import 'package:web/models/turn_model.dart';

class MyTeamStream{
  //final int i;
  //MyTeamStream(this.i);
  final PublishSubject<StatusModel> _progressFetcher = new PublishSubject<StatusModel>();
  Stream<StatusModel> get myTeamProgress => _progressFetcher.stream;
  StatusModel statusModel;
  void addToStream(){
    print('add to stream my status' + statusModel.clue.toString());
    _progressFetcher.sink.add(statusModel);
  }
  void saveModel(StatusModel _statusModel){
    statusModel = _statusModel;
    addToStream();
  }
  void ttt(){
    print('i can try');
    print('stream my status' + statusModel.clue.toString());
    addToStream();
  }
  void dispose(){
    _progressFetcher.close();
  }
}
//final MyTeamStream myTeamStream = MyTeamStream();
