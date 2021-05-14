import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/pages/home_page.dart';
import 'package:green_app/pages/sign_in_page.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {




  checkUser() async {
    
    await Future.delayed(Duration(seconds: 2));
    User user = FirebaseAuth.instance.currentUser;
    if(user == null){
      Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => SignInPage()));

    }else{
      Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => HomePage()));
    }

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => checkUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
              Text('Loading ...')],
          ),
        ),
      ),
    );
  }
}
