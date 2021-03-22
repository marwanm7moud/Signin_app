import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:signapp/Screen/MainScreen.dart';
import 'dart:io';

import '../Provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  TextEditingController Username = TextEditingController(text: "");
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController Confirm_Password = TextEditingController();

  bool isnotEmpty = false;
  String m ;

  void SignUpVerify(){
    if(Username.text!="" && Email.text!=""&&Password.text!="" && Confirm_Password.text!=""){
     setState(() {
       isnotEmpty=true;
     });

    }else{
      setState(() {
        isnotEmpty=false;
      });
    }
}

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
    if(Password.text!=Confirm_Password.text)
      throw "Verify";
    await Provider.of<MyProvider>(context , listen: false).signup(Email.text, Password.text);
    Navigator.of(context).pushReplacementNamed("main");
  }catch(error){
    var errorMessage = 'Authentication Failed';
    if(error.toString().contains('EMAIL_EXISTS'))
      setState(() {
        errorMessage = "This Email Address is already in use";
      });
    else if (error.toString().contains('WEAK_PASSWORD'))
      setState(() {
        errorMessage = "This Password is very weak ,\nPassword should be at 6 characters";
      });
    else if (error.toString().contains('Verify'))
      setState(() {
        errorMessage = "Password do not match";
      });
    
    
    
    
    _showDialog(errorMessage);
  }
}

  File _image;
  final picker = ImagePicker();
  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Choose where do you want"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(15.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }
  void _openGallery(BuildContext context) async {
    final picture = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(picture.path);
    });
    Navigator.pop(context);
  }
  void _openCamera(BuildContext context) async {
  final pickedFile = await picker.getImage(source: ImageSource.camera);

  setState(() {
      _image = File(pickedFile.path);
  });
  Navigator.pop(context);
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
          height: MediaQuery.of(context).size.height,
          child: Column(

            children: [
              Expanded(
                flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0 , right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon:Icon(Icons.arrow_back_ios , color: Colors.white,),
                          onPressed: (){
                              Navigator.pop(context);
                          },
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width * 0.053,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                  child: InkWell(
                    onTap: (){
                      _showSelectionDialog(context);
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                        image: _image == null ?null: DecorationImage(
                          image: FileImage(_image),
                          fit: BoxFit.cover
                        )
                      ),
                      child: _image == null ? Icon(FontAwesome.camera , color: Colors.white,):null

                      ),
                    ),
                  )
              ,
              Expanded(
                flex: 4,
                  child: Column(
                    children: [
                      SizedBox(
                        height: _mediaQueryheight * 0.02,
                      ),
                      Container(
                        width: _mediaQuerywidth * 0.9,
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              Username.text=val;
                              SignUpVerify();
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: UnderlineInputBorder(),
                            icon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _mediaQueryheight * 0.03,
                      ),
                      Container(
                        width: _mediaQuerywidth * 0.9,
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              Email.text=val;
                              SignUpVerify();
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: UnderlineInputBorder(),
                            icon: Icon(Icons.email),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: _mediaQueryheight * 0.03,
                      ),
                      Container(
                        width: _mediaQuerywidth * 0.9,
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              Password.text=val;
                              SignUpVerify();
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: UnderlineInputBorder(),
                            icon: Icon(FontAwesome.key),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: _mediaQueryheight * 0.03,
                      ),
                      Container(
                        width: _mediaQuerywidth * 0.9,
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              Confirm_Password.text=val;
                              SignUpVerify();
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: UnderlineInputBorder(),
                            icon: Icon(FontAwesome.key),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: _mediaQueryheight * 0.07,
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
                            child: Text("Sign Up" ,),

                            onPressed: isnotEmpty==false?null: ()=>Submit()

                          
                        ),
                      ),
                    ],
                  )
              )

            ],
          ),
        ),
      ),
    );
  }
}
