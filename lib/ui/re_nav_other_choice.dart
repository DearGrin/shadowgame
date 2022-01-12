import 'package:flutter/material.dart';
import 'package:web/bloc/my_nav_chosen_cards.dart';
import 'package:web/bloc/other_nav_chosen_cards.dart';
import 'package:web/models/map_model.dart';

import 're_hex.dart';

class ReOtherNavChoice extends StatefulWidget {
  final int team;
  final MyNavChosenCards myNavChosenCards;
  final OtherNavChosenCards otherNavChosenCards;
  ReOtherNavChoice(this.team, this.myNavChosenCards, this.otherNavChosenCards);
  @override
  _ReOtherNavChoiceState createState() => _ReOtherNavChoiceState();
}

class _ReOtherNavChoiceState extends State<ReOtherNavChoice> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      double maxW = constraints.maxWidth/9;
      double maxH = constraints.maxHeight/5;
      double constr = maxW>maxH? maxH:maxW;
      if(widget.team == 1) {
        return Padding(
          padding: EdgeInsets.only(top: constr*0.4, left: constr*0.4),
          child: Container(
            //top: constr*0.25,
            //left: constr*0.35,
            height: constr * 1.75,
            width: constr * 1.5,
            child: StreamBuilder<List<MapItem>>(
              stream: widget.myNavChosenCards.navCards,
              //initialData: [],
              builder: (context, snapshot) {
                if(snapshot.hasData)
                  {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: snapshot.data.length>0? ReHex(snapshot.data[0].url, snapshot.data[0].id, maxH, maxW, true,3) :
                          ReHex(
                              'https://sun9-25.userapi.com/impf/iCSaAeRWP0vdE277ylDeP8ffqcgGj-TQ2cRp2Q/Mp5GKw-wbWY.jpg?size=100x100&quality=96&sign=8bda07ab153a22fa93239fb11f7c5b7c&type=album',
                              1, maxW, maxH, true,4),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: snapshot.data.length>1? ReHex(snapshot.data[1].url, snapshot.data[1].id, maxH, maxW, true,3) :
                          ReHex(
                              'https://sun9-25.userapi.com/impf/iCSaAeRWP0vdE277ylDeP8ffqcgGj-TQ2cRp2Q/Mp5GKw-wbWY.jpg?size=100x100&quality=96&sign=8bda07ab153a22fa93239fb11f7c5b7c&type=album',
                              1, maxW, maxH, true,4),
                        ),
                      ],
                    );
                  }
                else{
                  print('no data - ask for data');
                  widget.myNavChosenCards.addToStream();
                  return Container();
                }

              }
            ),
          ),
        );
      }
      else{
        return Padding(
          padding: EdgeInsets.only(bottom: constr*0.5, left: constr*0.5),
          child: Container(
            height: constr * 1.75,
            width: constr * 1.5,
            //padding: EdgeInsets.only(top:20, right: 20),
            child: StreamBuilder<List<MapItem>>(
              stream: widget.otherNavChosenCards.navCards,
             // initialData: [],
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: snapshot.data.length>0? ReHex(snapshot.data[0].url, snapshot.data[0].id, maxH, maxW, true,3) :
                          ReHex(
                              'https://sun9-25.userapi.com/impf/iCSaAeRWP0vdE277ylDeP8ffqcgGj-TQ2cRp2Q/Mp5GKw-wbWY.jpg?size=100x100&quality=96&sign=8bda07ab153a22fa93239fb11f7c5b7c&type=album',
                              1, maxW, maxH, true,4),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: snapshot.data.length>1? ReHex(snapshot.data[1].url, snapshot.data[1].id, maxH, maxW, true,3) :
                          ReHex(
                              'https://sun9-25.userapi.com/impf/iCSaAeRWP0vdE277ylDeP8ffqcgGj-TQ2cRp2Q/Mp5GKw-wbWY.jpg?size=100x100&quality=96&sign=8bda07ab153a22fa93239fb11f7c5b7c&type=album',
                              1, maxW, maxH, true,4),
                        ),
                      ],
                    );
                  }
                else{
                  widget.otherNavChosenCards.addToStream();
                  return Container();
                }

              }
            ),
          ),
        );
      }
    },);
  }
}
