import 'package:flash_chat_flutter/components/input_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;

  Future<void> registerUser() async {
    setState(() => showSpinner = true);
    try {
      var newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser.user != null) {
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
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
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
                buttonName: 'Register',
                buttonColor: Colors.blueAccent,
                onPressed: () {
                  registerUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
