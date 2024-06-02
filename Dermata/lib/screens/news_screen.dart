import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dermata/widgets/Cared_info.dart';
import 'package:dermata/widgets/nav_draw.dart';

import "data.dart" as data;

class NewspageScreen extends StatefulWidget {
  const NewspageScreen({Key? key}) : super(key: key);

  @override
  _NewspageScreenState createState() => _NewspageScreenState();
}

class _NewspageScreenState extends State<NewspageScreen> {
  late List mydata;
  late int mydatalength = -1;

  var dio = Dio();

  Future<String> loadJsonData() async {
    mydata = data.Data.news_data;
    mydatalength = mydata.length;
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // drawer: NavigationDrawerWidget(),

      appBar: AppBar(
        backgroundColor: Color(0xff008dff),
        title: Text("Know your Well Being"),
      ),
      body: (mydatalength == -1)
          ? Center(child: const CircularProgressIndicator())
          : FutureBuilder(
              builder: (context, snapshot) {
                return ListView.builder(
                  itemBuilder: (ctx, index) {
                    return CardItem(
                      id: mydata[index]["id"].toString(),
                      title: mydata[index]["title"],
                      image1: mydata[index]["image1"],
                      image2: mydata[index]["image2"],
                      article: mydata[index]["article"],
                      youtube: mydata[index]["youtube"],
                      description: mydata[index]["description"],
                    );
                  },
                  itemCount: (mydatalength == null) ? 0 : mydata.length,
                );
              },
            ),
    );
  }
}
