import 'package:flutter/material.dart';

class ReHexForm extends StatelessWidget {
  final Widget child;
  ReHexForm(this.child);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ReHexClipper(),
      child: child,
    );
  }
}
class ReHexClipper extends CustomClipper<Path> {
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
  bool shouldReclip(ReHexClipper oldClipper) => false;
}
