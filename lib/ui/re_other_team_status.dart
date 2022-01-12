
import 'package:flutter/material.dart';
import 'package:web/bloc/other_team_stream.dart';
import 'package:web/models/turn_model.dart';
import 'package:web/ui/re_hex.dart';
import 'package:web/ui/re_hex_form.dart';

class OtherTeamStatus extends StatefulWidget {
  final OtherTeamStream otherTeamStream;
  final int teamId;
  OtherTeamStatus(this.otherTeamStream, this.teamId);
  @override
  _OtherTeamStatusState createState() => _OtherTeamStatusState();
}

class _OtherTeamStatusState extends State<OtherTeamStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*
              Expanded(
                  flex: 40,
                  child: Container(
                    color: Colors.green,
                  )
              ),

               */

              ///team name
              Expanded(
                flex: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 50,
                        child: StreamBuilder<StatusModel>(
                          stream: widget.otherTeamStream.otherTeamProgress,
                          //initialData: StatusModel(clue: 0, police: 0),
                          builder: (context, snapshot) {
                            if(snapshot.hasData)
                              {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        flex: 40,
                                        child: starRow(snapshot.data.clue)),
                                    Expanded(
                                        flex: 30,
                                        child: Container()),
                                    Expanded(
                                        flex: 40,
                                        child: crossRow(snapshot.data.police)),
                                  ],
                                );
                              }
                            else{
                              widget.otherTeamStream.addToStream();
                              return Container();
                            }
                          }
                        )
                    ),

                    Expanded(
                        flex: 50,
                        child: Container()
                    ),
                  ],
                ),
              ),
              /// space for line in stack
              /*
             Expanded(
                  flex: 20,
                  child: Container()),

               */
              ///stars, crosses and role
              Expanded(
                  flex: 30,
                  child: Container(
                      //color: Colors.red,
                      child: team(widget.teamId))),
              ///bottom space
              //Expanded(
                //  flex: 10,
                 // child: Container()),
            ],

          ),
          Container(
            //  color: Colors.red,
            child: Column(
              children: [
                ///space up
                Expanded(
                    flex: 10,
                    child: Container(
                //        color: Colors.red,
                    )),
                ///actual line
                Expanded(
                  flex: 50,
                  child: Container(
                    // color: Colors.green,
                      child: Center(child: Image.asset('assets/other.png', fit: BoxFit.contain,))
                     ),
                ),
                ///space down
                Expanded(
                    flex: 20,
                    child: Container()),
              ],
            ),
          ),
          /*
          Row(
            children: [
              /// slash line with dot
              Expanded(
                flex: 20,
                child: Column(
                  children: [
                    Expanded(
                        flex: 44,
                        child: Container()),
                    Expanded(
                      flex: 36,
                      child: Container(
                        padding: EdgeInsets.only(top:2),
                        height: double.infinity,
                        width: double.infinity,
                        child: ClipPath(
                          clipper: Diagona2Clipper(),
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 20,
                        child: Container())
                  ],
                ),
              ),
              /// horizontal line
              Expanded(
                flex: 80,
                child: Column(
                  children: [
                    ///space up
                    Expanded(
                        flex: 40,
                        child: Container()),
                    ///actual line
                    Expanded(
                      flex: 10,
                      child: Center(
                        child: Container(
                          height: 2.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ///space down
                    Expanded(
                        flex: 50,
                        child: Container()),
                  ],
                ),
              ),



            ],
          ),

           */


        ],
      ),
    );
  }
  Widget team(int teamId){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(bottom: 7),
                  child: teamId==1? Image.asset('assets/one.png') : Image.asset('assets/two.png')
                ),
              )),

          Expanded(
            flex: 95,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                //'$teamId команда',
                '   команда соперников',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          )


        ],
      ),
    );
  }
  Widget starRow(int count){
    return Container(
     // color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          count>2? Image.asset('assets/starF.png', fit: BoxFit.contain):Image.asset('assets/starE.png', fit: BoxFit.contain),
          count>1? Image.asset('assets/starF.png', fit: BoxFit.contain):Image.asset('assets/starE.png', fit: BoxFit.contain),
          count>0? Image.asset('assets/starF.png', fit: BoxFit.contain):Image.asset('assets/starE.png', fit: BoxFit.contain),
        ],
      ),
    );
  }
  Widget crossRow(int count){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        count>2? Image.asset('assets/crossF.png', fit: BoxFit.contain):Image.asset('assets/crossE.png', fit: BoxFit.contain),
        count>1? Image.asset('assets/crossF.png', fit: BoxFit.contain):Image.asset('assets/crossE.png', fit: BoxFit.contain),
        count>0? Image.asset('assets/crossF.png', fit: BoxFit.contain):Image.asset('assets/crossE.png', fit: BoxFit.contain),
      ],
    );
  }
}
class Diagona2Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width-2, 0)
      ..lineTo(0, size.height-1.5)
      ..lineTo(0, size.height)
      ..lineTo(2, size.height)
      ..lineTo(size.width, 2)
     // ..lineTo(0, 0)

      //..addOval(Rect.fromCircle(center: Offset(5, size.height-5), radius: 5))
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
