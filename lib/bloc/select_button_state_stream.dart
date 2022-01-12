import 'package:rxdart/rxdart.dart';

class SelectButtonStateStream{
  final PublishSubject<String> _selectButtonFetcher = new PublishSubject<String>();
  Stream<String> get selectButtonState => _selectButtonFetcher.stream;
  String status;

  void addToStream(){
    _selectButtonFetcher.sink.add(status);
  }
  void saveStatus(String _status){
    status = _status;
    addToStream();
  }
  void dispose(){
    _selectButtonFetcher.close();
  }
}
final SelectButtonStateStream selectButtonStateStream = SelectButtonStateStream();
