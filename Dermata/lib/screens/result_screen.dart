import 'package:flutter/material.dart';
import 'package:dermata/widgets/nav_draw.dart';
import 'package:dermata/widgets/button.dart';
import 'package:dermata/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatefulWidget {
  final String disease;
  final List symptoms;

  const ResultPage({Key? key, required this.disease, required this.symptoms})
      : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  var isLoading = false;

  // String disease = "Basal Cell Carcinoma";
  // String symptoms =
  // "- A pearly white, skin-colored or pink bump,\n- A brown, black or blue lesion,\n- A flat, scaly, reddish patch,\n- A white, waxy, scar-like lesion";
  //

  void openMapsApp(String query, BuildContext context) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$query';
    if (await canLaunch(url) != null) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch Maps app.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text("Your Analysis Report"),
          centerTitle: true,
          backgroundColor: Color(0xff008dff),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          color: Color(0xffe35f47),
                          icon: Icon(Icons.close),
                          onPressed: () =>
                              Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => homeScreen()),
                            (Route<dynamic> route) => false,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.disease}",
                        style: TextStyle(fontSize: 30.0),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.symptoms.map<Widget>((symptom) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.disease != "Normal Skin")
                                Text(
                                  "Symptoms",
                                  style: TextStyle(fontSize: 25.0),
                                  textAlign: TextAlign.center,
                                ),
                              SizedBox(height: 15),
                              if (widget.disease != "Normal Skin")
                                Text(
                                  "${symptom['disease']}",
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              Text("", style: TextStyle(fontSize: 3.0)),
                              Text(
                                "${symptom['symptoms']}",
                                style: TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.left,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Message: ",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: "${symptom['message']}",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 15),
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      if (widget.disease != "Normal Skin" &&
                          widget.disease !=
                              "Please upload image of Infected Area")
                        Button(
                          title: "Doctors Nearby",
                          shade: Color(0xff47ea78),
                          factor: 0.47,
                          onTap: () {
                            openMapsApp('skin doctor near me', context);
                          },
                        ),
                      Padding(padding: EdgeInsets.all(5.0)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              isLoading ? CircularProgressIndicator() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
