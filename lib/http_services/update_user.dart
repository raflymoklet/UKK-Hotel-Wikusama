
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserService {
  final String baseUrl = 'https://ukkhotel.smktelkom-mlg.sch.id/api/user';
  final String makerID = '4';
  Future<bool> updateUser(
      int userId, String userName, String role,String email, String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('$baseUrl/$userId');
    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "makerID": makerID,
        "Authorization": "Bearer ${prefs.getString("token")}",
      },
      body: jsonEncode({
        'user_name': userName,
        'email': email,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      return true; // Berhasil update
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return false; // Gagal update
    }
  }
}
