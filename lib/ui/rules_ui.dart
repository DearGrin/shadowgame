
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:web/bloc/game_bloc.dart';
import 'package:web/bloc/rules_bloc.dart';
import 'package:web/ui/custom_game.dart';
import 'package:web/ui/hex_from.dart';

class RulesUI extends StatefulWidget{
  final RulesBloc rulesBloc;
  RulesUI(this.rulesBloc);
  @override
  State<StatefulWidget> createState() {
    return RulesUIState();
  }
}

class RulesUIState extends State<RulesUI>{
  bool isOnline = false;
  final ScrollController listScrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    //isOnline = widget.rulesBloc.isOnline;
    //widget.rulesBloc.connectToSocket();
    //widget.rulesBloc.getPlayerStatus();

    //widget.rulesBloc.countDown();
   // widget.gameBloc.setReady(isOnline);

    //widget.gameBloc.subscribeToChannel('lobby');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 800.0,
        child: Column(
          children: [
            Container(
              height: 70.0,
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*
                  Text(
                    //'Правила игры',
                    ' ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                   */
                  customGameButton(),
                  Row(
                    children: [
                      Text(
                        'Готов(а) к игре!',
                            style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Switch(
                        value: isOnline,
                        onChanged: (value){ changeOnline(value); },
                        activeColor: Colors.blue[600],
                      ),
                      isOnline? timer():Container(),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Scrollbar(
                isAlwaysShown: true,
                controller: listScrollController,
                child: SingleChildScrollView(
                  controller: listScrollController,
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        title('ЦЕЛЬ ИГРЫ'),
                       Card(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Flexible(child: middleSpan('Чтобы выиграть, команда должна первой собрать ','3 звезды',', разбросанных по игровому полю.' )),
                                   Container(
                                     width: 75.0,
                                     height: 75.0,
                                     constraints: BoxConstraints(
                                       maxWidth: 75.0,
                                       maxHeight: 75.0,
                                     ),
                                     child: HexForm(Image(image: AssetImage('assets/starR.jpg'),) ,1),
                                   ),
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Container(
                                     width: 75.0,
                                     height: 75.0,
                                     constraints: BoxConstraints(
                                       maxWidth: 75.0,
                                       maxHeight: 75.0,
                                     ),
                                     child: HexForm(Image(image: AssetImage('assets/crossR.jpg'),) ,1),
                                   ),
                                   Flexible(child: middleSpan('Если команда 3 раза столкнется с ', 'крестиком', ', она автоматически проиграет.')),
                                  // Flexible(child: Text(' Если команда 3 раза столкнется со снеговиком, она автоматически проиграет', style: Theme.of(context).textTheme.bodyText1,)),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),

                        title('РОЛИ'),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                            RichText(
                            text: TextSpan(
                            text: 'В команде есть ',
                              style: Theme.of(context).textTheme.bodyText1,
                              children: <TextSpan>[
                                TextSpan(text: 'один Навигатор', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: ' и от трех '),
                                TextSpan(text: 'Разведчиков.', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50.0, left: 50.0, bottom: 20.0),
                                  child: Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: 'Только ',
                                        style: Theme.of(context).textTheme.bodyText1,
                                        children: <TextSpan>[
                                          TextSpan(text: 'Навигатор', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: ' знает расположение '),
                                          TextSpan(text: 'Звезд ', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: 'и '),
                                          TextSpan(text: 'Крестиков', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: ', но именно '),
                                          TextSpan(text: 'Разведчики ', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: 'решают, куда переместить фишку команды.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text('НАВИГАТОР',
                                  style:  Theme.of(context).textTheme.headline1,),
                                ),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'В свой ход может выбрать 1 или 2 карточки из предложенных, чтобы указать путь ',
                                      style: Theme.of(context).textTheme.bodyText1,
                                      children: <TextSpan>[
                                        TextSpan(text: 'Разведчикам.', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(child: middleSpan('1 карточка = ', 'Разведчики ', 'могут выбрать соседний участок для передвижения.')),
                                    Container(
                                      width: 75.0,
                                      height: 75.0,
                                      constraints: BoxConstraints(
                                        maxWidth: 75.0,
                                        maxHeight: 75.0,
                                      ),
                                      child: Image(image: AssetImage('assets/1move.png'),),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(child: middleSpan('2 карточки = ', 'Разведчики ', 'могут выбрать участок через один для передвижения.')),
                                    Container(
                                      width: 75.0,
                                      height: 75.0,
                                      constraints: BoxConstraints(
                                        maxWidth: 75.0,
                                        maxHeight: 75.0,
                                      ),
                                      child: Image(image: AssetImage('assets/2move.png'),),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text('РАЗВЕДЧИКИ',
                                    style:  Theme.of(context).textTheme.headline1,),
                                ),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'В свой ход ',
                                      style: Theme.of(context).textTheme.bodyText1,
                                      children: <TextSpan>[
                                        TextSpan(text: 'Разведчик ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        TextSpan(text: 'голосует за 1 участок, на который, по его мнению, указал ', style: Theme.of(context).textTheme.bodyText1),
                                        TextSpan(text: 'Навигатор.', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


/*
                        title('ОБЩЕНИЕ ОБРАЗАМИ'),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 75.0,
                                  height: 75.0,
                                  constraints: BoxConstraints(
                                    maxWidth: 75.0,
                                    maxHeight: 75.0,
                                  ),
                                  child: Image(image: AssetImage('assets/speak.png'),),
                                ),
                                Container(
                                  width: 10.0,
                                ),
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: '',
                                      style: Theme.of(context).textTheme.bodyText1,
                                      children: <TextSpan>[
                                        TextSpan(text: 'НАВИГАТОР', style: TextStyle(fontWeight: FontWeight.bold)),
                                        TextSpan(text: ' может общаться со своей командной  '),
                                        TextSpan(text: 'ТОЛЬКО ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        TextSpan(text: 'посредством абстрактных картинок-подсказок. Используйте ассоциации, ищете похожие элементы или цветовые решения.'),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          )
                        ),
*/
                        title('ХОД ИГРЫ'),

                        Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [

                                  Expanded(
                                    flex: 80,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: '1. Выбор подсказок ',
                                            style: Theme.of(context).textTheme.bodyText1,
                                            children: <TextSpan>[
                                              TextSpan(text: 'Навигатором', style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),

                                        RichText(
                                          text: TextSpan(
                                            text: '2. Голосование ',
                                            style: Theme.of(context).textTheme.bodyText1,
                                            children: <TextSpan>[
                                              TextSpan(text: 'Разведчиков ', style: TextStyle(fontWeight: FontWeight.bold)),
                                              TextSpan(text: 'за участок для перемещения'),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: '3. Подсчет результатов',
                                            style: Theme.of(context).textTheme.bodyText1,
                                            children: <TextSpan>[
                                            ],
                                          ),
                                        ),
                                        Text('Эти три шага повторяются до конца игры', style: Theme.of(context).textTheme.bodyText1,)


                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    flex: 20,
                                    child: Container(
                                      width: 75.0,
                                      height: 75.0,
                                      constraints: BoxConstraints(
                                        maxWidth: 75.0,
                                        maxHeight: 75.0,
                                      ),
                                      child: Image(image: AssetImage('assets/turn.png'),),
                                    ),
                                  ),

                                ],
                              ),
                            )
                        ),

                        title('ВРЕМЯ'),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                middleSpan('', 'Время ', 'на каждый ход ограничено'),
                                Row(
                                  children: [
                                    Flexible(child: middleSpan('Если игрок не сделает свой ход до окончания времени, система сходит за него в случайном порядке. Это касается и ', 'Навигаторов и Разведчиков', '. То есть игра не будет зависать и завершаться, если вдруг кто-то из участников открыл вкладку и забывшись ушел пить чай. Если все игроки сделали свой выбор, следующий ход начнется досрочно.')),
                                   /*
                                    Flexible(
                                      child: Text(
                                        'Если игрок не сделает свой ход до окончания времени, система сходит за него в случайном порядке. Это касается и Навигаторов и Разведчиков. Если все игроки сделали свой выбор, следующий ход начнется досрочно.',
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                    ),

                                    */
                                    Container(
                                      width: 10.0,
                                    ),
                                    HexForm(Container(width: 50.0,
                                        height: 50.0,
                                        color: Colors.white, child: Icon(Icons.access_time, color:Theme.of(context).primaryColor, size: 40.0,)) ,1),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ),

                        title('СТАРТ ИГРЫ'),

                        Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  middleSpan('', 'ВРЕМЯ ', 'на каждый ход ограничено'),
                                  Row(

                                    children: [
                                      HexForm(Container(width: 50.0,
                                          height: 50.0,
                                          color: Colors.white, child: Center(child: Text('30 мин', style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold), textAlign: TextAlign.center,))) ,1),
                                      Container(
                                        width: 10.0,
                                      ),
                                      Flexible(
                                        child: middleSpan('Новые игры начинаются автоматически каждые ', '30 минут', ', если онлайн есть достаточное количество игроков.'),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            )
                        ),

showNotEnough(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void changeOnline(bool value){
    setState(() {
      isOnline = value;
    });
    print('set true in ui');
    widget.rulesBloc.setReady(value);
    //todo send data
  }
  Widget title(String text){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: HexForm(Container
        (
        child: Center(child: Text(text, style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.center,)),
        color: Colors.white,
        width: 275.0,
        height: 50.0,), 0
      ),
    );
  }
  Widget middleSpan(String start, String bold, String end){
    return RichText(
      text: TextSpan(
        text: start,
        style: Theme.of(context).textTheme.bodyText1,
        children: <TextSpan>[
          TextSpan(text: bold, style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: end),
        ],
      ),
    );
  }
  Widget customGameButton(){
    return FlatButton(
      onPressed: (){_showPrivateGame(context);},
      color: Theme.of(context).primaryColor,
      child: Text(
        'Частная игра',
        style: Theme.of(context).textTheme.bodyText1,
      ),

    );
  }
  Widget timer(){
    return StreamBuilder(
        stream: widget.rulesBloc.timer,
        builder: (context, AsyncSnapshot<String> snapshot){
          if(snapshot.hasData)
          {
            return Text(snapshot.data, style: Theme.of(context).textTheme.headline1,);
          }
          else
          {
            return Container();
          }
        }
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
            print(snapshot.data.toString());
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
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 500,
            height: 400,
            color: Theme.of(context).cardColor,
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
          return  AlertDialog(
            title: Text(""),
            content: Text("Недостаточно игроков онлайн. Позовите друзей или попробуйте позже.", style: Theme.of(context).textTheme.bodyText1,),
            backgroundColor: Theme.of(context).cardColor,
            actions: [
              FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Ok', style: Theme.of(context).textTheme.bodyText1,),)
            ],
          );
          /*
            Card(
            child: Container(
              width: 300,
              height: 300,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Недостаточно игроков онлайн',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      'Позовите друзей или попробуйте позже',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    RaisedButton(
                      child: Text('Ok', style: Theme.of(context).textTheme.bodyText1,),
                      color: Colors.blue[600],
                      onPressed: (){Navigator.of(context).pop();},
                    ),
                  ],
                ),
              ),
            ),
          );


           */
        });
  }
}