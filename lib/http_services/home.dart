import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/room.dart';

class Home {
  final String baseUrl = 'https://ukkhotel.smktelkom-mlg.sch.id/api/datefilter';

  Future getRoomTypes(checkin) async {
    // Headers with the correct makerID
    final headers = {
      'makerID': '4',
    };

    // Adding the date as a query parameter if it is provided
    final url = Uri.parse(baseUrl);
    print('Sending request to $url with headers: $headers');

    var response = await http.post(url, body: checkin, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];

      if (data == null) {
        return [];
      }

      // Mapping data to Room objects
      var datas =
          data.map((roomData) => Room.fromJson(roomData)).toList();
      print("Data fetched successfully");
      return datas;
    } else {
      print("Error fetching data");
      throw Exception('Failed to load room types: ${response.statusCode}');
    }
  }
}






// class Home {
//   final String baseUrl = 'https://ukkhotel.smktelkom-mlg.sch.id/api/type';
//
//   Future getRoomTypes() async {
//     // Headers harus menggunakan makerID (huruf besar-kecil sesuai)
//     final headers = {
//       // 'Content-Type': 'application/json',
//       'makerID':
//       '4', // Header harus menggunakan makerID, sesuai dengan pesan error
//     };
//
//     print('Sending request to $baseUrl with headers: $headers');
//     var response = await http.get(
//       Uri.parse(baseUrl),
//       headers: headers,
//     );
//     // await Future.delayed(Duration(seconds: 30));
//
//     // print('Response status : ${response.statusCode}');
//     // print('Response body: ${response.body}');
//     // print(response.body);
//     // print(response.body.length);
//     if (response.statusCode == 200) {
//       var jsonResponse = jsonDecode(response.body);
//       var data = jsonResponse['data'];
//
//       if (data == null) {
//         return [];
//       }
//       // print(jsonResponse["data"].toString());
//       var datas = data.map((roomData) => Room.fromJson(roomData)).toList();
//       print("ok ");
//       return datas;
//     } else {
//       print("err");
//       throw Exception('Failed to load room types: ${response.statusCode}');
//     }
//   }
// }
