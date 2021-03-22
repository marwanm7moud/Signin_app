import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../Provider.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController Email = TextEditingController();

  TextEditingController Password = TextEditingController();



  void _showDialog(String massege){
    showDialog(
        context: context, builder: (ctx)=>AlertDialog(
      title: Text("Error"),
      content: Text(massege),
      actions: [
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Ok"))
      ],
    )
    );
  }

  Future Submit() async{
    try{
      await Provider.of<MyProvider>(context , listen: false).signin(Email.text, Password.text);
      Navigator.of(context).pushReplacementNamed("main");
    }catch(error){
      var errorMessage = 'Authentication Failed';
      if(error.toString().contains('INVALID_EMAIL'))
        setState(() {
          errorMessage = "Please Enter an Valid Email or Password";
        });
      else if (error.toString().contains('INVALID_PASSWORD'))
        setState(() {
          errorMessage = "Please Enter an Valid Email or Password";
        });
      else if (error.toString().contains('EMAIL_NOT_FOUND'))
        setState(() {
          errorMessage = "This Email Address is not found";
        });




      _showDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    double _mediaQueryheight = MediaQuery.of(context).size.height;
    double _mediaQuerywidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.red, Colors.red.withOpacity(0.8)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )),
          width: double.infinity,
          height: _mediaQueryheight,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white,
                            fontSize: _mediaQuerywidth * 0.053,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "Bandio",
                    style: TextStyle(
                        fontSize: _mediaQuerywidth * 0.15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [

                      Container(
                        width: _mediaQuerywidth * 0.9,
                        child: TextField(
                          controller: Email,
                          onChanged: (value) {
                            setState(() {
                              Email.text == value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: UnderlineInputBorder(),
                            icon: Icon(Icons.person),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: _mediaQueryheight * 0.05,
                      ),
                      Container(
                        width: _mediaQuerywidth * 0.9,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              Password.text == value;
                            });
                          },
                          controller: Password,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: UnderlineInputBorder(),
                            icon: Icon(FontAwesome.key),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: _mediaQueryheight * 0.08,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red.withOpacity(0.4)
                        ),
                        height: _mediaQuerywidth * 0.12,
                        width: _mediaQuerywidth * 0.5,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.red.withOpacity(1),
                          child: Text("Sign in"),

                          onPressed: Email.text =="" || Password.text=="" ? null:(){
                            Submit();
                          },

                        ),
                      ),
                      SizedBox(
                        height: _mediaQueryheight * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          InkWell(
                            child: Text(" SignUp" , style: TextStyle(fontWeight: FontWeight.bold),),
                            onTap: () {
                              Navigator.of(context).pushNamed("signup");
                            },
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
