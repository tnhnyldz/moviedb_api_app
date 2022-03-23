import 'package:flutter/material.dart';
import 'package:moviedb_api_app/screens/Widgets/custom_app_bar.dart';
import 'package:moviedb_api_app/screens/authpage/helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const CustomAppBar(),
      Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Log Out",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
              onPressed: () {
                AuthService authSer = AuthService();
                authSer.logOutUser(context);
              },
              child: const Icon(
                Icons.login_outlined,
                color: Colors.white,
                size: 40,
              ))
        ],
      )
    ]);
  }
}
