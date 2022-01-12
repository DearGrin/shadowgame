import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web/bloc/nav_cards_for_choice.dart';
import 'package:web/bloc/select_button_state_stream.dart';

import '../models/map_model.dart';
import 're_hex.dart';

class CardsForChoice extends StatefulWidget {
  final NavCardsForChoice navCardsForChoice;
  final SelectButtonStateStream buttonState;
  final ValueNotifier<bool> isSubmitted;
  CardsForChoice(this.navCardsForChoice, this.buttonState, this.isSubmitted);
  @override
  _CardsForChoiceState createState() => _CardsForChoiceState();
}

class _CardsForChoiceState extends State<CardsForChoice> {
 // final NavCardsForChoice navCardsForChoice = NavCardsForChoice();
 final ScrollController scrollController = ScrollController();
 Function onSelect;
 final ValueNotifier<Color> _progress = ValueNotifier<Color>(Color.fromRGBO(187, 190, 225, 0.5));
 //final ValueNotifier<bool> _isSubmitted = ValueNotifier<bool>(false);
 //Color _stateColor = Colors.white;
 @override
 void initState() {
    // TODO: implement initState
   onSelect = (value){widget.navCardsForChoice.onSelect(value);};
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    /// bottom panel with cards to pick
    return Container(
   //   color: Colors.green,
      child: Row(
        children: [
          /// left arrow ///
          Expanded(
            flex: 10,
            child: Container(
              //color: Colors.blueGrey,
              child: InkWell(
                onTap: (){
                  scrollController.jumpTo(scrollController.offset-50);
                },
                child: Image.asset('assets/left.png'),
              ),
            ),
          ),

          /// panel with cards ///
          Expanded(
            flex: 80,
            child: Container(
              child: Column(
                children: [
                  Container(
                    //height: MediaQuery.of(context).size.height*0.4,
                    /// main row with cards ///
                    child: Row(
                      children: [
                        /// padding left
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        /// place for cards ///
                        Expanded(
                          flex: 96,
                          child: Container(
                         //   color: Colors.blue,
                            //child: SingleChildScrollView(
                              //scrollDirection: Axis.horizontal,
                              //controller: scrollController,
                              child:
                              StreamBuilder<List<MapItem>>(
                                stream: widget.navCardsForChoice.navCards,
                                //initialData: [],
                                builder: (context, snapshot) {
                                  if(snapshot.hasData) {
                                    return  Column(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        controller: scrollController,
                                    child:  StreamBuilder<List<int>>(
                                      stream: widget.navCardsForChoice.selectedCardsList,
                                      builder: (context, snap) {
                                        return Row(
                                          children: snapshot.data.map((e) =>
                                              ReHex(e.url, e.id, MediaQuery.of(context).size.height*0.11, MediaQuery.of(context).size.height*0.11,
                                                  true, 1, '', onSelect, snap.data!=null? snap.data.contains(e.id)?true:false : false)).toList(),
                                          //children: widget.cards.map((e) => ReHex(e.url, e.id, 150.0, 150.0, false)).toList(),
                                        );
                                      }
                                    ),
                                    ),
                                      snapshot.data.length>0? Container(
                                        //color: Colors.red,
                                        padding: EdgeInsets.only(top: 10),
                                        child: Center(
                                          child: ValueListenableBuilder(
                                          valueListenable: widget.isSubmitted,
                                            builder: (context, value, child) {
                                              return ElevatedButton(
                                                onPressed: (){onSendConfirm();},
                                                style: ElevatedButton.styleFrom(primary: Color.fromRGBO(125, 133, 188, 0.15), padding: EdgeInsets.symmetric(horizontal: 150),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), shadowColor: Colors.transparent),
                                                child: value? Text('подтвеждено', style: Theme.of(context).textTheme.bodyText2,)
                                                : Text('Подтвердить выбор карточек', style: Theme.of(context).textTheme.bodyText2,),
                                              );
                                            }
                                          ),
                                        ),
                                      ) : Container()
                                  ]
                                    );
                                  }




                                  else{
                                    print('no data yet');
                                    widget.navCardsForChoice.addToStream();
                                    return Container();
                                  }
                                }
                              ),

                            ),
                          ),
                        //),
                        /// padding right ///
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  /*
                  /// submit button ///
                  Align(
                    alignment: Alignment.topLeft,
                    child: StreamBuilder<String>(
                      stream: widget.buttonState.selectButtonState,
                      builder: (context, snapshot){
                        if (snapshot.hasData)
                          {
                            if(snapshot.data=='ready')
                              {
                                return Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.height*0.08, maxHeight: MediaQuery.of(context).size.height*0.08),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: ClipPath(
                                          clipper: HexClipper(),
                                          child: Container(
                                            color: Color.fromRGBO(187, 190, 225, 0.5),
                                            height:  MediaQuery.of(context).size.height*0.5*0.3,
                                            width: MediaQuery.of(context).size.height*0.5*0.3,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: ClipPath(
                                            clipper: HexClipper(),
                                            child: Container(
                                              color:  Color.fromARGB(125, 125, 133, 185),
                                              height:  MediaQuery.of(context).size.height*0.3*0.20,
                                              width: MediaQuery.of(context).size.height*0.3*0.20,
                                              child: IconButton(
                                                icon: Icon(Icons.check, color: Colors.white,),
                                                onPressed: onSendConfirm,
                                              ),
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ); //pale
                              }
                            else if (snapshot.data=='submit')
                              {
                                return Container(
                                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.height*0.08, maxHeight: MediaQuery.of(context).size.height*0.08),
                                  child: Stack(
                                    children: [
                                    Align(
                                    alignment: Alignment.center,
                                    child: ClipPath(
                                    clipper: HexClipper(),
                                      child: Container(
                                      color: Color.fromRGBO(187, 190, 225, 0.5),
                                      height:  MediaQuery.of(context).size.height*0.5*0.3,
                                      width: MediaQuery.of(context).size.height*0.5*0.3,
                                      ),
                                      ),
                                    ),
                                      Align(
                                      alignment: Alignment.center,
                                      child: ClipPath(
                        clipper: HexClipper(),
                        child: Container(
                        color: Theme.of(context).primaryColor,
                        height:  MediaQuery.of(context).size.height*0.3*0.20,
                        width: MediaQuery.of(context).size.height*0.3*0.20,
                          child: IconButton(
                            icon: Icon(Icons.check, color: Colors.white,),
                            onPressed: onSendConfirm,
                          ),
                        )
                                      ),
                                      ),
                                    ],
                                  ),
                                ); //bright
                              }
                            else{
                              return Container();  //not my turn
                            }
                          }
                        else{
                          widget.buttonState.addToStream();
                          return Container();
                        }
                      }
                      ),
                  ),


                   */
                  /*
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      //color: Colors.blue,
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.height*0.08, maxHeight: MediaQuery.of(context).size.height*0.08),
                      child: Stack(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _progress,
                            builder: (context, value, child) {
                              return Align(
                                alignment: Alignment.center,
                                child: ClipPath(
                                  clipper: HexClipper(),
                                  child: Container(
                                  color: value,
                                  height:  MediaQuery.of(context).size.height*0.5*0.3,
                                  width: MediaQuery.of(context).size.height*0.5*0.3,


                                   /*
                                    child: ClipPath(
                                      clipper: HexClipper(),
                                      child: Container(
                                        color: Colors.red,
                                        height:  MediaQuery.of(context).size.height*0.2*0.15,
                                        width: MediaQuery.of(context).size.height*0.2*0.15,
                                    ),
                                  ),

                                    */

                                ),
                  ),
                              );
                            }
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: ClipPath(
                              clipper: HexClipper(),
                              child: Container(
                               // padding: EdgeInsets.all(30),
                                color: Theme.of(context).primaryColor,
                              //  color: Colors.black,
                                height:  MediaQuery.of(context).size.height*0.3*0.20,
                                width: MediaQuery.of(context).size.height*0.3*0.20,
                                child: StreamBuilder<String>(
                                  stream: widget.buttonState.selectButtonState,
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData)
                                      {
                                        if(snapshot.data=='ready')
                                          {
                                            return IconButton(
                                              icon: Icon(Icons.check, color: Colors.white,),
                                              onPressed: onSendConfirm,
                                            );
                                            /*
                                            return ValueListenableBuilder(
                                              valueListenable: _progress,
                                              builder: (context, value, child){
                                                //return Container(
                                                //  color: value,
                                              //  );

                                               return Stack(
                                                 children: [
                                                   Container(
                                                       color: value
                                                   ),
                                                   IconButton(
                                                    icon: Icon(Icons.check, color: Colors.white,),
                                            onPressed: onSendConfirm,
                                            ),

                                                 ],
                                               );


                                            }

                                            );
                                            */
                                          }
                                        else{
                                          return Container();
                                            }
                                      }
                                    else{
                                      widget.buttonState.addToStream();
                                      return Container();
                                    }

                                  }
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                   */
                ],
              ),
            ),
          ),

          /// right arrow ///
          Expanded(
            flex: 10,
            child: Container(
              //color: Colors.blueGrey,
              child: InkWell(
                onTap: (){
                  scrollController.jumpTo(scrollController.offset+50);
                },
                child: Image.asset('assets/right.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSendConfirm()async{
   bool res = await widget.navCardsForChoice.confirm();
   if(res){
     widget.buttonState.status = 'submit';
     widget.buttonState.addToStream();
     widget.isSubmitted.value = true;
   }
   /*
   if (res)
     {
       print('sending was success!');
      _progress.value = Colors.green;
      resetColor();

     }
   else{
     _progress.value = Colors.red;
     resetColor();
   }

    */

  }
  void resetColor() {
     //Future.delayed(Duration(seconds: 2),(){});
    Timer(Duration(seconds: 2), () {
      _progress.value = Theme.of(context).hintColor;
    });

  }
}
