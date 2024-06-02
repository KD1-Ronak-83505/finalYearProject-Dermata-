import 'dart:convert';
import 'package:dermata/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dermata/constants.dart';

class AuthService {
  late SharedPreferences _prefs;

  AuthService() {
    init();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String?> register(String email, String name, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'name': name, 'password': password}),
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      final user = User.fromJson(data);
      return "Registration Successful";
    } else {
      final errorMessage = data['error'];
      return Future.error(errorMessage);
    }
  }

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await _prefs.setString('token', data["access"]);
      await _prefs.setString('refresh', data["refresh"]);
      await _prefs.setString('email', data["email"]);
      await _prefs.setString('name', data["name"]);
      return "Successful";
    } else {
      final errorMessage = data['error'];
      return Future.error(errorMessage);
    }
  }

  Future<bool?> getLoggedInUser() async {
    await init();

    final token = _prefs.getString('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    await _prefs.clear();
  }
}
