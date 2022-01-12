import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:web/models/turn_model.dart';

class StatusStream{
  final PublishSubject<TurnModel> _statusFetcher = new PublishSubject<TurnModel>();
  Stream<TurnModel> get status => _statusFetcher.stream;
  TurnModel turnModel;
  void addToStream(){
    _statusFetcher.sink.add(turnModel);
  }
  void saveModel(TurnModel _turnModel){
    turnModel = _turnModel;
    addToStream();
  }
  void dispose(){
    _statusFetcher.close();
  }
}
final StatusStream statusStream = StatusStream();
