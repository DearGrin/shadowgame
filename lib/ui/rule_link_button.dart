import 'package:flutter/material.dart';

class RuleButton extends StatelessWidget {
  final Function fullRules;
  final Function shortRules;
  RuleButton(this.fullRules, this.shortRules);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //SizedBox(width: 100,),
        Expanded(child: Container(), flex: 10,),
        Expanded(
          flex: 35,
          child: TextButton(
              onPressed: (){fullRules();},
              child: Text('ознакомиться\nс расширенными правилами', style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center,)
          ),
        ),
        Expanded(
          flex: 35,
          child: TextButton(
              onPressed: (){shortRules();},
              child: Text('ознакомиться\nс короткими правилами', style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center,)
          ),
        ),
        //SizedBox(width: 50,),
      ],
    );
  }
}
