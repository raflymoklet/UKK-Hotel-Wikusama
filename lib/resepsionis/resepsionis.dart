import 'package:flutter/material.dart';
import 'dart:async';
import 'package:coba1/main.dart';
import 'package:coba1/login_page.dart';
import 'package:coba1/admin/admin_login_page.dart';

class HomeResepsionis extends StatefulWidget {
  @override
  _HomeResepsionisState createState() => _HomeResepsionisState();
}

class _HomeResepsionisState extends State<HomeResepsionis> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    ManageCheckIn(),
    ManageCheckOut(),
    // ManageReservations(),
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
        title: Text('Resepsionis Dashboard'),
      ),
      body: _pages[_selectedIndex], // Display selected page

      // BottomNavigationBar for navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Check-In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_late),
            label: 'Check-Out',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.book_online),
          //   label: 'Reservations',
          // ),
        ],
      ),
    );
  }
}

// Placeholder pages for Check-In, Check-Out, and Reservations
class ManageCheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Pemesanan'),
      ),
      body: Center(child: Text('Manage Pemesanan')),
    );
  }
}

class ManageCheckOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Kelola'),
      ),
      body: Center(child: Text('Check Kelola')),
    );
  }
}

// class ManageReservations extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Manage Reservations'),
//       ),
//       body: Center(child: Text('Reservations Page')),
//     );
//   }
// }
