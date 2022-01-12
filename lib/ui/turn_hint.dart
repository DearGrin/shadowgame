import 'package:flutter/material.dart';
import 'package:web/ui/new_pop_up.dart';

class TurnHint extends StatelessWidget {
  final bool isNavigator;
  final int phase;
  final int eventCase;
  final Function cancel;
  TurnHint(this.isNavigator, this.phase, this.eventCase, this.cancel);
  @override
  Widget build(BuildContext context) {
    final List<String> navHint = [
      'assets/t_yours.png', // nothing nav turn
      'assets/t_scout_s.png', // star nav turn
      'assets/t_scout_c.png', // cross nav turn
      'assets/t_scout.png' // scout turn
    ];
    final List<String> scoutHint = [
      'assets/t_nav.png', // nothing scout turn
      'assets/t_nav_s.png', // star nav turn turn
      'assets/t_nav_c.png' // cross nav turn
    ];
    String _ = isNavigator? phase==1?  navHint[3] : navHint[eventCase] : phase==1? navHint[0] : scoutHint[eventCase];
    return NewPopUp(_, cancel);
  }
}
