import 'package:rxdart/rxdart.dart';
import 'package:web/models/map_model.dart';

class OtherNavChosenCards{
  final PublishSubject<List<MapItem>> _otherNavChosenCardsFetcher = new PublishSubject<List<MapItem>>();
  Stream<List<MapItem>> get navCards => _otherNavChosenCardsFetcher.stream;
  List<MapItem> items = [];
  void addToStream(){
   // if(items != null)
      _otherNavChosenCardsFetcher.sink.add(items);
  }
  void saveItems(List<MapItem> _items)
  {
    items = _items;
    addToStream();
  }
  void dispose(){
    _otherNavChosenCardsFetcher.close();
  }
}
final OtherNavChosenCards otherNavChosenCards = OtherNavChosenCards();
