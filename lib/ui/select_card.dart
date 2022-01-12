
import 'package:flutter/material.dart';
import 'package:web/ui/game_card.dart';

class SelectCard extends StatefulWidget{
  final List<String> srcs;
  SelectCard(this.srcs);
  @override
  State<StatefulWidget> createState() {
    return SelectCardState();
  }
}

class SelectCardState extends State<SelectCard>{
  @override
  Widget build(BuildContext context) {
    /*
    return GridView(
      children: widget.srcs.map((e) => GameCard(e)).toList(),
    );

     */
  }
}