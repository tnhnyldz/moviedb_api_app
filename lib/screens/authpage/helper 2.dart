import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_api_app/screens/authpage/login_page.dart';
import 'package:moviedb_api_app/screens/main_page.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void LoginUser(context) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Center(
                child: CircularProgressIndicator(),
              ),
            );
          });
      await auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) => {
                print("User is Logged In"),
                print(value.user!.email.toString()),
                Navigator.pop(context),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (c) => const MainPage())),
                //Navigator.pop(context)
              });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(e.toString()),
            );
          });
    }
  }

  void RegisterUser(context) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Center(
                child: CircularProgressIndicator(),
              ),
            );
          });
      await auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then(
              (value) => {print("User Is Registered"), Navigator.pop(context)});
    } catch (e) {
      print(e);
    }
  }

  void logOutUser(context) async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (c) => LoginPage()), (route) => false);
  }
}
