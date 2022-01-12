
import 'package:flutter/material.dart';
import 'package:web/models/map_model.dart';
import 'package:web/ui/game_card.dart';

class GameBoard extends StatefulWidget{
  final List<MapItem> srcs;
  GameBoard(this.srcs);
  @override
  State<StatefulWidget> createState() {
    return GameBoardState();
  }
}

class GameBoardState extends State<GameBoard>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700.0,
      height: 600.0,
      child: Stack(
        children: [
          Positioned(
            left: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameCard(widget.srcs[0].url, widget.srcs[0].id, widget.srcs[1].description),
                GameCard(widget.srcs[1].url, widget.srcs[1].id, widget.srcs[1].description),
                GameCard(widget.srcs[2].url, widget.srcs[2].id, widget.srcs[2].description),
                GameCard(widget.srcs[3].url, widget.srcs[3].id, widget.srcs[3].description),
              ],
            ),
          ),

          Positioned(
            top: 75.0,
            left: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameCard(widget.srcs[4].url, widget.srcs[4].id, widget.srcs[4].description),
                GameCard(widget.srcs[5].url, widget.srcs[5].id, widget.srcs[5].description),
                GameCard(widget.srcs[6].url, widget.srcs[6].id, widget.srcs[6].description),
                GameCard(widget.srcs[7].url, widget.srcs[7].id, widget.srcs[7].description),
                GameCard(widget.srcs[8].url, widget.srcs[8].id, widget.srcs[8].description),
              ],
            ),
          ),
          Positioned(
            top: 150.0,
            left: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameCard(widget.srcs[9].url, widget.srcs[9].id, widget.srcs[9].description),
                GameCard(widget.srcs[10].url, widget.srcs[10].id, widget.srcs[10].description),
                GameCard(widget.srcs[11].url, widget.srcs[11].id, widget.srcs[11].description),
                GameCard(widget.srcs[12].url, widget.srcs[12].id, widget.srcs[12].description),
                GameCard(widget.srcs[13].url, widget.srcs[13].id, widget.srcs[13].description),
                GameCard(widget.srcs[14].url, widget.srcs[14].id, widget.srcs[14].description),
              ],
            ),
          ),
          Positioned(
            top: 225.0,
            left: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameCard(widget.srcs[15].url, widget.srcs[15].id, widget.srcs[15].description),
                GameCard(widget.srcs[16].url, widget.srcs[16].id, widget.srcs[16].description),
                GameCard(widget.srcs[17].url, widget.srcs[17].id, widget.srcs[17].description),
                GameCard(widget.srcs[18].url, widget.srcs[18].id, widget.srcs[18].description),
                GameCard(widget.srcs[19].url, widget.srcs[19].id, widget.srcs[19].description),
                GameCard(widget.srcs[20].url, widget.srcs[20].id, widget.srcs[20].description),
                GameCard(widget.srcs[21].url, widget.srcs[21].id, widget.srcs[21].description),
              ],
            ),
          ),
          Positioned(
            top: 300.0,
            left: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameCard(widget.srcs[22].url, widget.srcs[22].id, widget.srcs[22].description),
                GameCard(widget.srcs[23].url, widget.srcs[23].id, widget.srcs[23].description),
                GameCard(widget.srcs[24].url, widget.srcs[24].id, widget.srcs[24].description),
                GameCard(widget.srcs[25].url, widget.srcs[25].id, widget.srcs[25].description),
                GameCard(widget.srcs[26].url, widget.srcs[26].id, widget.srcs[26].description),
                GameCard(widget.srcs[27].url, widget.srcs[27].id, widget.srcs[27].description),
              ],
            ),
          ),
          Positioned(
            top: 375.0,
            left: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameCard(widget.srcs[28].url, widget.srcs[28].id, widget.srcs[28].description),
                GameCard(widget.srcs[29].url, widget.srcs[29].id, widget.srcs[29].description),
                GameCard(widget.srcs[30].url, widget.srcs[30].id, widget.srcs[30].description),
                GameCard(widget.srcs[31].url, widget.srcs[31].id, widget.srcs[31].description),
                GameCard(widget.srcs[32].url, widget.srcs[32].id, widget.srcs[32].description),
              ],
            ),
          ),
          Positioned(
            top: 450.0,
            left: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameCard(widget.srcs[33].url, widget.srcs[33].id, widget.srcs[33].description),
                GameCard(widget.srcs[34].url, widget.srcs[34].id, widget.srcs[34].description),
                GameCard(widget.srcs[35].url, widget.srcs[35].id, widget.srcs[35].description),
                GameCard(widget.srcs[36].url, widget.srcs[36].id, widget.srcs[36].description),
              ],
            ),
          ),


        ],
      ),
    );
  }
}