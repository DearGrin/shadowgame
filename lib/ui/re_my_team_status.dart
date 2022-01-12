
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/bloc/my_team_stream.dart';
import 'package:web/bloc/other_team_stream.dart';
import 'package:web/models/turn_model.dart';

class MyTeamStatus extends StatefulWidget {
  final MyTeamStream myTeamStream;
  final int teamId;
  final String role;
  MyTeamStatus(this.myTeamStream, this.teamId, this.role);
  @override
  _MyTeamStatusState createState() => _MyTeamStatusState();
}

class _MyTeamStatusState extends State<MyTeamStatus> {
  void tryIt(){
    print('let me try');
    widget.myTeamStream.ttt();
  }
  @override
  void initState() {
    // TODO: implement initState
   // widget.myTeamStream.addToStream();
   // print(widget.myTeamStream.i.toString());
    //print(widget.myTeamStream.statusModel.clue.toString());
   // print('//////');

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('building widget');
    return Stack(
      children: [
        Column(
          children: [
            //Expanded(
              //  flex: 25,
               // child: Container()),
            ///team name
            Expanded(
                flex: 40,
                child: team(widget.teamId)),
            /// space for line in stack
            Expanded(
                flex: 20,
                child: Container()),
            ///stars, crosses and role
            Expanded(
              flex: 30,
              child: Row(
                children: [
                  Expanded(
                      flex: 60,
                      child: StreamBuilder<StatusModel>(
                        stream: widget.myTeamStream.myTeamProgress,
                       // initialData: StatusModel(clue: 0, police: 0),
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {
                           // print(widget.myTeamStream.statusModel.clue.toString() + 'value in widget');
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    flex: 40,
                                    child: starRow(snapshot.data.clue),
                                    //child: starRow(widget.myTeamStream.statusModel.clue)
                                ),
                                Expanded(
                                    flex: 10,
                                    child: Container()),
                                Expanded(
                                    flex: 40,
                                    child: crossRow(snapshot.data.police)),
                              ],
                            );
                          }
                          else{
                           // print(widget.myTeamStream.statusModel.clue.toString() + 'value in widget');
                            //print(snapshot.data);
                           // widget.myTeamStream.addToStream();
                            //tryIt();
                            widget.myTeamStream.addToStream();
                            return CircularProgressIndicator();
                          }
                        }
                      )
                  ),
                  Expanded(
                      flex: 40,
                      child: role(widget.role)
                  ),
                ],
              ),
            ),
            ///bottom space
            Expanded(
                flex: 10,
                child: Container()),
          ],

        ),
        Container(
        //  color: Colors.red,
          child: Column(
            children: [
              ///space up
              Expanded(
                flex: 40,
                child: Container(
                //  color: Colors.red,
                )),
              ///actual line
              Expanded(
                flex: 50,
                child: Container(
                //  color: Colors.green,
                    child: Center(child: Image.asset('assets/my.png', fit: BoxFit.contain,))),
              ),
              ///space down
              Expanded(
                  flex: 10,
                  child: Container()),
            ],
          ),
        ),



      ],
    );
  }

  Widget team(int teamId){
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(bottom: 5),
                  child: teamId==1? Image.asset('assets/one.png') : Image.asset('assets/two.png')
              ),
            ),
          ),
      Expanded(
        flex: 95,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            //'$teamId команда',
            '    твоя команда',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
      /*
          Expanded(
          flex: 40,
          child: Container(
          )
          )

       */
        ],
      ),
    );
  }
  Widget starRow(int count){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        count>0? Image.asset('assets/starF.png', fit: BoxFit.contain,):Image.asset('assets/starE.png', fit: BoxFit.contain,),
        count>1? Image.asset('assets/starF.png', fit: BoxFit.contain,):Image.asset('assets/starE.png', fit: BoxFit.contain,),
        count>2? Image.asset('assets/starF.png', fit: BoxFit.contain,):Image.asset('assets/starE.png', fit: BoxFit.contain,),
      ],
    );
  }
  Widget crossRow(int count){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        count>0? Image.asset('assets/crossF.png', fit: BoxFit.contain,):Image.asset('assets/crossE.png', fit: BoxFit.contain,),
        count>1? Image.asset('assets/crossF.png', fit: BoxFit.contain,):Image.asset('assets/crossE.png', fit: BoxFit.contain,),
        count>2? Image.asset('assets/crossF.png', fit: BoxFit.contain,):Image.asset('assets/crossE.png', fit: BoxFit.contain,),
      ],
    );
  }
  Widget role(String role){
    return Container(
      //color: Colors.red,
      child: Row(
        children: [
          Expanded(
            flex: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 10,
                    child: Container()),
                Expanded(
                  flex: 50,
                  child: Image.asset('assets/person.png', fit: BoxFit.contain,),
                ),
                Expanded(
                    flex: 5,
                    child: Container()),
                Expanded(
                    flex: 35,
                    child: Text(
                      role,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.clip,
                    ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 40,
              child: Container())
        ],
      ),
    );
  }

}
class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, 1.5)
      ..lineTo(size.width-2, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height-2)
      ..lineTo(2, 0)
     // ..addOval(Rect.fromCircle(center: Offset(size.width-5, size.height-5), radius: 5))
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
