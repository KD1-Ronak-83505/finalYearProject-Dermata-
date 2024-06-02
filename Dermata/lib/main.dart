import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dermata/widgets/button.dart';
import 'package:dermata/services/auth.dart';
import 'package:dermata/screens/home_screen.dart';
import 'package:dermata/screens/login_screen.dart';
import 'package:dermata/screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthService authService = AuthService();
  bool? isLoggedIn = await authService.getLoggedInUser();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: isLoggedIn != false ? homeScreen() : Welcome(),
  ));
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/logo.png",
          ),
          new Padding(padding: const EdgeInsets.only(top: 40.0)),
          Button(
            title: "Login",
            shade: Color(0xff9dd6e5),
            factor: 0.6,
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              )
            },
          ),
          new Padding(padding: const EdgeInsets.only(top: 10.0)),
          Button(
            title: "Register",
            shade: Color(0xff9dd6e5),
            factor: 0.6,
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistrationScreen()),
              )
            },
          ),
        ],
      ),
    );
  }
}
