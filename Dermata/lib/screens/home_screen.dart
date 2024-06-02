import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dermata/widgets/nav_draw.dart';
import 'package:dermata/widgets/button.dart';
import 'package:dermata/services/auth.dart';
import 'package:dermata/screens/camera_screen.dart';

import '../main.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late final AuthService _authService;
  String? _name;
  String? _email;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name');
      _email = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color(0xff008dff),
        title: Text("Dermata"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              bool confirmLogout = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Logout"),
                    content: Text("Do you want to logout?"),
                    actions: [
                      TextButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop(
                              false); // Return false if user cancels logout
                        },
                      ),
                      TextButton(
                        child: Text("Yes"),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(true); // Return true if user confirms logout
                        },
                      ),
                    ],
                  );
                },
              );

              if (confirmLogout == true) {
                // Call the logout method or perform any necessary logout logic
                await _authService.logout();

                // Navigate to the Welcome screen
                await Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Welcome()),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Dermata",
                style: TextStyle(fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Row(),
              ClipOval(
                child: Material(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                _name ?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '( $_email )' ?? '',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 50.0),
              Text(
                "Please proceed to scan skin and get analysis report",
                style: TextStyle(fontSize: 23.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60.0),
              Button(
                title: "Scan Skin",
                shade: Color(0xff9dd6e5),
                factor: 0.6,
                onTap: () => Get.to(() => CameraPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
