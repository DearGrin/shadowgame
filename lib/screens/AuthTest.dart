import 'package:flutter/material.dart';
import 'package:web/bloc/auth.dart';
import 'package:web/bloc/controller.dart';

class TestAuth extends StatefulWidget {
  @override
  _TestAuthState createState() => _TestAuthState();
}

class _TestAuthState extends State<TestAuth> {
  final Auth controller = Auth();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      child: FloatingActionButton(
        onPressed: test,
      ),
    );
  }
  void test(){
    controller.testGoogle();
  }
}
