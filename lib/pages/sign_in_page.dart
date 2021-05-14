import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/pages/sign_up_page.dart';
import 'package:green_app/pages/splash.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  String _eMail;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(15),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'eMail', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'eMail tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _eMail = newValue;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'password', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'password tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _password = newValue;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        child: Text('Sign In'),
                        onPressed: () {
                          if( _formKey.currentState.validate()){
                            _formKey.currentState.save();

                            print('email : $_eMail     password : $_password');

                            try{
                              FirebaseAuth.instance.signInWithEmailAndPassword(email:_eMail, password: _password );
                            }catch(e){
                              print(e);
                            }

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash()));

                            

                          }
                        },
                      ),
                    ),
                    Row(children: [
                      Text('Belum punya aku ?  '),
                      InkWell(child: Text('Sign UP'),onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => SignUpPage()));
                      },)
                    ],)
                  ],
                ))));
  }
}
