import 'package:flutter/material.dart';
import 'package:moviedb_api_app/screens/Widgets/custom_app_bar.dart';
import 'package:moviedb_api_app/screens/authpage/helper.dart';
import 'package:moviedb_api_app/screens/authpage/login_page.dart';

class ProfilePage extends StatefulWidget {
  final AuthService authProfile = AuthService();
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const CustomAppBar(),
      Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Column(
          children: [
            Text(
              "Welcome " +
                  widget.authProfile.auth.currentUser!.email.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
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
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Delete User",
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
                      authSer.DeleteUser(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => LoginPage()));
                    },
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                      size: 40,
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Password Update",
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
                      authSer.changePassword(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => LoginPage()));
                    },
                    child: const Icon(
                      Icons.key,
                      color: Colors.white,
                      size: 40,
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "E-Mail Update",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (context) {
                            return Container(
                              color: Colors.white,
                              height: 100,
                              width: 100,
                              child: Center(child: Text("Email")),
                            );
                          });
                    },
                    child: const Icon(
                      Icons.mail,
                      color: Colors.white,
                      size: 40,
                    ))
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
