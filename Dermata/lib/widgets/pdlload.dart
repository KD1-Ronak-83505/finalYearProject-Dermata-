import 'package:flutter/material.dart';
import 'package:dermata/widgets/nav_draw.dart';

class PdfView extends StatelessWidget {
  const PdfView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // drawer: NavigationDrawerWidget(),

      appBar: AppBar(
          title: Text("Your Skin Analysis Report"),
          centerTitle: true,
          backgroundColor: Color(0xff008dff)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Welcome to the Dermata App",
                          style: TextStyle(fontSize: 30.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Wanna know about Dermata. Have a look!",
                          style: TextStyle(fontSize: 23.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Dermata is a skincare application that will aid doctors and patients in making initial diagnoses of disorders that affect the skin. Additionally, it offers customers a daily feed of skin care regimens that assist them keep their skin's beauty.",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "How to Use :",
                          style: TextStyle(fontSize: 25.0),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "If you want to check for Skin Diseases. Do the following Procedure:",
                          style: TextStyle(fontSize: 22.0),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "1. Take a picture of the impacted part.\n2. Send the picture for Analysis\n3. Get the analysis report that will identify your skin troubles using machine learning.",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Get daily skincare feeds:",
                          style: TextStyle(fontSize: 22.0),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "1. Get access to daily skincare routines and tips\n2. Have a look over the start and allTutorials page.\n3. Start will display the tutorials. AllTutorials will show you the update of all the Tutorials being seen on Start section and other Tutorials as well.\n4. Get your skincare in one place!",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
