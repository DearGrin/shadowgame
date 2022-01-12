import 'package:flutter/material.dart';

class Greetings extends StatelessWidget {
  final String name;
  Greetings(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
     // constraints: BoxConstraints(maxHeight: 350),
      color: Colors.red,
      child: Column(
        children: [
          Text('Hi, name!'),
          Image.asset('assets/greet.png')
        ],
      ),
      /*
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Align(
             alignment: Alignment.bottomRight,
             child: ElevatedButton(
                child: Text('Ok', style: Theme.of(context).textTheme.bodyText1,),
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: (){Navigator.pop(context);},
              ),
          ),
        ],
      ),


       */
    );
  }
}
