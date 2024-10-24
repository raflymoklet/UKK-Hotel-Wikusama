import 'package:flutter/material.dart';
import 'package:coba1/http_services/service.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  String _role = 'Admin'; // Default role adalah Admin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Admin / Resepsionis'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dropdown untuk memilih role (Admin/Resepsionis)
              DropdownButtonFormField<String>(
                value: _role,
                items: [
                  DropdownMenuItem(
                    child: Text('Admin'),
                    value: 'Admin',
                  ),
                  DropdownMenuItem(
                    child: Text('Resepsionis'),
                    value: 'Resepsionis',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _role = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Login sebagai',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Username Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _username = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Email Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Password Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_role == 'Admin') {
                      var login = await Service().login(_email, _password);
                      if (login["status"] == true) {
                        // Login sukses, navigasi ke halaman admin
                        Navigator.pushNamed(context, '/admin');
                      } else {
                        _showLoginError(); // Tampilkan error jika login gagal
                      }
                    } else {
                      var login = await Service().login(_email, _password);
                      if (login["status"] == true) {
                        // Login sukses, navigasi ke halaman admin
                        Navigator.pushNamed(context, '/resepsionis');
                      } else {
                        _showLoginError(); // Tampilkan error jika login gagal
                      }
                      // _loginResepsionis(_username, _email, _password);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginAdmin(String username, String email, String password) {
    // Logika untuk login admin
    if (username == 'admin' &&
        email == 'admin@example.com' &&
        password == 'admin123') {
      print('Login sukses sebagai Admin');
      // Navigasi ke halaman Admin Dashboard
      Navigator.pushNamed(context, '/admin');
    } else {
      // Tampilkan pesan error
      _showLoginError();
    }
  }

  void _loginResepsionis(String username, String email, String password) {
    // Logika untuk login resepsionis
    if (username == 'resepsionis' &&
        email == 'resepsionis@example.com' &&
        password == 'resepsionis123') {
      print('Login sukses sebagai Resepsionis');
      // Navigasi ke halaman Resepsionis Dashboard
      Navigator.pushNamed(context, '/resepsionis');
    } else {
      // Tampilkan pesan error
      _showLoginError();
    }
  }

  void _showLoginError() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login Gagal'),
          content: Text('Username, email, atau password salah.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
