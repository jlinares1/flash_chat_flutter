import 'package:flash_chat_flutter/components/input_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;

  Future<void> logInUser() async {
    setState(() => showSpinner = true);
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        Navigator.pushNamed(context, ChatScreen.id);
      }
      setState(() => showSpinner = false);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              InputButton(
                hintText: 'Enter your email',
                onChanged: (value) => email = value,
              ),
              SizedBox(
                height: 8.0,
              ),
              InputButton(
                hintText: 'Enter your password',
                obscureText: true,
                onChanged: (value) => password = value,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonName: 'Log In',
                buttonColor: Colors.lightBlueAccent,
                onPressed: () {
                  logInUser();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
