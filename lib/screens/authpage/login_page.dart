import 'package:flutter/material.dart';
import 'package:moviedb_api_app/constants/consts.dart';
import 'package:moviedb_api_app/screens/authpage/helper.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    authService.email.text = "ydcode1@gmail.com";
    authService.password.text = "jklm997ask";
    return Scaffold(
      backgroundColor: Constants.background2,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(25),
                child: Image.asset("assets/a.png")),
            const Text(
              'Login Your Account',
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: authService.email,
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  iconColor: Colors.red,
                  suffixIcon: Icon(Icons.mail),
                  labelText: "E-Mail",
                  labelStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: authService.password,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.key),
                  labelText: "Password",
                  labelStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            ElevatedButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20)),
                onPressed: () {
                  if (authService.email != "" && authService.password != "") {
                    authService.loginUserEmailAndPassword(context);
                  }
                },
                child: const Text("Login")),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: const Text(
                  "Don't  have an account? Register ",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
            InkWell(
              onTap: () {
                authService.googleIleGir(context);
              },
              child: Container(
                height: 50,
                width: 50,
                child: Image.asset("assets/search.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Register Your Account',
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: authService.email,
              decoration: InputDecoration(
                  labelText: "E-Mail",
                  labelStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: authService.password,
              decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            ElevatedButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20)),
                onPressed: () {
                  if (authService.email != "" && authService.password != "") {
                    authService.createUserEmailAndPassword(context);
                  }
                },
                child: const Text("Register")),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: const Text("Already have an account? Login "))
          ],
        ),
      ),
    );
  }
}
