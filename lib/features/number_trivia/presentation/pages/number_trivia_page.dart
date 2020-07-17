import 'package:flutter/material.dart';

class NumberTriviaPage extends StatelessWidget {
  final String title;
  NumberTriviaPage({this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Number Trivia"),
        ),
        body: Container(child: Text("this is body"),),
      ),
    );
  }
}
