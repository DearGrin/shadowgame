import 'package:rxdart/rxdart.dart';
import 'package:web/models/highlight_model.dart';

class HighlightStream{
  final PublishSubject<HighlightModel> _highlightFetcher = new PublishSubject<HighlightModel>();
  Stream<HighlightModel> get highlight => _highlightFetcher.stream;
  HighlightModel highlightModel;
  void addToStream(){
    print('add to stream highlight');
    print(highlightModel.highlightCards);
    _highlightFetcher.sink.add(highlightModel);
  }
  void saveCards(HighlightModel _highlightModel){
    highlightModel = _highlightModel;
    addToStream();
  }
  void dispose(){
    _highlightFetcher.close();
  }
}
final HighlightStream highlightStream = HighlightStream();
