import 'package:coba1/user/transaction_page.dart';
import 'package:flutter/material.dart';
import '../models/room_detail.dart';

class RoomDetailPage extends StatefulWidget {
  final RoomDetail room;
  final DateTime date;

  RoomDetailPage({required this.room, required this.date});

  @override
  _RoomDetailPageState createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  int guests = 1;
  int rooms = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.room.typeName)),
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
            Text(
              'Rp ${widget.room.price} / day',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Fasilitas: ${widget.room.desc}'),
            SizedBox(height: 16.0),
            Text('Booking Date: ${widget.date.toLocal().toString().split(' ')[0]}'),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Guests:'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => setState(() {
                        if (guests > 1) guests--;
                      }),
                    ),
                    Text('$guests'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => setState(() => guests++),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rooms:'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => setState(() {
                        if (rooms > 1) rooms--;
                      }),
                    ),
                    Text('$rooms'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => setState(() => rooms++),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionPage(
                          room: widget.room,
                          guests: guests,
                          rooms: rooms,
                          date: widget.date,
                          checkOutDate: widget.date.add(Duration(days: 1)),
                      ),
                    ),
                  );
                },
                child: Text('BOOKING'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
