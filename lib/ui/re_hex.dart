
import 'package:flutter/material.dart';

class ReHex extends StatefulWidget {
  final String src;
  final int id;
  final double maxH;
  final double maxW;
  final String content;
  final Function onSelectCard;
  final bool isSelected;
  final bool isReadyToMove;
  final int type;
  final bool hasTeam1;
  final bool hasTeam2;
  final bool hasMyTeam;
  ReHex(this.src, this.id, this.maxH, this.maxW, this.isReadyToMove, this.type, [this.content, this.onSelectCard, this.isSelected, this.hasTeam1, this.hasTeam2, this.hasMyTeam]);
  @override
  _ReHexState createState() => _ReHexState();
}

class _ReHexState extends State<ReHex> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).cardColor,
      hoverColor: Colors.transparent,
      onTap: (){
       // print('tap');
        if(widget.type == 4){
          return null;
        }
        else {
          return showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button!
            builder: (BuildContext context) {
              return Dialog(
                // child: widget.content.contains('select')?   widget.content.contains('2')? navigatorChoiceCard():selectableCard() : infoCard(),
                child: widget.type == 1 ? selectableCard() : widget.type == 2
                    ? infoCard()
                    : navigatorChoiceCard(),
              );
            },
          );
        }
        },
      //highlightColor: Colors.blueGrey[400],
      //splashColor: Colors.blue,
      //highlightShape: BoxShape.circle,
      child: ClipPath(
        clipper: HexClipper(),
        child: Container(
          constraints: widget.maxH>widget.maxW? BoxConstraints(maxWidth: widget.maxW, maxHeight: widget.maxW) : BoxConstraints(maxWidth: widget.maxH, maxHeight: widget.maxH),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Theme.of(context).hintColor,
            ),
          child: Container(
            padding: EdgeInsets.all(10.0),
            /*
            child: InkWell(
              onTap: ()async{
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

             */
              child: Stack(
                children: [
                  ClipPath(
                    clipper: HexClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                       // border: Border.all(color: Colors.red),
                        //color: Colors.white,
                        color: Colors.white,
                        image: widget.isReadyToMove?
                        DecorationImage(image: NetworkImage(widget.src), colorFilter: ColorFilter.mode(Colors.white.withOpacity(1),
                            BlendMode.dstATop), fit: BoxFit.cover) :
                        DecorationImage(image: NetworkImage(widget.src), colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2),
                            BlendMode.dstATop), fit: BoxFit.cover),
                      ),
                       child: Container(
                         width: double.infinity,
                         height: double.infinity,
                         child: widget.isSelected!=null&&widget.isSelected?
                         //Container(color: Colors.white24,)
                         Icon(Icons.check, color: Colors.white, size: 45,)

                             : Container(),
                       ),
                    ),
                  ),
                 widget.hasTeam1!=null&&widget.hasTeam1?
                  CustomPaint(
                    painter: BorderPainter(widget.hasMyTeam),
                    child: Container(
                      width: 250,
                    ),
                  ): Container(),
                  widget.hasTeam2!=null&&widget.hasTeam2?
                  CustomPaint(
                    painter: BorderPainter(widget.hasMyTeam),
                    child: Container(
                      width: 250,
                    ),
                  ): Container(),
                  widget.hasTeam1!=null&&widget.hasTeam1?
                      Align(alignment: Alignment.centerLeft, child: Icon(Icons.looks_one_rounded, color: widget.hasMyTeam? Colors.white : Theme.of(context).primaryColor, size: widget.maxW*0.2,)):Container(),
                  widget.hasTeam2!=null&&widget.hasTeam2?
                    Align(alignment: Alignment.centerRight, child: Icon(Icons.looks_two_rounded, color: widget.hasMyTeam? Colors.white : Theme.of(context).primaryColor,size: widget.maxW*0.2,)):Container(),
                ],
              ),
            ),
          ),
          ),
    );
      //);
  }
  Widget selectableCard(){
    return Card(
      //color: Color.fromARGB(155, 125, 133, 185),
      child: Container(
        constraints: BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
             // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 90,
                  child: Container(
                    //height: 70,
                    //width: 200,
                    constraints: BoxConstraints(maxWidth: 200, maxHeight: 70),
                    padding: EdgeInsets.only(top: 10.0, left: 75.0, right: 50.0),
                    child: ElevatedButton(
                      onPressed: send,
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text(
                        widget.isSelected? 'отменить выбор карточки' :
                        'выбрать карточку',
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
                      child: Text('x', style: Theme.of(context).textTheme.subtitle1),
                      onPressed: () { Navigator.of(context).pop(); },
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
               // width: 500,
                //height: 600,
                child: Center(
                  child: widget.isSelected? Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 50,) : Container(),
                ),
                constraints: BoxConstraints(maxWidth: 500, maxHeight: 500),
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(widget.src), fit: BoxFit.contain),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget navigatorChoiceCard(){
    return Card(
      child: Container(
        constraints: BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Column(
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 500, maxHeight: 600),
               // width: 500,
               // height: 600,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(widget.src), fit: BoxFit.contain),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: Text('x', style: Theme.of(context).textTheme.bodyText1),
                    onPressed: () { Navigator.of(context).pop(); },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget infoCard(){
    return Card(
      child: Container(
        constraints: BoxConstraints(maxWidth: 900, maxHeight: 600),
        //width: 900,
        //height: 600,
        child: Stack(
            children: [Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 60,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0),
                         // width: 500,
                          //height: 600,
                          constraints: BoxConstraints(maxWidth: 500, maxHeight: 600),
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(widget.src), fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    ),
                    widget.content!=null ?
                    Expanded(flex: 40, child: description(widget.content)) : Container(),
                  ],
                ),
              ],
            ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Text('x', style: Theme.of(context).textTheme.bodyText1),
                  onPressed: () { Navigator.of(context).pop(); },
                ),
              ),
            ]
        ),
      ),
    );
  }
  Widget description(String t){
    List<String> a = t.split(":");
    return Container(
      constraints: BoxConstraints(maxWidth: 300, maxHeight: 600),
      //width: 300,
      //height: 600,
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
    widget.onSelectCard(widget.id);
    Navigator.of(context).pop();
  }
}

class HexClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.46, size.height*0.02);
    path.quadraticBezierTo(size.width * 0.5, 0.0, size.width * 0.54, size.height*0.02);
    path.lineTo(size.width*0.96, size.height * 0.21);
    path.quadraticBezierTo(size.width, size.height * 0.25, size.width, size.height*0.29);
    path.lineTo(size.width, size.height * 0.71); //c3
    path.quadraticBezierTo(size.width, size.height * 0.75, size.width*0.96, size.height*0.79);
    path.lineTo(size.width * 0.54, size.height*0.98);
    path.quadraticBezierTo(size.width*0.5, size.height, size.width*0.46, size.height*0.98);
    path.lineTo(size.width*0.04, size.height * 0.79);
    path.quadraticBezierTo(0.0, size.height * 0.75, 0.0, size.height * 0.71);
    path.lineTo(0.0, size.height * 0.29);
    path.quadraticBezierTo(0.0, size.height*0.25, size.width*0.04, size.height*0.21);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(HexClipper oldClipper) => false;
}
class BorderPainter extends CustomPainter {
  final bool isMyTeam;
  BorderPainter(this.isMyTeam);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..color = isMyTeam? Colors.white : Color.fromARGB(255, 125, 133, 185);
    Path path = Path();
    path.moveTo(size.width * 0.46, size.height*0.02);
    path.quadraticBezierTo(size.width * 0.5, 0.0, size.width * 0.54, size.height*0.02);
    path.lineTo(size.width*0.96, size.height * 0.21);
    path.quadraticBezierTo(size.width, size.height * 0.25, size.width, size.height*0.29);
    path.lineTo(size.width, size.height * 0.71); //c3
    path.quadraticBezierTo(size.width, size.height * 0.75, size.width*0.96, size.height*0.79);
    path.lineTo(size.width * 0.54, size.height*0.98);
    path.quadraticBezierTo(size.width*0.5, size.height, size.width*0.46, size.height*0.98);
    path.lineTo(size.width*0.04, size.height * 0.79);
    path.quadraticBezierTo(0.0, size.height * 0.75, 0.0, size.height * 0.71);
    path.lineTo(0.0, size.height * 0.29);
    path.quadraticBezierTo(0.0, size.height*0.25, size.width*0.04, size.height*0.21);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}