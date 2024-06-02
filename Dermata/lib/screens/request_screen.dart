import 'package:dermata/constants.dart';
import 'package:flutter/material.dart';
import 'package:dermata/models/request.dart';
import 'package:dermata/screens/request_detail.dart';
import 'package:dermata/services/http.dart';

class RequestListScreen extends StatefulWidget {
  @override
  _RequestListScreenState createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  List<Request> requests = [];
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    try {
      final List<Request> fetchedRequests = await getRequestList();
      setState(() {
        requests = fetchedRequests;
        error = '';
      });
    } catch (e) {
      setState(() {
        requests = [];
        error = 'Failed to fetch request list: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: error.isNotEmpty
          ? Center(
              child: Text(error),
            )
          : ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RequestDetailScreen(request: request),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(12.0),
                              title: Text("${request.title} ${index + 1}"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Image.network(
                              '$apiUrl/${request.image}',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
