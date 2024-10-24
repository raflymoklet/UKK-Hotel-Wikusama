import 'dart:io';

import 'package:coba1/admin/manage_room.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../http_services/manage_type.dart';
import 'package:coba1/admin/manage_room.dart';

import '../http_services/manage_service.dart'; // Import halaman ManageRoomTypes

class ManageTypeRoom extends StatefulWidget { // Ganti nama class
  @override
  _ManageTypeRoomState createState() => _ManageTypeRoomState(); // Sesuaikan nama state
}

class _ManageTypeRoomState extends State<ManageTypeRoom> { // Ganti nama state
  List rooms = [];
  ManageService apiService = ManageService(); // Memanggil API service
  ManageTypeService apiServiceType = ManageTypeService();
  List roomTypes = [];
  @override
  void initState() {
    super.initState();
    fetchRooms();
  }

  Future<void> fetchRoomTypes() async {
    try {
      final data = await apiServiceType.getRoomTypes();
      setState(() {
        roomTypes = data;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchRooms() async {
    try {
      final data = await apiService.getRooms();
      setState(() {
        rooms = data;
      });
      print(rooms);
    } catch (e) {
      print(e);
    }
  }

  Future<void> addRoom(int roomId, int roomTypeId) async {
    try {
      await apiService.addRoom(roomId, roomTypeId); // Pemanggilan API dengan 2 parameter
      fetchRooms(); // Refresh data setelah menambah kamar
    } catch (e) {
      print(e);
    }
  }


  Future<void> removeRoom(int roomId) async {
    try {
      // await apiService.removeRoom(roomId);
      fetchRooms(); // Refresh data setelah mengurangi kamar
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Rooms Type'),
      ),
      body: rooms.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 4.0,
            child: Row(
              children: <Widget>[
                // Gambar kamar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://ukkhotel.smktelkom-mlg.sch.id/'+room["photo_path"]
                      ), // Path gambar
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                // Informasi kamar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${room['type_name']} - ${room['type_id']}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('price: ${room['price']}'),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddRoomTypeForm(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddRoomTypeForm(BuildContext context) {
    TextEditingController typeIdController = TextEditingController();
    TextEditingController typeNameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    List<String> features = []; // To store list of features
    XFile? selectedImage; // For uploaded image

    final picker = ImagePicker();

    Future _pickImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        selectedImage = image;
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Room Type'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: typeIdController,
                  decoration: InputDecoration(labelText: 'Type ID'),
                ),
                TextField(
                  controller: typeNameController,
                  decoration: InputDecoration(labelText: 'Type Name'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: _pickImage, child: Text("Select Picture")),
                selectedImage != null
                    ? Container(
                  child: Image.file(File(selectedImage!.path)),
                  width: MediaQuery.of(context).size.width,
                )
                    : Center(child: Text("Please Get the Image")),
                SizedBox(height: 10),
                TextField(
                  onSubmitted: (value) {
                    setState(() {
                      features.add(value); // Add feature to list
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Add Feature',
                    hintText: 'Type and hit enter',
                  ),
                ),
                Wrap(
                  children: features
                      .map((feature) => Chip(label: Text(feature)))
                      .toList(),
                )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                // Submit form data to API
                await apiServiceType.addRoomType(
                  int.parse(typeIdController.text),
                  typeNameController.text,
                  double.parse(priceController.text),
                  descriptionController.text,
                  features,
                  File(selectedImage!.path), // Pass image file
                );

                // Refresh room type list
                fetchRoomTypes();

                // Close the form and return success result
                Navigator.of(context).pop(true);
              },
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Close the form
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
