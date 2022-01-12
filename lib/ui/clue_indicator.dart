
import 'package:flutter/material.dart';
import 'package:web/ui/round_indicator.dart';

class ClueIndicator extends StatefulWidget{
  final int count;
  ClueIndicator(this.count);
  @override
  State<StatefulWidget> createState() {
    return ClueIndicatorState();
  }
}

class ClueIndicatorState extends State<ClueIndicator>{
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundIndicator('assets/moroz.png', true),
            RoundIndicator('assets/gift.png', widget.count > 0 ? true: false),
            RoundIndicator('assets/gift.png', widget.count > 1 ? true: false),
            RoundIndicator('assets/gift.png', widget.count > 2 ? true: false),
          ],
        ),
      ),
    );
  }
}