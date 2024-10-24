import 'package:flutter/material.dart';
import 'package:coba1/http_services/manage_service.dart';

class ManageRoom extends StatefulWidget {
  @override
  _ManageRoomState createState() => _ManageRoomState();
}

class _ManageRoomState extends State<ManageRoom> {
  List roomTypes = [];
  ManageService apiService = ManageService();

  @override
  void initState() {
    super.initState();
    fetchRoomTypes();
  }

  Future<void> fetchRoomTypes() async {
    try {
      final data = await apiService.getRooms();
      setState(() {
        roomTypes = data;
      });
    } catch (e) {
      print(e);
    }
  }

  addRoom(int roomTypeId, String roomNumber) async {
    try {
      var result=await apiService.addRoom(roomTypeId, int.parse(roomNumber));

      return result;
      // Navigator.pop(context); // Close dialog
    } catch (e) {
      print(e);
    }
  }

  void showAddRoomDialog(int roomTypeId) {
    String roomNumber = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Room'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                roomNumber = value;
              });

            },
            decoration: InputDecoration(hintText: "Enter Room Number"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () async{
                if (roomNumber.isNotEmpty) {
                  var result=await addRoom(roomTypeId, roomNumber);

                  fetchRoomTypes(); // Refresh data
                  Navigator.of(context).pop(); // Close dialog
                } else {
                  // Handle empty input if needed
                  // Navigator.of(context).pop(); // Close dialog
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Room'),
      ),
      body: roomTypes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: roomTypes.length,
        itemBuilder: (context, index) {
          final roomType = roomTypes[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${roomType['type_name']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showAddRoomDialog(roomType['type_id']); // Call dialog function here
                    },
                    child: Text('Add Room'),
                  ),
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}