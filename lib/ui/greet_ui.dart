import 'package:flutter/material.dart';

class Greetings extends StatelessWidget {
  String name;
  Greetings(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 600, maxHeight: 300),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Image.asset('assets/arm.png'),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('привет, $name!', style: Theme.of(context).textTheme.subtitle1,
              ),
              Text('рады приветствовать\nв игре <<теневые игры>>', style: Theme.of(context).textTheme.subtitle1,
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
    );
  }
}
