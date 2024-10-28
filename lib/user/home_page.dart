import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/room_detail.dart';
import '../http_services/detail_service.dart';
import 'room_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController checkin = TextEditingController();
  List<RoomDetail> rooms = [];
  final DetailService detailService = DetailService();
  String checkInDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  getAvailableRooms() async {
    DateTime date = DateFormat('yyyy-MM-dd').parse(checkInDate);
    List<RoomDetail> data = await detailService.getAvailableRooms(date);
    setState(() {
      rooms = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getAvailableRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Wikusama Hotel'),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
            width: MediaQuery.of(context).size.width * 0.30,
            child: TextField(
              controller: checkin,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Tanggal Check-in",
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 60)),
                );
                if (pickedDate != null) {
                  setState(() {
                    checkInDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    checkin.text = checkInDate;
                  });
                  getAvailableRooms();
                }
              },
            ),
          ),
    ),


          Expanded(
            child: GridView.extent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: EdgeInsets.all(8.0),
              children: rooms.map((room) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomDetailPage(
                          room: room,
                          date: DateFormat('yyyy-MM-dd').parse(checkInDate),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: [
                        Image.network(
                          'https://ukkhotel.smktelkom-mlg.sch.id/${room.photoPath}',
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/error.png',
                              fit: BoxFit.fitHeight,
                            );
                          },
                        ),
                        Text(room.typeName, style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),





// isLoading
          //     ? CircularProgressIndicator()
          //     : errorMessage.isNotEmpty
          //     ? Text('Error: $errorMessage')
          //     : Expanded(
          //   child: ListView.builder(
          //     itemCount: rooms.length,
          //     itemBuilder: (context, index) {
          //       final room = rooms[index];
          //       return ListTile(
          //         title: Text(room.typeName),
          //         subtitle: Text('Rp ${room.price}'),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) =>
          //                   RoomDetailPage(room: room, date: selectedDate),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}



// class _HomePageState extends State<HomePage> {
//   List rooms = [];
//   bool isLoading = true;
//   String errorMessage = '';
//   final Home homeService = Home(); // Initialize homeService here
//   DateTime? selectedData;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchRooms();
//   }
//
//   fetchRooms() async {
//     try {
//       final data = await homeService.getRoomTypes();
//       setState(() {
//         rooms = data; // Set the rooms list
//         isLoading = false; // Update loading state
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString(); // Capture error message
//         isLoading = false; // Update loading state
//       });
//     }     hj j
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Wikusama Hotel'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//           ? Center(child: Text('Error: $errorMessage'))
//           : ListView.builder(
//         itemCount: rooms.length,
//         itemBuilder: (context, index) {
//           final room = rooms[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, '/roomDetail',
//                   arguments: room);
//             },
//             child: Container(
//               margin: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       'https://ukkhotel.smktelkom-mlg.sch.id/${room.photoPath}'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               height: 200,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.black54,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       room.typeName,
//                       style: TextStyle(
//                           color: Colors.white, fontSize: 18),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'Rp ${room.price != null ? room.price.toString() : 'harga gada'}',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
