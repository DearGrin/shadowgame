import 'package:flutter/material.dart';

class GameOver extends StatefulWidget{
  final bool isWinner;
  final Function toLobby;
  GameOver(this.isWinner, this.toLobby);
  @override
  State<StatefulWidget> createState() {
    return GameOverState();
  }
}

class GameOverState extends State<GameOver>{
  @override
  Widget build(BuildContext context) {
    return Container(
      //shape: RoundedRectangleBorder(),
      //clipBehavior: Clip.antiAlias,
      //color: Colors.black,
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 800),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Theme.of(context).primaryColor,
      ),
      // child: Image.network(src),
      //child: Image.asset('assets/hint_not.png'),
      child: Stack(
        children: [
          Image.asset(widget.isWinner? 'assets/winner.png' : 'assets/looser.png'),
          Positioned(
            bottom: 25,
            right: 25,
            child: TextButton(
                onPressed: (){
                  Navigator.pop(context);
                  widget.toLobby();
                  },
                child: Text('назад в лобби', style: Theme.of(context).textTheme.headline3,)
            ),
          )
        ],
      ),
    );
    /*
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            constraints: BoxConstraints(maxHeight: 350),
            decoration: BoxDecoration(
              image: widget.isWinner? DecorationImage(image: AssetImage('assets/winner.png'), fit: BoxFit.contain) : DecorationImage(image: AssetImage('assets/looser.png'), fit: BoxFit.contain),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            child: Text('назад в лобби', style: Theme.of(context).textTheme.bodyText1,),
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: (){goBack(context);},
          ),
        ),
      ],
    );


     */

    /*
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Игра окончена!',
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          'Команда ' + widget.teamId.toString() + ' победила!',
          style: Theme.of(context).textTheme.headline1,
        ),
        ElevatedButton(
          child: Text('Назад в лобби', style: Theme.of(context).textTheme.bodyText1,),
          //color: Colors.blue[600],
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: (){goBack(context);},
        ),
      ],
    );


     */
  }
  void goBack(BuildContext context){
    Navigator.of(context).pop();
    widget.toLobby();
  }
}

