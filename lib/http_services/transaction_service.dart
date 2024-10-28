import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionService {
  final String apiUrl = 'https://ukkhotel.smktelkom-mlg.sch.id/api/orders';
  final int makerID = 4;

  Future<int?> createOrder({
    required String customerName,
    required String customerEmail,
    required String guestName,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required int guests,
    required int rooms,
    required int totalPrice,
    required int typeId,
  }) async {
    // Debug print untuk memeriksa data sebelum dikirim
    print("Request Body: ${json.encode({
      'customer_name': customerName,
      'customer_email': customerEmail,
      'guest_name': guestName,
      'check_in': checkInDate.toIso8601String().split('T').first,
      'check_out': checkOutDate.toIso8601String().split('T').first,
      'guests': guests,
      'rooms_amount': rooms,
      'type_id': typeId,
      'total_price': totalPrice,
    })}");

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'makerID': makerID.toString(),
      },
      body: json.encode({
        'customer_name': customerName,
        'customer_email': customerEmail,
        'guest_name': guestName,
        'check_in': checkInDate.toIso8601String().split('T').first,
        'check_out': checkOutDate.toIso8601String().split('T').first,
        'guests': guests,
        'rooms_amount': rooms,
        'type_id': typeId,
        'total_price': totalPrice,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.containsKey('order_number')) {
        return data['order_number'];
      } else {
        print("Response does not contain order_number: ${response.body}");
        throw Exception('Response does not contain order_number');
      }
    } else {
      print("Failed to create order: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception('Failed to create order');
    }
  }




  Future<Map<String, dynamic>> getOrderDetails(int orderNumber) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$orderNumber?makerID=$makerID'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Failed to fetch order details: ${response.statusCode}");
      throw Exception('Failed to fetch order details');
    }
  }
}
