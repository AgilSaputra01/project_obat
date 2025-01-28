import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/api_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final alamatController = TextEditingController();
  final emailController = TextEditingController();
  final imageController = TextEditingController();

  void _register() async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        imageController.text.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(BaseUrl.register),
          body: {
            'username': usernameController.text,
            'password': passwordController.text,
            'email': emailController.text,
            'alamat': alamatController.text,
            'image': imageController.text,
          },
        );

        if (response.statusCode == 201) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Berhasil"),
              content: const Text('Register berhasil!'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        } else {
          _showErrorDialog("Gagal", "Register gagal, coba lagi.");
        }
      } catch (e) {
        _showErrorDialog("Error", "Terjadi kesalahan: $e");
      }
    } else {
      _showErrorDialog("Gagal", "Semua field harus diisi!");
    }
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: alamatController,
              decoration: const InputDecoration(labelText: "Alamat"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: "Link Gambar"),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _register,
              icon: const Icon(Icons.person_add),
              label: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
