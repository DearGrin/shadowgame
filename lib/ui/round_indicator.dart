
import 'package:flutter/material.dart';

class RoundIndicator extends StatefulWidget{
  final String frontImage;
  final bool  isFound;
  RoundIndicator(this.frontImage, this.isFound);
  @override
  State<StatefulWidget> createState() {
    return RoundIndicatorState();
  }
}

class RoundIndicatorState extends State<RoundIndicator>{
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: widget.isFound ? AssetImage(widget.frontImage): AssetImage('assets/empty.png'),
      backgroundColor: Colors.white,
      //radius: 20.0,
      //child: widget.isFound? Image.asset(widget.frontImage) : Container(),
    );
  }
}