import 'package:flutter/material.dart';

class TeamPositionUi extends StatefulWidget{
  final List<String> positions;
  TeamPositionUi(this.positions);
  @override
  State<StatefulWidget> createState() {
    return TeamPositionUiState();
  }
}

class TeamPositionUiState extends State<TeamPositionUi>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700.0,
      height: 600.0,
      child: Stack(
        children: [
          Positioned(
            left: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hex('03'),
                hex('05'),
                hex('07'),
                hex('09'),
              ],
            ),
          ),
          Positioned(
            top: 75.0,
            left: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hex('12'),
                hex('14'),
                hex('16'),
                hex('18'),
                hex('110'),
              ],
            ),
          ),
          Positioned(
            top: 150.0,
            left: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hex('21'),
                hex('23'),
                hex('25'),
                hex('27'),
                hex('29'),
                hex('211'),
              ],
            ),
          ),
          Positioned(
            top: 225.0,
            left: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hex('30'),
                hex('32'),
                hex('34'),
                hex('36'),
                hex('38'),
                hex('310'),
                hex('312'),
              ],
            ),
          ),
          Positioned(
            top: 300.0,
            left: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hex('41'),
                hex('43'),
                hex('45'),
                hex('47'),
                hex('49'),
                hex('411'),
              ],
            ),
          ),
          Positioned(
            top: 375.0,
            left: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hex('52'),
                hex('54'),
                hex('56'),
                hex('58'),
                hex('510'),
              ],
            ),
          ),
          Positioned(
            top: 450.0,
            left: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hex('63'),
                hex('65'),
                hex('67'),
                hex('69'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget teamMark(int team){
    return Positioned(
      top: team==1? 30:50,
      right: team==1? 10:40,
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: team==1? Color.fromARGB(255, 204, 102, 255) : Color.fromARGB(255, 51, 204, 102),
        ),
        child: Center(
          child: Text(
            '$team',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
  Widget hex(String id){
    if(id==widget.positions[1])
      {
        print('match $id and ' + widget.positions[1]);
      }
    return ClipPath(
      clipper: HexClipper(),
      child: Stack(
          children:[
            Container(
              width: 100,
              height: 100,
            ),
             id==widget.positions[0]? teamMark(1): Container(),
            id==widget.positions[1] ? teamMark(2) : Container(),

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