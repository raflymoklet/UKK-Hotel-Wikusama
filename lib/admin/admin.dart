import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coba1/admin/manage_room.dart';
import 'package:coba1/admin/manage_type_room.dart';
import 'package:coba1/admin/manage_users.dart';
import 'manage_room.dart';

import 'admin_login_page.dart';
import 'dart:async';
import '../main.dart';

// void main() {z
//   runApp(MyApp());
// }

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Booking Admin',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AdminHome(),
    );
  }
}

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [

    ManageRoom(),
    ManageTypeRoom(),
    ManageUsers(),
  ];

  // Function to handle navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: _pages[_selectedIndex], // Display selected page

      // BottomNavigationBar for navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room),
            label: 'Manage Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.king_bed),
            label: 'Manage Room Types',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Manage Users',
          ),
        ],
      ),
    );
  }
}



