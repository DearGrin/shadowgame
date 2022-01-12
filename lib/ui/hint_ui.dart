
import 'package:flutter/material.dart';

class HintUi extends StatelessWidget{
  final String src;
  HintUi(this.src);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: InkWell(
          child: Image.network(src),
          onTap: () async {
    return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
    return Dialog(
     child: Container(
       width: 500,
       height: 500,
       decoration: BoxDecoration(
         image: DecorationImage(image: NetworkImage(src), fit: BoxFit.contain),
       ),
       child: Align(
         alignment: Alignment.topRight,
         child: FlatButton(
           child: Text('x'),
           onPressed: () { Navigator.of(context).pop(); },
         ),
       ),
     ),
    );
    },
    );
    },
      ),
    );
  }
}