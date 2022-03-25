// ignore_for_file: use_function_type_syntax_for_parameters

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moviedb_api_app/screens/authpage/login_page.dart';
import 'package:moviedb_api_app/screens/main_page.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void changePassword(context) async {
    await auth.currentUser!.updatePassword(password.text.toString());
  }

  void googleIleGir(context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void DeleteUser(context) async {
    if (auth.currentUser != null) {
      await auth.currentUser!.delete();
    } else {
      const AlertDialog(
        content: Text("Oturum Açın"),
      );
    }
  }

  void loginUserEmailAndPassword(context) async {
    try {
      var _userCr = await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      if (_userCr.user!.emailVerified == true) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const MainPage()));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Hata"),
                content: Text("Emailinizi Onaylayınız"),
              );
            });
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Hata"),
              content: Text(e.toString()),
            );
          });
    }
  }

  void createUserEmailAndPassword(context) async {
    try {
      var _userCredential = await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);

      if (!_userCredential.user!.emailVerified) {
        await _userCredential.user!.sendEmailVerification();
      }

      showDialog(
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: ((c) => LoginPage())));
              },
              child: const AlertDialog(
                title: Text("Welcome MovieDB "),
                content: Text("Mail adresinizi onaylayın."),
              ),
            );
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Hata"),
              content: Text(e.toString()),
            );
          });
    }
  }

  void logOutUser(context) async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (c) => LoginPage()), (route) => false);
  }
}
