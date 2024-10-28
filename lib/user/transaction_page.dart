import 'package:flutter/material.dart';
import '../http_services/transaction_service.dart';
import '../models/room_detail.dart';
import 'booking_confirmation_page.dart';

class TransactionPage extends StatefulWidget {
  final RoomDetail room;
  final int guests;
  final int rooms;
  final DateTime date;
  final DateTime checkOutDate;

  TransactionPage({
    required this.room,
    required this.guests,
    required this.rooms,
    required this.date,
    required this.checkOutDate,
  });

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _guestNameController = TextEditingController();
  final _transactionService = TransactionService();

  Future<void> _confirmBooking() async {
    final int days = widget.checkOutDate.difference(widget.date).inDays;
    final int totalPrice = widget.room.price * widget.rooms * days;

    try {
      // Memanggil layanan transaksi untuk membuat pesanan
      final orderNumber = await _transactionService.createOrder(
        customerName: _nameController.text,
        customerEmail: _emailController.text,
        guestName: _guestNameController.text,
        checkInDate: widget.date,
        checkOutDate: widget.checkOutDate,
        guests: widget.guests,
        rooms: widget.rooms,
        totalPrice: totalPrice,
        typeId: widget.room.typeId, // Tambahkan ini untuk memastikan typeId terkirim
      );

      if (orderNumber != null) {
        // Navigasi ke halaman konfirmasi pemesanan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingConfirmationPage(orderNumber: orderNumber),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      // Tampilkan pesan error jika terjadi masalah
    }
  }


  @override
  Widget build(BuildContext context) {
    final int days = widget.checkOutDate.difference(widget.date).inDays;
    final int totalPrice = widget.room.price * widget.rooms * days;

    return Scaffold(
      appBar: AppBar(title: Text("Transaction")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://ukkhotel.smktelkom-mlg.sch.id/${widget.room.photoPath}',
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name Customer'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _guestNameController,
              decoration: InputDecoration(labelText: 'Guest Name'),
            ),
            SizedBox(height: 16.0),
            Text("Check-in: ${widget.date.toLocal().toString().split(' ')[0]}"),
            Text("Check-out: ${widget.checkOutDate.toLocal().toString().split(' ')[0]}"),
            SizedBox(height: 16.0),
            Text("Guests: ${widget.guests}"),
            Text("Rooms: ${widget.rooms}"),
            Text("Total Price: Rp $totalPrice"),
            SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: _confirmBooking,
                child: Text('CONFIRM BOOKING'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
