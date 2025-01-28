import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/api_service.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController compositionController = TextEditingController();
  final TextEditingController functionController = TextEditingController();
  final TextEditingController usageController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();

  Future<void> _addMedicine() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse(ApiService().baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': nameController.text,
            'image': imageController.text,
            'dosage': dosageController.text,
            'composition': compositionController.text,
            'function': functionController.text,
            'usage': usageController.text,
            'instructions': instructionsController.text,
          }),
        );

        if (response.statusCode == 201) {
          // Jika berhasil, kembali ke halaman sebelumnya dengan hasil sukses
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Obat berhasil ditambahkan!')),
          );
          Navigator.pop(context, true);
        } else {
          // Jika gagal, tampilkan pesan error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal menambahkan obat.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Obat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'URL gambar harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: dosageController,
                  decoration: const InputDecoration(labelText: 'Dosage'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Dosis harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: compositionController,
                  decoration: const InputDecoration(labelText: 'Composition'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Komposisi harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: functionController,
                  decoration: const InputDecoration(labelText: 'Function'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fungsi harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: usageController,
                  decoration: const InputDecoration(labelText: 'Usage'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Cara penggunaan harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: instructionsController,
                  decoration: const InputDecoration(labelText: 'Instructions'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Instruksi harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addMedicine,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
