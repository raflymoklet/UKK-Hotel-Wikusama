import 'package:flutter/material.dart';
import 'package:coba1/http_services/user_service.dart';

import '../models/user.dart'; // Import service API

class ManageUsers extends StatefulWidget {
  @override
  ManageUsersState createState() => ManageUsersState();
}

class ManageUsersState extends State<ManageUsers> {
  List<User> users = [];
  UserService userService = UserService();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      List<User> userData = await userService.getUsers();
      setState(() {
        users = userData;
      });
    } catch (e) {
      print(e);
    }
  }

  void showEditUserForm(User user) {
    TextEditingController nameController = TextEditingController(text: user.name);
    TextEditingController emailController = TextEditingController(text: user.email);
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: Column(
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
              TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
              TextField(controller: passwordController, decoration: InputDecoration(labelText: 'password')),
              DropdownButtonFormField(
                value: user.role,
                items: ['admin', 'receptionist'].map((role) {
                  return DropdownMenuItem(value: role, child: Text(role));
                }).toList(),
                onChanged: (value) {},
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await userService.updateUser(user.id, nameController.text, emailController.text, user.role, passwordController.text);
                fetchUsers();
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmation(User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete ${user.name}?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await userService.deleteUser(user.id);
                fetchUsers();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
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
        title: Text('Manage Users'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(hintText: 'Search users'),
              onChanged: (value) {
                setState(() {
                  users = users.where((user) => user.name.toLowerCase().contains(value.toLowerCase())).toList();
                });
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showEditUserForm(user);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDeleteConfirmation(user);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

