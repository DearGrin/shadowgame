import 'package:web/api/general_api.dart';
import 'package:web/models/map_model.dart';
import 'package:rxdart/rxdart.dart';

class NavCardsForChoice{
  final String token;
  NavCardsForChoice(this.token);
  GeneralApi _api = GeneralApi();
  final PublishSubject<List<MapItem>> _navigatorCardsFetcher = new PublishSubject<List<MapItem>>();
  Stream<List<MapItem>> get navCards => _navigatorCardsFetcher.stream;
  final PublishSubject<List<int>> _selectedFetcher = new PublishSubject<List<int>>();
  Stream<List<int>> get selectedCardsList => _selectedFetcher.stream;
  List<MapItem> cards = [];
  List<int> selectedCards = [];

  void addToStream(){
    print('handle add to stream cards for choice nav' + cards.length.toString());
    _navigatorCardsFetcher.sink.add(cards);
  }
  void addToStreamSelected(){
    _selectedFetcher.sink.add(selectedCards);
  }
  void saveCards(List<MapItem> _cards, int phase)
  {
    if(phase==0) {
      cards = _cards;
      clearSelected();
      addToStream();
    }
    else{
      cards = [];
      clearSelected();
      addToStream();
    }
  }
  void onSelect(int id){
    if(selectedCards.contains(id))
    {
      selectedCards.remove(id);
    }
    else if(selectedCards.length<2)
      {
        selectedCards.add(id);
      }
    else
      {
        selectedCards.removeAt(0);
        selectedCards.add(id);
      }
    addToStreamSelected();
    print('selected cards :'+ selectedCards.toString());
  }
  void clearSelected(){
    selectedCards.clear();
  }
  Future<bool> confirm() async {
    if(selectedCards.length>0)
      {
        print(selectedCards.toString() + 'sending choice');
        Map<String, dynamic> data = {'cardIds':selectedCards};
        var res = await _api.post('navigator-choice', token, data);
        print(res.toString());
        return res['success'];
      }
    else{
      return false;
    }
  }
  void dispose(){
    _navigatorCardsFetcher.close();
    _selectedFetcher.close();
}

}
//final NavCardsForChoice navCardsForChoice = NavCardsForChoice();