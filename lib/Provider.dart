import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class MyProvider with ChangeNotifier{

  Future<void> _auth (String Email , String Password , String urlsegment)async{
   final String url = "https://identitytoolkit.googleapis.com/v1/accounts:$urlsegment?key=AIzaSyDNli-nuZYDEDOgjTNKhbDMMK83alz73OU" ;
   try{
     final res  = await http.post(Uri.parse(url) , body: json.encode({
       'email':Email ,
       'password' : Password ,
       'returnSecureToken' : true
     }));
     final ResPonseData = json.decode(res.body);
     if(ResPonseData['error'] !=null){
       throw "${ResPonseData['error']['message']}";
     }
   }catch(e){
     throw e;
   }
  }
  Future<void> signup(String Email , String Password )async{
   await _auth(Email , Password , "signUp");
  }
  Future<void> signin(String Email , String Password )async{
   await _auth(Email , Password , "signInWithPassword");

  }
}