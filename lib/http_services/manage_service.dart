import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Kelas ManageService
class ManageService {
  final String baseUrl = 'https://ukkhotel.smktelkom-mlg.sch.id/api';

  // Mendapatkan data kamar
  Future<List<dynamic>> getRooms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    final response = await http.get(
      Uri.parse('$baseUrl/type'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        "makerID": "4",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)["data"];
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  // Menambah kamar
  Future<void> addRoom(int roomId, int roomNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    final response = await http.post(
      Uri.parse('$baseUrl/room'),
      headers: {
        'Authorization': 'bearer $token',
        'Content-Type': 'application/json',
        "makerID":"4",
      },
      body: json.encode({
        'type_id': roomId,
        'room_number': roomNumber,
      }),
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    }  else{
      print(response.statusCode );
      throw Exception('Failed to add room');
    }
  }
}