import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/bloc/ready_list_bloc.dart';
import 'package:web/bloc/rules_bloc.dart';
import 'package:web/extensios/hint_linls.dart';
import 'package:web/ui/custom_game.dart';
import 'package:web/ui/greet_ui.dart';
import 'package:web/ui/new_pop_up.dart';
import 'package:web/ui/new_rules.dart';
import 'package:web/ui/re_hex_form.dart';

class ReRules extends StatefulWidget {
  final RulesBloc rulesBloc;
  ReRules(this.rulesBloc, );
  @override
  _ReRulesState createState() => _ReRulesState();
}

class _ReRulesState extends State<ReRules> {
  bool isOnline = false;
  final ValueNotifier<String> _counter = ValueNotifier<String>('0:00');
  final ValueNotifier<double> _progress = ValueNotifier<double>(0.0);
  final ValueNotifier<bool> _online = ValueNotifier<bool>(false);
  final ValueNotifier<int> _timer = ValueNotifier<int>(1800);
  final ValueNotifier<int> currPage = ValueNotifier<int>(0);
  final ValueNotifier<bool> start = ValueNotifier<bool>(false);
 // int timeLeft = 600;
  Timer timer;
  //String timeSting = '0:00';
  double progress = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    startUpdate();
    widget.rulesBloc.notEnough.listen((event) {
      if(event) {
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            _showDialog(context));
        resetTimer();
      }
      else{resetTimer();}
    });
    widget.rulesBloc.lobbyTimer.listen((event) {
      _timer.value = event;
    });
   // WidgetsBinding.instance.addPostFrameCallback((_) => _showGreetDialog(context));
    //_showGreetDialog(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [


              Container(
               // color: Colors.red,
                //width: 1920,
                height: constraints.maxHeight-100,
                child:   NewRules(currPage, start),
              ),
          /*
                child: SvgPicture.asset(
                    'assets/rules.svg',
                   // color: Colors.red,
                  //  semanticsLabel: 'A red up arrow'
                )
              ),


               */
              ValueListenableBuilder(
                  valueListenable: currPage,
                builder: (context, value, child) {
                  if (value==5) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 1600),
                        //width: 1400,
                        height: 100,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                readyButton(),
                                timerInd(),
                                privateGameButton(),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            linProg(),
                            //showNotEnough(),
                          ],
                        ),
                      ),
                    );
                  }
                  else{
                    return Container();
                  }
                }
              ),
            ],
          );
        }
      ),
    );
  }
  Widget readyButton(){
    return Row(
      children: [
        SizedBox(
          width: 30,
        ),
      InkWell(
    onTap: (){changeOnline();},
        child: ValueListenableBuilder(
            valueListenable: _online,
            builder: (context, value, child)
          {
            if(value) {
              return ReHexForm(
                  Container(
                    color: Theme
                        .of(context).cardColor,
                    width: 50,
                    height: 50,
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      child: ReHexForm(
                        Container(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          child: ReHexForm(
                                Icon(
                                  Icons.check, color: Colors.white, size: 25,),
                              ),
                          ),
                        ),
                      ),
                    ),
                  );
            }
            else{
              return ReHexForm(
                Container(
                  color: Color.fromARGB(250, 235, 208, 227),
                  width: 50,
                  height: 50,
                  child: Container(
                    padding: EdgeInsets.all(6.0),
                    child: ReHexForm(
                      Container(
                       // color: Color.fromARGB(125, 235, 208, 227),
                        color: Colors.white,
                        child: ReHexForm(
                          Icon(
                            Icons.check, color: Color.fromARGB(250, 235, 208, 227), size: 25,),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        ),
      ),
        SizedBox(
          width: 10,
        ),
        Text(
          'готов к игре',
          style: Theme.of(context).textTheme.subtitle2,
        ),

      ],
    );
  }
  Widget timerInd(){
    return ValueListenableBuilder(
      valueListenable: _counter,
      builder: (context, value, child){
        return Text('игра с рандомными участниками начнется через: $value', style: Theme.of(context).textTheme.bodyText1);
      },
    );
  }
  Widget privateGameButton(){
    return Container(
      //color:  Colors.red,
      child: Row(
        children: [
          TextButton(
              //onPressed: (){_showPrivateGame(context);},
            onPressed: (){start.value=true;},
              child: Text(
                'начать частную игру',
                style: Theme.of(context).textTheme.subtitle2,
              ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }
  Widget linProg(){
    return Container(
      constraints: BoxConstraints(maxHeight: 10.0, maxWidth: 1550),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).cardColor,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: ValueListenableBuilder(
          valueListenable: _progress,
          builder: (context, value, child){
            return  LinearProgressIndicator(
              value: value,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Color.fromARGB(250, 235, 208, 227),
            );
          },
        ),
      ),
    );
  }
  Widget showNotEnough(){
    return StreamBuilder(
        stream: widget.rulesBloc.notEnough,
        initialData: false,
        builder: (context, AsyncSnapshot<bool> snapshot){
          //print(snapshot.hasData);
          if(snapshot.data==true)
          {
           // print(snapshot.data.toString());
            WidgetsBinding.instance.addPostFrameCallback((_) => _showDialog(context));
            //_showDialog();
          }
          return Container();
        }
    );
  }
  _showPrivateGame(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35)
            ),
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: 500,
              height: 400,
              color: const Color(0xff7d85bc),
              child: CustomGame(widget.rulesBloc),
            ),
          );
        }
    );
  }
  _showDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35)
            ),
            child: NewPopUp(hintLinks['not_enough']),
                /*
            Container(
              padding: EdgeInsets.all(8.0),
              width: 500,
              height: 400,
              color: Theme.of(context).primaryColor,
              child: Card(
                color: Theme.of(context).hintColor,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                          child: Text("Недостаточно игроков онлайн. Позовите друзей или попробуйте позже.", style: Theme.of(context).textTheme.subtitle2,)),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('ok', style: Theme.of(context).textTheme.subtitle2,),),
                      ),




                    ],
                  ))),


                 */
            );

            //content: Text("Недостаточно игроков онлайн. Позовите друзей или попробуйте позже.", style: Theme.of(context).textTheme.subtitle2,),
            //backgroundColor: const Color(0xff7d85bc),
            //actions: [
             // TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('ok', style: Theme.of(context).textTheme.subtitle2,),)
            //],
          //);
        });
  }
  _showGreetDialog(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fullName = prefs.getString('sub');
    String name = fullName.substring(7);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  AlertDialog(
            title: Text(""),
            content: Greetings(name),
            //content: Text("Привет, name.\nДобро пожаловать в игру!", style: Theme.of(context).textTheme.subtitle2,),
           /*
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/arm.png'),
                Column(
                  children: [
                    Text('привет, name!', style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text('рады приветствовать\nв игре <<теневые игры>>', style: Theme.of(context).textTheme.subtitle2,
                    ),
                    TextButton(
                      onPressed: (){Navigator.of(context).pop();},
                      child: Text('ознакомиться с правилами', style: Theme.of(context).textTheme.bodyText2,
                        )
                    )
                  ],
                )
              ],
            ),

            */
            //backgroundColor: const Color(0xff7d85bc),
            backgroundColor: Colors.white,
            actions: [
              //TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Ok', style: Theme.of(context).textTheme.subtitle2,),)
            ],
          );
        });
  }
  void changeOnline(){
   // setState(() {
     // isOnline = value;
   // });
    _online.value = !_online.value;
    print('set ready in ui ' + _online.value.toString());
    widget.rulesBloc.setReady( _online.value);
    //todo send data
  }
  void startUpdate(){
    print('timer was updated');
    if(timer == null)
      timer =  Timer.periodic(Duration(seconds: 1), (timer) {
        if(_timer.value>0) {
          // print('tic tac');
          int _min = (_timer.value / 60).floor();
          int _sec = _timer.value - _min * 60;
          String time = _sec < 10 ? '$_min:0$_sec' : '$_min:$_sec';
          _counter.value = time;
          _progress.value = 1- _timer.value/1800;
          _timer.value --;
          //timeSting = time;
          //t(time);
          /*
          setState(() {
            progress = 1- timeLeft/120;

          });

           */

        }
        else{
          _counter.value = '0:00';
        }
      });
  }
  void resetTimer(){
    _timer.value = 600;
  }
}
