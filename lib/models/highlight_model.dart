import 'package:web/models/map_model.dart';

class HighlightModel{
  List<String> teamPositions;
  String myPosition;
  List<String> highlightCards;
  List<MapItem> cards;
  HighlightModel(this.teamPositions, this.myPosition, this.highlightCards, this.cards);
}