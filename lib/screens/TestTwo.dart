import 'package:flutter/material.dart';
import 'package:web/extensios/hint_linls.dart';
import 'package:web/ui/gameover.dart';
import 'package:web/ui/new_pop_up.dart';
import 'package:web/ui/re_hex_form.dart';

class TestTwo extends StatefulWidget {
  @override
  _TestTwoState createState() => _TestTwoState();
}

class _TestTwoState extends State<TestTwo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 80,
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 5,
             child: Image.asset('assets/one.png'),
          ),

          Expanded(
            flex: 50,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                //'$teamId команда',
                'команда соперников',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          )


        ],
      ),
      /*
      child: FloatingActionButton(
        onPressed: (){_showDialog(context);},
      ),

       */
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
            //child: NewPopUp('assets/t_yours.png'));
              child: GameOver(true, (){print('to lobby');}));
        });
  }
}
