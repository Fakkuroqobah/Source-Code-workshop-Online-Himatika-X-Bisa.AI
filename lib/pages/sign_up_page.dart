import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/pages/sign_in_page.dart';
import 'package:green_app/pages/splash.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordTC = TextEditingController();

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
                        controller: passwordTC,
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
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'konfirmasi password', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'password tidak boleh kosong';
                          }
                          if (passwordTC.text != value) {
                            return 'Password tidak sama';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        child: Text('Sign In'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            try {
                              FirebaseAuth.instance.createUserWithEmailAndPassword(email: _eMail, password: _password);
                            } catch (e) {
                              print(e);
                            }

                            print('email : $_eMail     password : $_password');
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash()));
                          }
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Text('SUdah punya akun ?  '),
                        InkWell(
                          child: Text('Sign IN'),
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
                          },
                        )
                      ],
                    )
                  ],
                ))));
  }
}
