import 'package:rxdart/rxdart.dart';
import 'package:web/models/map_model.dart';

class MyNavChosenCards{
  final PublishSubject<List<MapItem>> _myNavChosenCardsFetcher = new PublishSubject<List<MapItem>>();
  Stream<List<MapItem>> get navCards => _myNavChosenCardsFetcher.stream;
  List<MapItem> items;
  void addToStream(){
    if(items != null)
        _myNavChosenCardsFetcher.sink.add(items);
    else{
      print('items are null');
    }

  }
  void saveItems(List<MapItem> cards)
  {
    items = cards;
    addToStream();
  }
  void dispose(){
    _myNavChosenCardsFetcher.close();
  }
}
final MyNavChosenCards myNavChosenCards = MyNavChosenCards();
