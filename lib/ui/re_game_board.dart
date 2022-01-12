
import 'package:flutter/material.dart';
import 'package:web/bloc/highlight_stream.dart';
import 'package:web/models/highlight_model.dart';
import 'package:web/models/map_model.dart';

import 're_hex.dart';

class ReGameBoard extends StatefulWidget {
  final HighlightStream highlightStream;
  final List<MapItem> gameCards;
  ReGameBoard(this.highlightStream, this.gameCards);
  @override
  _ReGameBoardState createState() => _ReGameBoardState();
}

class _ReGameBoardState extends State<ReGameBoard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxW = constraints.maxWidth/9;
        double maxH = constraints.maxHeight/5.75;
        double constr = maxW>maxH? maxH:maxW;
        //print('maxH is ' + constraints.maxHeight.toString());
       // print('celH is ' + (constraints.maxHeight/7).toString());
        return Container(
          //color: Colors.red,
          child: StreamBuilder<HighlightModel>(
            stream: widget.highlightStream.highlight,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Container(
                        height: constr,
                        child: rowOfCards([0,1,2,3], snapshot.data, constr, constr),
                        /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHex(
                                snapshot.data.cards[0].url,
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[1].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[2].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[3].id, maxW, maxH, false),
                          ],
                        ),
                        */
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: constr * 0.75),
                      child: Container(
                        height: constr,
                        // color: Colors.green,
                        child: rowOfCards([4,5,6,7,8], snapshot.data, constr, constr),
                        /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[4].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[5].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[6].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[7].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[8].id, maxW, maxH, false),
                          ],
                        ),
                        */
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: constr  + constr*0.5),
                      child: Container(
                        height: constr,
                        //color: Colors.green,
                        child: rowOfCards([9,10,11,12,13,14], snapshot.data, constr, constr),
                        /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[9].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[10].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                1, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[11].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[12].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[13].id, maxW, maxH, false),
                          ],
                        ),
                        */
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2*constr  + constr*0.25),
                      child: Container(
                        height: constr,
                        //color: Colors.green,
                        child: rowOfCards([15,16,17,18,19,20,21], snapshot.data, constr, constr),
                        /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[14].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[15].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[16].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[17].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[18].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                          ],
                        ),
                        */
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3*constr),
                      child: Container(
                        height: constr,
                        //color: Colors.green,
                        child: rowOfCards([22,23,24,25,26,27], snapshot.data, constr, constr),
                        /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                          ],
                        ),
                        */
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3*constr + constr*0.75),
                      child: Container(
                        height: constr,
                        //color: Colors.green,
                        child: rowOfCards([28,29,30,31,32], snapshot.data, constr, constr),
                        /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                          ],
                        ),
                        */
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4*constr + constr*0.5),
                      child: Container(
                        height: constr,
                        //color: Colors.green,
                        child: rowOfCards([33,34,35,36], snapshot.data, constr, constr),
                        /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                            ReHex(
                                'https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',
                                snapshot.data.cards[0].id, maxW, maxH, false),
                          ],
                        ),


                         */
                      ),
                    ),
                  ],
                );
              }
              else{
                widget.highlightStream.addToStream();
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          ),
        );
      }
    );
  }

  Widget rowOfCards(List<int> ids, HighlightModel model, double maxW, double maxH){
    List<Widget> _tmp = [];
    //model.highlightCards!=null && model.highlightCards.contains(widget.gameCards[item].id)? true:false
    for (var item in ids){
    //  print('////// check highlight ///////');
     // print(model.highlightCards);
    //  print(model.highlightCards.contains(widget.gameCards[item].position));
      bool _isReady = model.highlightCards.contains(widget.gameCards[item].position);
      bool _hasMyTeam = model.myPosition==widget.gameCards[item].position;
      bool isNavTurn = model.highlightCards.length>0? false:true;
      bool _isSuperReady = isNavTurn? true : _hasMyTeam||_isReady;
      bool _hasTeam1 = model.teamPositions[0]==widget.gameCards[item].position;
      bool _hasTeam2 = model.teamPositions[1]==widget.gameCards[item].position;
      _tmp.add(ReHex(widget.gameCards[item].url,
          widget.gameCards[item].id, maxW, maxH, _isSuperReady, 2, widget.gameCards[item].description, (){}, false, _hasTeam1, _hasTeam2, _hasMyTeam), );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _tmp,
    );
  }
}
