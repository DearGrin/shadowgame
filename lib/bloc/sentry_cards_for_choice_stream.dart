import 'package:web/api/general_api.dart';
import 'package:web/models/map_model.dart';
import 'package:rxdart/rxdart.dart';

class SentryCardsForChoiceStream{
  final String token;
  SentryCardsForChoiceStream(this.token);
  GeneralApi _api = GeneralApi();
  final PublishSubject<List<MapItem>> _sentryCardsFetcher = new PublishSubject<List<MapItem>>();
  Stream<List<MapItem>> get sentryCards => _sentryCardsFetcher.stream;
  final PublishSubject<List<int>> _selectedFetcher = new PublishSubject<List<int>>();
  Stream<List<int>> get selectedCardsList => _selectedFetcher.stream;
  List<MapItem> cards = [];
  List<int> selectedCards = [];

  void addToStream(){
    _sentryCardsFetcher.sink.add(cards);
  }
  void addToStreamSelected(){
    _selectedFetcher.sink.add(selectedCards);
  }
  void saveCards(List<MapItem> _cards)
  {
    cards = _cards;
    print('sentry cards length is' + cards.length.toString());
    clearSelected();
    addToStream();
  }
  Future<bool> confirm() async {
    if(selectedCards.length>0)
    {
      print(selectedCards.toString() + 'sending choice');
      var i = selectedCards[0];
      Map<String, dynamic> data = {'cardId':i};
      var res = await _api.post('gamer-vote', token, data);
      print(res.toString());
      return res['success'];
    }
    else{
      return false;
    }
  }
  void onSelect(int id){
    if(selectedCards.contains(id))
    {
      selectedCards.remove(id);
    }
    else if(selectedCards.length<1)
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

  void dispose(){
    _sentryCardsFetcher.close();
    _selectedFetcher.close();
  }

}
//final SentryCardsForChoiceStream sentryCardsForChoiceStream = SentryCardsForChoiceStream();