
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web/ui/re_hex.dart';
import 'package:web/ui/re_status_bar.dart';

/*
class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.28,
            color: Colors.green,
            child: Container(
              color: Colors.blue,
              padding: EdgeInsets.only(top:110.0, left: 20.0),
              height: 350.0,
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(flex: 20, child: Container(),),
              Expanded(
                flex: 60,
                child: LayoutBuilder(
                  builder: (context, constraints){
                    double maxW = constraints.maxWidth/9;
                    double maxH = constraints.maxHeight/5;
                    double constr = maxW>maxH? maxH:maxW;
                    print('maxH is ' + constraints.maxHeight.toString());
                    print('celH is ' + (constraints.maxHeight/7).toString());
                    return Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: constraints.maxWidth/1, maxHeight: 150),
                            child: Container()
                            //ReStatusBar()
                             ),
                        Container(
                          color: Colors.red,
                          child: Stack(
                            children: [
                              Positioned(
                                top: constr*0.25,
                                left: constr*0.35,
                                child: Container(
                                  height: constr*1.75,
                                  width: constr*1.5,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomLeft,
                                          child: ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: constr*0.25,
                                right: constr*0.35,
                                child: Container(
                                  height: constr*1.75,
                                  width: constr*1.5,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Container(
                                      height: constr,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: constr*0.7+5),
                                    child: Container(
                                      height: constr,
                                     // color: Colors.green,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: constr*1.4+5),
                                    child: Container(
                                      height: constr,
                                      //color: Colors.green,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: constr*2.1+5),
                                    child: Container(
                                      height: constr,
                                      //color: Colors.green,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: constr*2.8+5),
                                    child: Container(
                                      height: constr,
                                      //color: Colors.green,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: constr*3.5+5),
                                    child: Container(
                                      height: constr,
                                      //color: Colors.green,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),

                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: constr*4.2+5),
                                    child: Container(
                                      height: constr,
                                      //color: Colors.green,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                          ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, maxW, maxH, false),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(flex: 20, child: Container(),),
            ],

          ),
        ],
      ),
      /*
      body: LayoutBuilder(
        builder: (context, constraints){
          return Container(
            color: Colors.red,
            child: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                  ],
                ),
                Container(
                  color: Colors.blue,
                  child: Positioned(
                    top: 75.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                        ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                        ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                        ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                        ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                      ],
                    ),
                  ),
                ),
                Row(
                  //mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                    ReHex('https://sun9-62.userapi.com/impf/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&proxy=1&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album',1, false),
                  ],
                ),
              ],
            ),
          );
        },
      ),

       */
    );
  }
}

 */
