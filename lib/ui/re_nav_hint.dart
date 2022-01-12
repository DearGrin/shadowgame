
import 'package:flutter/material.dart';
import 'package:web/bloc/highlight_stream.dart';
import 'package:web/bloc/team_position.dart';
import 'package:web/models/highlight_model.dart';
import 'package:web/models/map_model.dart';
import 'package:web/ui/re_hex.dart';
import 'package:web/ui/re_hex_form.dart';

class ReNavHint extends StatefulWidget {
  final List<String> clues;
  final List<String> police;
  final HighlightStream highlightStream;
  final List<MapItem> gameCards;
  ReNavHint(this.clues, this.police, this.highlightStream, this.gameCards);
  @override
  _ReNavHintState createState() => _ReNavHintState();
}

class _ReNavHintState extends State<ReNavHint> {
  List<String> visitedCards = [];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double h = (constraints.maxHeight-30)/7;
        double w = (constraints.maxWidth-30)/7;
        double size = h>w? w:h;
        return Center(
          child: Container(
           // color: Colors.red,
            child: StreamBuilder<HighlightModel>(
              stream: widget.highlightStream.highlight,
              builder: (context, snapshot) {
                if(snapshot.hasData)
                  {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Container(
                            height: size,
                            width: size*4+15,
                            child: rowOfCards([0,1,2,3], snapshot.data,),
                            /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,


                          children: [
                            ReHexForm(child('03')),
                            Container(width: 5,),
                            ReHexForm(child('05')),
                            Container(width: 5,),
                            ReHexForm(child('07')),
                            Container(width: 5,),
                            ReHexForm(child('09')),
                          ],


                           */

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size*0.7+5),
                          child: Container(
                            height: size,
                            width: size*5+20,
                            child: rowOfCards([4,5,6,7,8], snapshot.data),
                            /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHexForm(child('12')),
                            Container(width: 5,),
                            ReHexForm(child('14')),
                            Container(width: 5,),
                            ReHexForm(child('16')),
                            Container(width: 5,),
                            ReHexForm(child('18')),
                            Container(width: 5,),
                            ReHexForm(child('110')),
                          ],
                        ),

                         */
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size*1.5+5),
                          child: Container(
                            height: size,
                            width: size*6+25,
                            child: rowOfCards([9,10,11,12,13,14], snapshot.data),
                            /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHexForm(child('21')),
                            Container(width: 5,),
                            ReHexForm(child('23')),
                            Container(width: 5,),
                            ReHexForm(child('25')),
                            Container(width: 5,),
                            ReHexForm(child('27')),
                            Container(width: 5,),
                            ReHexForm(child('29')),
                            Container(width: 5,),
                            ReHexForm(child('211')),
                          ],
                        ),

                         */
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size*2.3+5),
                          child: Container(
                            height: size,
                            width: size*7+30,
                            child: rowOfCards([15,16,17,18,19,20,21], snapshot.data),
                            /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHexForm(child('30')),
                            Container(width: 5,),
                            ReHexForm(child('32')),
                            Container(width: 5,),
                            ReHexForm(child('34')),
                            Container(width: 5,),
                            ReHexForm(child('36')),
                            Container(width: 5,),
                            ReHexForm(child('38')),
                            Container(width: 5,),
                            ReHexForm(child('310')),
                            Container(width: 5,),
                            ReHexForm(child('312')),
                          ],
                        ),

                         */
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size*3.1+5),
                          child: Container(
                            height: size,
                            width: size*6+25,
                            child: rowOfCards([22,23,24,25,26,27], snapshot.data),
                            /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHexForm(child('41')),
                            Container(width: 5,),
                            ReHexForm(child('43')),
                            Container(width: 5,),
                            ReHexForm(child('45')),
                            Container(width: 5,),
                            ReHexForm(child('47')),
                            Container(width: 5,),
                            ReHexForm(child('49')),
                            Container(width: 5,),
                            ReHexForm(child('411')),
                          ],
                        ),

                         */
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size*3.9+5),
                          child: Container(
                            height: size,
                            width: size*5+20,
                            child: rowOfCards([28,29,30,31,32], snapshot.data),
                            /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHexForm(child('52')),
                            Container(width: 5,),
                            ReHexForm(child('54')),
                            Container(width: 5,),
                            ReHexForm(child('56')),
                            Container(width: 5,),
                            ReHexForm(child('58')),
                            Container(width: 5,),
                            ReHexForm(child('510')),
                          ],
                        ),

                         */
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size*4.7+5),
                          child: Container(
                            height: size,
                            width: size*4+15,
                            child: rowOfCards([33,34,35,36], snapshot.data),
                            /*
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReHexForm(child('63')),
                            Container(width: 5,),
                            ReHexForm(child('65')),
                            Container(width: 5,),
                            ReHexForm(child('67')),
                            Container(width: 5,),
                            ReHexForm(child('69')),
                          ],
                        ),

                         */
                          ),
                        ),
                      ],
                    );
                  }
                else {
                  widget.highlightStream.addToStream();
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }              }
            ),
          ),
        );
      }
    );
  }
  Widget rowOfCards(List<int> ids, HighlightModel model,){
    List<Widget> _tmp = [];
    //model.highlightCards!=null && model.highlightCards.contains(widget.gameCards[item].id)? true:false
    for (var item in ids){
      //print('////// check highlight ///////');
     // print(model.highlightCards);
     // print(model.highlightCards.contains(widget.gameCards[item].position));
      bool _isReady = model.highlightCards.contains(widget.gameCards[item].position);
      bool _hasTeam = model.myPosition==widget.gameCards[item].position;
      if(_hasTeam && !visitedCards.contains(widget.gameCards[item].position))
        visitedCards.add(widget.gameCards[item].position);
      _tmp.add(ReHexForm(child(widget.gameCards[item].position, _hasTeam, _isReady)),);
      _tmp.add(SizedBox(width: 2.0,));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _tmp,
    );
  }
  Widget child(String id, bool hasTeam, bool isReady){
   Color _color;
   if(hasTeam)
     {
       _color = Theme.of(context).primaryColor;
     }
   else if (isReady)
     {
       _color =  Color.fromARGB(153, 125, 133, 185);
     }
   else{
     _color = Color.fromARGB(91, 125, 133, 185);
   }
        return Container(
          color: _color,
          child: Stack(
            children: [
              FittedBox(child: Icon(Icons.close, color: Color.fromARGB(0, 255, 255, 255), size: 70,), fit: BoxFit.scaleDown,),
              visitedCards.contains(id)? Container(): widget.clues.any((element) => element==id)? FittedBox(child: Icon(Icons.star, color: Theme.of(context).primaryColor, size: 70,), fit: BoxFit.scaleDown,):Container(),
              visitedCards.contains(id)? Container(): widget.police.any((element) => element==id)? FittedBox(child: Icon(Icons.close, color: Theme.of(context).primaryColor, size: 70,), fit: BoxFit.scaleDown,):Container(),
              //snapshot.data == id? FittedBox(child: Icon(Icons.circle , color: Colors.green, size: 24,), fit: BoxFit.scaleDown,):Container(),
            ],
          ),
        );

  }
}
