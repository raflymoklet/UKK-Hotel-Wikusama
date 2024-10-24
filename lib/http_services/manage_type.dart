import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ManageTypeService {
  final String baseUrl = 'https://ukkhotel.smktelkom-mlg.sch.id/api/type';

  // Fetch room types from API
  Future<List<dynamic>> getRoomTypes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await http.get(
      Uri.parse('$baseUrl/room_types'),
      headers: {
        'Authorization': 'Bearer ' + token!,
        'Content-Type': 'application/json',
        "makerID": "4",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load room types');
    }
  }

  // Add new room type
  Future<void> addRoomType(int typeId, String typeName, double price,
      String description, List<String> features, File? image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl'));
    request.headers.addAll({
      'Authorization': 'Bearer ' + token!,
      "makerID": "4",
    });

    request.fields['type_name'] = typeName;
    request.fields['price'] = price.toString();
    request.fields['desc'] = description;
    request.fields['photo'] = AutofillHints.photo;
    print(image);
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', image.path.toString()));
    }

    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to add room type' + response.statusCode.toString());
    }
  }

  // Delete room type by ID
  Future<void> deleteRoomType(int typeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await http.delete(
      Uri.parse('$baseUrl/$typeId'),
      headers: {
        'Authorization': 'Bearer ' + token!,
        'Content-Type': 'application/json',
        "makerID": "4",
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete room type');
    }
  }
}
