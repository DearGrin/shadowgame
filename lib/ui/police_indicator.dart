
import 'package:flutter/material.dart';
import 'package:web/ui/round_indicator.dart';

class PoliceIndicator extends StatefulWidget{
  final int count;
  PoliceIndicator(this.count);
  @override
  State<StatefulWidget> createState() {
    return PoliceIndicatorState();
  }
}

class PoliceIndicatorState extends State<PoliceIndicator>{
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
            RoundIndicator('assets/snowman.png', true),
            RoundIndicator('assets/bucket.png', widget.count > 0 ? true: false),
            RoundIndicator('assets/bucket.png', widget.count > 1 ? true: false),
            RoundIndicator('assets/bucket.png', widget.count > 2 ? true: false),
          ],
        ),
      ),
    );
  }
}