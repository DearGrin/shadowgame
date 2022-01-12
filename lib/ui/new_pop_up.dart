import 'package:flutter/material.dart';

class NewPopUp extends StatelessWidget {
  final String src;
  final Function cancel;
  NewPopUp(this.src, [this.cancel]);
  @override
  Widget build(BuildContext context) {
    return Container(
      //shape: RoundedRectangleBorder(),
     //clipBehavior: Clip.antiAlias,
     //color: Colors.black,
      constraints: BoxConstraints(maxHeight: 300, maxWidth: 600),
     //clipBehavior: Clip.antiAlias,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(35),
      // color: Colors.red,
     ),
     // child: Image.network(src),
      //child: Image.asset('assets/hint_not.png'),
      child: Stack(
        children: [
          Image.asset(src),
          Positioned(
            top: 15,
            right: 15,
            child: TextButton(
              onPressed: (){
                if(cancel!= null) {
                  cancel();
                }
                Navigator.pop(context);
                },
                child: Text('X', style: Theme.of(context).textTheme.headline2,)
            ),
          )
        ],
      ),
    );
      /*
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(src)),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 75, right: 75),
            child: TextButton(
              onPressed: (){Navigator.pop(context);},
              child: Text(
                'X',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        )
        /*
        child: Stack(
          children: [
            /*
            Align(
              alignment: Alignment.center,
              child: Image.network(src, fit: BoxFit.contain,),
            ),

             */

          ],
        ),

         */
      ),


       */

  }
}
