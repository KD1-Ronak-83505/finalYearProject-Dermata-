import 'package:flutter/material.dart';
import 'package:dermata/models/request.dart';
import 'package:dermata/constants.dart';

class RequestDetailScreen extends StatelessWidget {
  final Request request;

  RequestDetailScreen({required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Image.network('$apiUrl/${request.image}',
                height: MediaQuery.of(context).size.height * 0.50,
                fit: BoxFit.cover),
          ),
          SizedBox(height: 16.0),
          Text(
            "Image",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.0),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Result: ",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "${request.result}",
                  style: TextStyle(fontSize: 30.0),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
