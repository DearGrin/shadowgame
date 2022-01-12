import 'package:flutter/material.dart';

class HexForm extends StatefulWidget {
  final Widget child;
  final int type;
  HexForm(this.child, this.type);
  @override
  _HexFormState createState() => _HexFormState();
}

class _HexFormState extends State<HexForm> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: widget.type==0? HexHorClipper():HexClipper(),
      child: widget.child,
    );
  }
}
class HexHorClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.05, 0.0);
    path.lineTo(size.width * 0.95, 0.0);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.95, size.height);
    path.lineTo(size.width * 0.05, size.height);
    path.lineTo(0.0, size.height * 0.5);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(HexHorClipper oldClipper) => false;
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
