import 'package:flutter/material.dart';
import '../http_services/transaction_service.dart';

class BookingConfirmationPage extends StatefulWidget {
  final int orderNumber;

  BookingConfirmationPage({required this.orderNumber});

  @override
  _BookingConfirmationPageState createState() => _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  final _transactionService = TransactionService();
  Map<String, dynamic>? orderDetails;

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    try {
      final details = await _transactionService.getOrderDetails(widget.orderNumber);
      setState(() {
        orderDetails = details;
      });
    } catch (e) {
      print("Error fetching order details: $e");
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    if (orderDetails == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Booking Confirmation")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Booking Confirmation")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("SUCCESS", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green))),
            Image.network('https://ukkhotel.smktelkom-mlg.sch.id/${orderDetails!['room_photo']}'),
            Text("Room ID: ${orderDetails!['room_id']}"),
            Text("Room Number: ${orderDetails!['room_number']}"),
            Text("Description: ${orderDetails!['room_desc']}"),
            Text("Guest Name: ${orderDetails!['guest_name']}"),
            Text("Customer: ${orderDetails!['customer_name']}"),
            Text("Check-in: ${orderDetails!['check_in_date']}"),
            Text("Check-out: ${orderDetails!['check_out_date']}"),
            Text("Total Payment: Rp ${orderDetails!['total_price']}"),

            SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text('FINISH'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
