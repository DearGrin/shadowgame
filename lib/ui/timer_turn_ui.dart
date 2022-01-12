
import 'package:flutter/material.dart';

class TimerTurnUi extends StatefulWidget{
  final String phase;
  TimerTurnUi(this.phase);
  @override
  State<StatefulWidget> createState() {
    return TimerTurnUiState();
  }
}

class TimerTurnUiState extends State<TimerTurnUi>{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(widget.phase == 'vote' ? 'Голосование':'Выбор пути'),
        Text('таймер'),
      ],
    );
  }
}