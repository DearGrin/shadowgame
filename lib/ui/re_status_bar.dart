
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web/bloc/status_stream.dart';
import 'package:web/models/turn_model.dart';

class ReStatusBar extends StatefulWidget {
  final StatusStream statusStream;
  ReStatusBar(this.statusStream);
  @override
  _ReStatusBarState createState() => _ReStatusBarState();
}

class _ReStatusBarState extends State<ReStatusBar> {
  final ValueNotifier<String> _counter = ValueNotifier<String>('0:00');
  final ValueNotifier<double> _progress = ValueNotifier<double>(0.0);
  final ValueNotifier<int> _timer = ValueNotifier<int>(600);
  //AnimationController controller;
 // int timeLeft = 120;
  Timer timer;
  String timeSting = '0:00';
  double progress = 0.0;
  @override
  void initState() {
    widget.statusStream.status.listen((event) {
      _timer.value = event.endTime;
    });
    // TODO: implement initState
    /*
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 120),
    )..addListener(() {
      setState(() {
      });
    });
    controller.forward();

     */
    startUpdate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        clipBehavior: Clip.none,
        fit: BoxFit.contain,
        child: StreamBuilder<TurnModel>(
          stream: widget.statusStream.status,
          //initialData: TurnModel(phase: 0, endTime: 120),
          builder: (context, snapshot) {
           // startUpdate();
            if(snapshot.hasData)
              {
              //  print('status has data');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    timerS(),
                    linProg(),
                    SizedBox(height: 5,),
                    turn(snapshot.data.phase==0? 'навигатор':'разведчики'),
                  ],
                );
              }
            else{
              widget.statusStream.addToStream();
              return Container();
            }
           // _timer.value = snapshot.data.endTime;

            //controller.reset();

/*
                LinearProgressIndicator(
                  value: progress,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),


 */

                //ProgressIndicator(snapshot.data.endTime),


          }
        ),
      ),
    );
  }
  Widget linProg(){
    return Container(
      constraints: BoxConstraints(maxHeight: 15.0, maxWidth: 600),
      decoration: BoxDecoration(
        color: Color.fromRGBO(187, 190, 225, 0.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
        child: ValueListenableBuilder(
          valueListenable: _progress,
          builder: (context, value, child){
            return  LinearProgressIndicator(
              value: value,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.transparent,
            );
          },
        ),
      ),
    );
  }
  Widget timerS(){
    return Container(
      constraints: BoxConstraints(maxHeight: 50.0, maxWidth: 600),
     // child: Text(timeSting, style: Theme.of(context).textTheme.bodyText1),

        child: ValueListenableBuilder(
            valueListenable: _counter,
            builder: (context, value, child){
              return Text(value, style: Theme.of(context).textTheme.bodyText1);
            },
    ),



    );
           // child: Text('$timeSting', style: Theme.of(context).textTheme.bodyText1,)));
  }
  Widget turn(String turn){
    //print('turn is $turn');
    return Container(
      constraints: BoxConstraints(maxHeight: 35.0, maxWidth: 600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Color.fromRGBO(187, 190, 225, 0.5),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: turn=='навигатор'? Colors.white : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'навигатор',
                    style: TextStyle(color: turn=='навигатор'?Theme.of(context).primaryColor : Colors.white, fontSize: 20, backgroundColor: Color.fromARGB(0, 255, 255, 255)),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: turn!='навигатор'? Colors.white : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'разведчики',
                    maxLines: 1,
                    style: TextStyle(color: turn!='навигатор'? Theme.of(context).primaryColor: Colors.white, fontSize: 20,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          _progress.value = 1- _timer.value/180;
          _timer.value --;
          timeSting = time;
          //t(time);
          /*
          setState(() {
            progress = 1- timeLeft/120;

          });

           */

        }
        else{
          _counter.value = 'смена хода';
        }
    });
  }
  /*
  void t(String time){
    setState(() {
      progress += 1- _timer.value/120 ;
      timeSting = time;
      print(time);
    });
  }

   */
}

class ProgressIndicator extends StatefulWidget {
  final int currentTime;
  ProgressIndicator(this.currentTime);
  @override
  _ProgressIndicatorState createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  double beginAnim = 0.0 ;
  double endAnim = 1.0 ;
  int maxTime = 180;
  @override
  void initState() {
    // TODO: implement initState
    print('init progress INDICATOR');
    beginAnim = (maxTime-widget.currentTime)/maxTime;
    controller = AnimationController(
        duration: Duration(seconds: widget.currentTime), vsync: this);
    animation = Tween(begin: beginAnim, end: endAnim).animate(controller)
      ..addListener(() {
        setState(() {

        });
      });
    //controller.forward();
    controller.repeat();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 15.0, maxWidth: 600),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
    ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                child: LinearProgressIndicator(
                  value: animation.value,
                  backgroundColor: Colors.white,
                  valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              ),


      //        child:


        ],
      ),
    );
  }
  void resetAnim(){
    controller.stop();
    controller.value = 1.0;

  }
}

