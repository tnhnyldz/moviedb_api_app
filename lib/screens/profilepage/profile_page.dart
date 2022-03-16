import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: Center(
          child: Text(
            'Profile Page',
            style: TextStyle(
              backgroundColor: Colors.white,
            ),
          ),
        ));
  }
}
