import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/ui/greet_ui.dart';
import 'package:web/ui/re_hex_form.dart';
import 'package:web/ui/ready_list.dart';
import 'package:web/ui/rule_link_button.dart';

class NewRules extends StatefulWidget {
  final ValueNotifier<int> currPage;
  final ValueNotifier<bool> start;
  NewRules(this.currPage, this.start);
  @override
  _NewRulesState createState() => _NewRulesState();
}

class _NewRulesState extends State<NewRules> {
  final PageController pageController = PageController(initialPage: 0, viewportFraction: 1);
  final ValueNotifier<int> _index = ValueNotifier<int>(0);
  final ValueNotifier<bool> _rules = ValueNotifier<bool>(false);
  final ValueNotifier<String> _name = ValueNotifier<String>('игрок');
  //String name;
  @override
  void initState() {
    // TODO: implement initState
    getRulesBool();
    getName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
          children: [
            Expanded(
                flex: 1,
                child: arrow(0)
            ),
            Expanded(
                flex: 8,
                child: Container(
                    height: MediaQuery.of(context).size.height-200,
                    child: rulesBody())
            ),
            Expanded(
                flex: 1,
                child: arrow(1)
            ),
          ],
        ),
          Container(
            constraints: BoxConstraints(maxHeight: 100),
            child: bottomIndicators(),
          )
      ]
      ),
    );
  }
  Widget arrow(int direction){
    if(direction==0)
      {
        return ValueListenableBuilder(
          valueListenable: _index,
          builder: (context, value, child) {
            if(value==0) {
              return Container();
            }
            else {
              return Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: () {
                    _prevPage();
                    widget.currPage.value = _index.value;
                  },
                ),
              );
            }
          }
        );
      }
    else{
      return ValueListenableBuilder(
          valueListenable: _index,
          builder: (context, value, child) {
            if(value>=4 || value==0) {
              return Container();
            }
            else {
              return Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.white,),
                  onPressed: () {
                    _nextPage();
                    widget.currPage.value = _index.value;
                  },
                ),
              );
            }
          }
      );
    }

  }

  Widget rulesBody(){
    return ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, value, child){
          return IndexedStack(
          index: value,
          children: [
            greet(),
            rulesImage('assets/rule_1.png'),
            rulesImage('assets/rule_2.png'),
            rulesImage('assets/rule_3.png'),
            rulesImage('assets/rule_4.png'),
            //rulesImage('https://sun9-85.userapi.com/impg/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'),
            ReadyList(widget.start),
    ],
    );
    }
    );
      IndexedStack(
      index: _index.value,
      children: [
        rulesImage('https://sun9-85.userapi.com/impg/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'),
        rulesImage('https://sun9-36.userapi.com/impg/c854124/v854124884/1b2786/ogxAHXe6pos.jpg?size=500x375&quality=96&sign=f30711075dc16159bc4d49ea606374e1&type=album'),
        rulesImage('https://sun9-85.userapi.com/impg/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'),
      ],
    );
      /*
      PageView(
      controller: pageController,
      children: [
        rulesImage('https://sun9-85.userapi.com/impg/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'),
        rulesImage('https://sun9-85.userapi.com/impg/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'),
        rulesImage('https://sun9-85.userapi.com/impg/pTZlbb41BQ_y-6uJebww1Ze4rKVegbuZVNR92g/j5PzOaT0mSI.jpg?size=1800x1800&quality=96&sign=cd183cd727f0ab5b8e869d58cba6a209&type=album'),
      ],
    );

       */
  }
  Widget greet(){

    return Center(
      child: Container(
        //color: Colors.red,
        //constraints: BoxConstraints(maxHeight: 400, maxWidth: 800),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 35,
              child: Row(
                children: [
                  Expanded(child: Container(), flex: 30,),
                  Expanded(
                    flex: 70,
                    child: ValueListenableBuilder(
                      valueListenable: _name,
                      builder: (context, value, child) {
                        return Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                                'привет, $value!',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                        );
                      }
                    )

                  ),
                ],
              ),
            ),
            /*
            Row(
              children: [
                Expanded(child: Container( color: Colors.blue,), flex: 7,),
                Expanded(
                  flex: 93,
                  child: Text('привет, name!',
                  style: Theme.of(context).textTheme.headline1,),
                ),
              ],
            ),

             */
              Expanded(
                flex: 60,
                  child: SvgPicture.asset('assets/greet-02.svg')),
            //Image.asset('assets/greet.png'),
              Expanded(
                flex: 20,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 // Expanded(child: Container(), flex: 7,),
                  Expanded(
                    flex: 93,
                     child: RuleButton((){_launchInBrowser('https://shadow-game.expquest.ru/rules/shadow_rules.pdf');},(){_nextPage();}),
                    /*
                    child: TextButton(
                        onPressed: (){_nextPage();},
                        child: Text(
                          'ознакомиться с правилами',
                          style: Theme.of(context).textTheme.headline1,
                        )
                    ),

                     */

                  ),
                ],
              ),
            ),

            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(child: Container(), flex: 30,),
                Expanded(
                  flex: 70,
                  child: ValueListenableBuilder(
                    valueListenable: _rules,
                    builder: (context, value, child) {
                      if(!value) {
                        return InkWell(
                          onTap: () {
                            changeIsDineRules();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ReHexForm(
                                Container(
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                  width: 50,
                                  height: 50,
                                  child: Container(
                                    padding: EdgeInsets.all(6.0),
                                    child: ReHexForm(
                                      Container(
                                        color: Colors.white,
                                        child: ReHexForm(
                                          Icon(
                                            Icons.check, color: Theme
                                              .of(context)
                                              .hintColor, size: 25,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('уже ознакомился с правилами игры',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1,
                              )
                            ],
                          ),
                        );
                      }
                      else{
                        return InkWell(
                          onTap: () {
                            changeIsDineRules();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ReHexForm(
                                Container(
                                  color: Color.fromARGB(250, 235, 208, 227),
                                  width: 50,
                                  height: 50,
                                  child: Container(
                                    padding: EdgeInsets.all(6.0),
                                    child: ReHexForm(
                                      Container(
                                        color: Colors.white,
                                        child: ReHexForm(
                                          Icon(
                                            Icons.check, color: Color.fromARGB(250, 235, 208, 227), size: 25,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('уже ознакомился с правилами игры',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1,
                              )
                            ],
                          ),
                        );
                      }

                    }
                  ),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }
  Widget rulesImage(String url){
   // return Image.network(url, fit: BoxFit.contain,);
    return Center(
      child: Container(
       // constraints: BoxConstraints(maxWidth: 1000, minWidth: 500, minHeight: 500),
        //child: Image.network(url, fit: BoxFit.contain,),
       // color: Colors.red,
        child: Image.asset(url, fit: BoxFit.contain,)
      ),
    );
  }
  Widget bottomIndicators(){
    return ValueListenableBuilder(
      valueListenable: _index,
      builder: (context, value, child) {
        if (value==0)
          {
            return Container();
          }
        else {
          if (value == 4) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    _nextPage();
                    widget.currPage.value = _index.value;},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReHexForm(
                         Container(
                          color: Color.fromARGB(250, 235, 208, 227),
                            width: 50,
                            height: 50,
                            child: Container(
                              padding: EdgeInsets.all(6.0),
                              child: ReHexForm(
                                Container(
                                color: Colors.white,
                                  child: ReHexForm(
                                    Icon(Icons.check, color: Color.fromARGB(250, 235, 208, 227), size: 25,),

                        ),
                ),
                ),
                ),
                ),
                ),
                      Text('   начать игру', style: Theme.of(context).textTheme.subtitle2,),
                    ],
                  ),
        ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                indicator(value == 0),
                indicator(value == 1),
                indicator(value == 2),
                indicator(value == 3),
                indicator(value == 4),
                indicator(value == 5)
              ],
            ),
              ],
            );
          }
          else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                indicator(value == 0),
                indicator(value == 1),
                indicator(value == 2),
                indicator(value == 3),
                indicator(value == 4),
                indicator(value == 5)
              ],
            );
          }
        }
      }
    );
  }
  Widget indicator(bool isActive){
    return isActive? Icon(Icons.radio_button_on, color: Colors.white,) : Icon(Icons.radio_button_off, color: Colors.white);
  }
  void _nextPage(){
    if(_index.value>=5)
      {

      }
    else{
      _index.value++;
    }
  }
  void _prevPage(){
    if(_index.value>0)
      {
        _index.value --;
      }
    else
      {

      }
  }
  Future<void> changeIsDineRules() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _rules.value = !_rules.value;
    prefs.setBool('rules', _rules.value);
    if(_rules.value==true)
    {
      _index.value = 5;
      widget.currPage.value = 5;
    }
  }
  Future<void> getRulesBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('rules'))
      {
        _rules.value = prefs.getBool('rules');
      }
    else{
      prefs.setBool('rules', _rules.value);
    }
    if(_rules.value==true)
      {
        _index.value = 5;
        widget.currPage.value = 5;
      }
  }
  Future<void> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('sub')) {
      String fullName = prefs.getString('sub');
      _name.value = fullName;
      //_name.value = fullName.substring(7);
    }
    else{
      _name.value = 'игрок';
    }
  }
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'правила игры'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
