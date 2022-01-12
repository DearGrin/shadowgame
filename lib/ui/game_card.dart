
import 'package:flutter/material.dart';

class GameCard extends StatefulWidget{
  final String src;
  final int id;
  final String content;
  final Function onSendCard;
  final bool isSelected;
 // final bool team1=false;
 // final bool team2=false;
 // GameCard(this.src, [this.team1, this.team2]);
  GameCard(this.src, this.id, [this.content, this.onSendCard, this.isSelected=false]);
  @override
  State<StatefulWidget> createState() {
    return GameCardState();
  }
}

class GameCardState extends State<GameCard>{
 // bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    print(widget.src);
    return hex();
  }

  Widget hex(){
    return InkWell(
      onTap: () async {
        print('tap on ' + widget.id.toString());
        return showDialog<void>(
          context: context,
          barrierDismissible: true, // user must tap button!
          builder: (BuildContext context) {
            return Dialog(
              child: widget.content.contains('select')?   widget.content.contains('2')? navigatorChoiceCard():selectableCard() : infoCard(),
            );
          },
        );
      },
      child: ClipPath(
        clipper: HexClipper(),
        child:
        Container(
          //color: Theme.of(context).primaryColor,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(widget.src)),
          ),
          child: widget.isSelected? Icon(Icons.check_circle, size: 36.0, color: Theme.of(context).primaryColor,) : Container(),


        ),
      ),
    );
  }
  Widget selectableCard(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Card(
        child: Column(
          children: [
            Container(
              //width: 500,
              //height: 600,
              constraints: BoxConstraints(maxWidth: 500, maxHeight: 600),
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.src), fit: BoxFit.contain),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 90,
                      child: Container(
                        //height: 70,
                        //width: 200,
                        constraints: BoxConstraints(maxWidth: 200, maxHeight: 70),
                        padding: EdgeInsets.only(top: 10.0, left: 75.0, right: 50.0),
                        child: RaisedButton(
                          onPressed: send,
                          color: Colors.blue[600],
                          child: Text(
                            'Выбрать карточку',
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextButton(
                          child: Text('x', style: Theme.of(context).textTheme.bodyText1),
                          onPressed: () { Navigator.of(context).pop(); },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*
            Container(
              //height: 70,
              //width: 200,
              constraints: BoxConstraints(maxWidth: 200, maxHeight: 70),
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: send,
                color: Colors.blue[600],
                child: Text(
                  'Выбрать карточку',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

             */
          ],
        ),
      ),
    );
  }
  Widget infoCard(){
  return Card(
      child: Container(
        width: 900,
        height: 600,
        child: Stack(
            children: [Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 500,
                      height: 600,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(widget.src), fit: BoxFit.contain),
                      ),
                    ),
                    widget.content!=null ?
                   t(widget.content) : Container(),
                  ],
                ),
              ],
            ),
              Align(
                alignment: Alignment.topRight,
                child: FlatButton(
                  child: Text('x', style: Theme.of(context).textTheme.bodyText1),
                  onPressed: () { Navigator.of(context).pop(); },
                ),
              ),
            ]
        ),
      ),
    );
  }
  Widget navigatorChoiceCard(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Card(
        child: Column(
          children: [
            Container(
              width: 500,
              height: 600,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.src), fit: BoxFit.contain),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: FlatButton(
                  child: Text('x', style: Theme.of(context).textTheme.bodyText1),
                  onPressed: () { Navigator.of(context).pop(); },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget t(String t){
    List<String> a = t.split(":");
    return Container(
      width: 300,
      height: 600,
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            a[0],
            style: Theme.of(context).textTheme.headline1,
          ),
          Container(height: 10.0,),
          Text(
            a[1],
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
  void send(){
    widget.onSendCard(widget.id);
    /*
    setState(() {
    isSelected = !isSelected;
    });

     */
    Navigator.of(context).pop();
  }
}

class HexClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0.0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0.0, size.height * 0.75);
    path.lineTo(0.0, size.height * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(HexClipper oldClipper) => false;
}