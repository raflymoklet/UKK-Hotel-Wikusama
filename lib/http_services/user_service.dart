import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserService {
  final String baseUrl = 'https://ukkhotel.smktelkom-mlg.sch.id/api';
  final String makerID = '4';
  // Ganti dengan token yang valid

  Future<List<User>> getUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await http.get(Uri.parse('$baseUrl/user'), headers: {
      'makerID': makerID,
      'Authorization': 'Bearer ' +token!,
    });
    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['user'];
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users'+ response.statusCode.toString());
    }
  }

  Future<void> addUser(String name, String email, String password, String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse('$baseUrl/register'),
      headers: {
        "Authorization": "Bearer ${prefs.getString("token")}",
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'role': role,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add user');
    }
  }

  Future<void> updateUser(int id, String name, String email, String role, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.put(Uri.parse('$baseUrl/user/$id'),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
        'Content-Type': 'application/x-www-form-urlencoded',
        'makerID' : '4',
      },
      body: {
        'name': name,
        'email': email,
        'role': role,
        'password' : password,
      },
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(Uri.parse('$baseUrl/user/$id'),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
        'makerID' : '4',

      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}