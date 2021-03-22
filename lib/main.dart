import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signapp/Provider.dart';
import 'package:signapp/Screen/MainScreen.dart';
import 'package:signapp/Screen/Sign_In_Screen.dart';

import 'Screen/Sign_Up_Screen.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (_)=>MyProvider() ,
        child: MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'signin':(context)=>SignInScreen() ,
        'signup':(context)=>SignUpScreen() ,
        'main':(context)=>MainScreen()
      },
      home: SignInScreen(),
    );
  }
}
