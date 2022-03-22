import 'package:flutter/material.dart';
import 'package:moviedb_api_app/screens/Widgets/custom_app_bar.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      CustomAppBar(),
      Container(
        color: Colors.amber,
        child: const Center(
          child: Text(
            'Progile Page',
            style: TextStyle(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    ]);
  }
}
