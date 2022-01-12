
import 'package:flutter/material.dart';
import 'package:web/ui/clue_indicator.dart';
import 'package:web/ui/police_indicator.dart';
import 'package:web/ui/timer_turn_ui.dart';

class TopStatusBar extends StatefulWidget{
  final int clue1;
  final int clue2;
  final int police1;
  final int police2;
  final String phase;
  TopStatusBar(this.clue1, this.clue2, this.police1, this.police2, this.phase);
  @override
  State<StatefulWidget> createState() {
    return TopStatusBarState();
  }
}

class TopStatusBarState extends State<TopStatusBar>{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            ClueIndicator(widget.clue1),
            ClueIndicator(widget.clue2),
          ],
        ),
        TimerTurnUi(widget.phase),
        Column(
          children: [
            PoliceIndicator(widget.police1),
            PoliceIndicator(widget.police2),
          ],
        ),
      ],
    );
  }
}