import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Service {
  Future login(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = "https://ukkhotel.smktelkom-mlg.sch.id/api/login";

    // Body diubah menjadi JSON string
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    print(body);

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Content-Type": "application/json", // Header yang benar untuk JSON
          "makerID": "4",
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        print('Login berhasil');
        final jsonResponse = json.decode(response.body);
        // Simpan token di shared preferences
        await prefs.setString("token", jsonResponse["access_token"]);

        return {
          "status": true,
          "data": jsonResponse,
        };
      } else {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        return {"status": false, "message": "username dan password salah"};
      }
    } catch (e) {
      print('Error: $e');
      return {"status": false, "message": "Terjadi kesalahan saat login"};
    }
  }
}
