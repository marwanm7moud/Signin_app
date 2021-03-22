import 'package:flutter/material.dart';
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text("Task 1 \n Successful" , style: TextStyle(fontSize: 30),),
        ),
      ),
    );
  }
}
