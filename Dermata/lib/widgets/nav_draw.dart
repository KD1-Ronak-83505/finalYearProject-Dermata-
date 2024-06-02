import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dermata/widgets/pdlload.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dermata/screens/camera_screen.dart';
import 'package:dermata/screens/home_screen.dart';
import 'package:dermata/screens/news_screen.dart';
import 'package:dermata/screens/request_screen.dart';

import '../main.dart';

class NavigationDrawerWidget extends StatelessWidget {
  String? name, email;
  final photo = "assets/user.png";

  Future<void> _loadUserInfo() async {
    final _prefs = await SharedPreferences.getInstance();

    final loadedName = _prefs.getString('name');
    final loadedEmail = _prefs.getString('email');
    // final loadedPhoto = _prefs.getString('photo');

    if (loadedName != null) {
      name = loadedName;
    }

    if (loadedEmail != null) {
      email = loadedEmail;
    }

    // if (loadedPhoto != null) {
    //   photo = loadedPhoto;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadUserInfo(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Text(
              'Error loading user information'); // Show an error message if there was an error loading data
        } else {
          // User information is loaded successfully, build the drawer content
          return Drawer(
            child: Material(
              color: Color(0xff008dff),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: <Widget>[
                  buildHeader(
                      urlImage: photo ?? "assets/user.png",
                      name: name ?? "null",
                      email: email ?? "null",
                      space: MediaQuery.of(context).size.height),
                  buildMenuItem(
                    text: "Home",
                    icon: Icons.home,
                    onClicked: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => homeScreen()),
                        (Route<dynamic> route) => false),
                  ),
                  buildMenuItem(
                    text: "History",
                    icon: Icons.history_rounded,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RequestListScreen(),
                    )),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.05,
                  // ),
                  buildMenuItem(
                    text: "Scan Skin",
                    icon: Icons.search,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CameraPage(),
                    )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  buildMenuItem(
                    text: "Skincare Feed",
                    icon: Icons.nightlife,
                    onClicked: () => Get.to(() => NewspageScreen()),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  buildMenuItem(
                    text: "Help",
                    icon: Icons.help,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PdfView(),
                    )),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String? name,
    required String? email,
    required var space,
  }) =>
      InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: space * 0.05),
          child: Row(
            children: [
              // CircleAvatar(
              //     radius: 30,
              //     backgroundImage: AssetImage(urlImage ?? "assets/user.png")),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email ?? "",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
