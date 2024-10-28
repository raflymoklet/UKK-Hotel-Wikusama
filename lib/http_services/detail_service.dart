import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/room_detail.dart';

class DetailService {
  final String baseUrl = 'https://ukkhotel.smktelkom-mlg.sch.id/api';
  final Map<String, String> headers = {
    'makerID': '4',
  };

  Future<List<RoomDetail>> getAvailableRooms(DateTime date) async {
    final response = await http.get(
      Uri.parse('$baseUrl/type?date=${date.toIso8601String()}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => RoomDetail.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load available rooms');
    }
  }

  Future<void> bookRoom(int roomId, int guests, int rooms, DateTime date) async {
    final body = jsonEncode({
      'room_id': roomId,
      'guests': guests,
      'rooms': rooms,
      'date': date.toIso8601String(),
    });

    final response = await http.post(
      Uri.parse('$baseUrl/book'),
      headers: {
        'Content-Type': 'application/json',
        ...headers,
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to book room');
    }
  }
}
