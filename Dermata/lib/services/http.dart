import 'dart:convert';
import 'package:dermata/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dermata/models/request.dart';

Future<dynamic> sendToPredictor(imagePath) async {
  var request = http.MultipartRequest('POST', Uri.parse('$apiUrl/request/'));
  request.files.add(await http.MultipartFile.fromPath('image',
      imagePath)); // imagePath is the path of the image file on the device

  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? token = _prefs.getString('token');

  if (token != null) {
    request.headers['Authorization'] = 'Bearer $token';

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var parsedData = jsonDecode(responseBody);
      return parsedData;
    } else if (response.statusCode == 401) {
      var responseBody = await response.stream.bytesToString();
      var parsedData = jsonDecode(responseBody);
      final errorMessage = parsedData['messages']['message'];
      return Future.error(errorMessage);
    } else {
      throw Exception('Error uploading image.');
    }
  } else {
    throw Exception('Token not found.');
  }
}

Future<List<Request>> getRequestList() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? token = _prefs.getString('token');

  final response = await http.get(
    Uri.parse('$apiUrl/request/'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);
    final List<Request> requests = [];

    for (var data in responseData) {
      final Request request = Request(
          title: 'Request', image: data['image'], result: data['result']);
      requests.add(request);
    }

    return requests;
  } else {
    final errorResponse = jsonDecode(response.body);
    final errorMessage = errorResponse['error'];
    return Future.error(errorMessage);
  }
}
