
import 'package:flutter/material.dart';

class NavigatorHint extends StatefulWidget{
  final List<String> clues;
  final List<String> police;
  double maxWidth;
  NavigatorHint(this.clues, this.police, this.maxWidth);
  @override
  State<StatefulWidget> createState() {
    return NavigatorHintState();
  }
}

class NavigatorHintState extends State<NavigatorHint>{
  double _size = 30;
  @override
  Widget build(BuildContext context) {
    _size = widget.maxWidth>800? 40.0:25.0;
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      width: 700.0,
      height: 600.0,
      child: Center(
        child: Stack(
          children: [
            Positioned(
              left: _size/2+_size,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 5,),
                  hex('03'),
                  Container(width: 5,),
                  hex('05'),
                  Container(width: 5,),
                  hex('07'),
                  Container(width: 5,),
                  hex('09'),
                  Container(width: 5,),
                ],
              ),
            ),
            Positioned(
              top: _size/2 + 10,
              left: _size,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 5,),
                  hex('12'),
                  Container(width: 5,),
                  hex('14'),
                  Container(width: 5,),
                  hex('16'),
                  Container(width: 5,),
                  hex('18'),
                  Container(width: 5,),
                  hex('110'),
                  Container(width: 5,),
                ],
              ),
            ),
            Positioned(
              top: _size + 20,
              left: _size/2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 5,),
                  hex('21'),
                  Container(width: 5,),
                  hex('23'),
                  Container(width: 5,),
                  hex('25'),
                  Container(width: 5,),
                  hex('27'),
                  Container(width: 5,),
                  hex('29'),
                  Container(width: 5,),
                  hex('211'),
                  Container(width: 5,),
                ],
              ),
            ),
            Positioned(
              top: _size+_size/2 + 30,
              left: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 5,),
                  hex('30'),
                  Container(width: 5,),
                  hex('32'),
                  Container(width: 5,),
                  hex('34'),
                  Container(width: 5,),
                  hex('36'),
                  Container(width: 5,),
                  hex('38'),
                  Container(width: 5,),
                  hex('310'),
                  Container(width: 5,),
                  hex('312'),
                  Container(width: 5,),
                ],
              ),
            ),
            Positioned(
              top: _size*2 + 40,
              left: _size/2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 5,),
                  hex('41'),
                  Container(width: 5,),
                  hex('43'),
                  Container(width: 5,),
                  hex('45'),
                  Container(width: 5,),
                  hex('47'),
                  Container(width: 5,),
                  hex('49'),
                  Container(width: 5,),
                  hex('411'),
                  Container(width: 5,),
                ],
              ),
            ),
            Positioned(
              top: _size*2+_size/2 + 50,
              left: _size,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 5,),
                  hex('52'),
                  Container(width: 5,),
                  hex('54'),
                  Container(width: 5,),
                  hex('56'),
                  Container(width: 5,),
                  hex('58'),
                  Container(width: 5,),
                  hex('510'),
                  Container(width: 5,),
                ],
              ),
            ),
            Positioned(
              top: _size*3 + 60,
              left: _size/2+_size,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 5,),
                  hex('63'),
                  Container(width: 5,),
                  hex('65'),
                  Container(width: 5,),
                  hex('67'),
                  Container(width: 5,),
                  hex('69'),
                  Container(width: 5,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget hex(String id){
    Color color;
    String asset;
    if(id==widget.clues[0].toString()||id==widget.clues[1].toString()||id==widget.clues[2].toString())
      {
        color = Colors.green;
        asset = 'assets/moroz.png';
      }
    else if(id==widget.police[0].toString()||id==widget.police[1].toString()||id==widget.police[2].toString())
      {
        color = Colors.red;
        asset = 'assets/snowman.png';
      }
    else{
      color = Colors.white;
      asset = 'assets/empty.png';
    }
    return ClipPath(
      clipper: HexClipper(),
      child: Stack(
          children:[
            Container(
              width: _size,
              height: _size,
             // color: color,

              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(asset), fit: BoxFit.contain),
              ),



            ),

          ]
      ),
    );
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