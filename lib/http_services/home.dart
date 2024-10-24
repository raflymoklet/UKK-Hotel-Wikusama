import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/room.dart';

class Home {
  final String baseUrl = 'https://ukkhotel.smktelkom-mlg.sch.id/api/type';

  Future<List<Room>> getRoomTypes() async {
    // Headers harus menggunakan makerID (huruf besar-kecil sesuai)
    final headers = {
      // 'Content-Type': 'application/json',
      'makerID':
          '4', // Header harus menggunakan makerID, sesuai dengan pesan error
    };

    print('Sending request to $baseUrl with headers: $headers');
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: headers,
    );
    await Future.delayed(Duration(seconds: 30));

    // print('Response status : ${response.statusCode}');
    // print('Response body: ${response.body}');
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];

      if (data == null) {
        return [];
      }
      // print(jsonResponse["data"].toString());
      // var datas = data.map((roomData) =>
      //     Room.fromJson(roomData)
      // ).toList();
      print("ok ");
      return [];
    } else {
      print("err");
      throw Exception('Failed to load room types: ${response.statusCode}');
    }
  }
}
