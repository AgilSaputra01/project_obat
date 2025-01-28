import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/medicine.dart';

class Edit extends StatefulWidget {
  final Medicine medicine;

  const Edit({Key? key, required this.medicine}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController imageController;
  late TextEditingController dosageController;
  late TextEditingController compositionController;
  late TextEditingController functionController;
  late TextEditingController usageController;
  late TextEditingController instructionsController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the existing values
    nameController = TextEditingController(text: widget.medicine.name);
    imageController = TextEditingController(text: widget.medicine.image);
    dosageController = TextEditingController(text: widget.medicine.dosage);
    compositionController =
        TextEditingController(text: widget.medicine.composition);
    functionController = TextEditingController(text: widget.medicine.function);
    usageController = TextEditingController(text: widget.medicine.usage);
    instructionsController =
        TextEditingController(text: widget.medicine.instructions);
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    nameController.dispose();
    imageController.dispose();
    dosageController.dispose();
    compositionController.dispose();
    functionController.dispose();
    usageController.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  Future<void> updateMedicine() async {
    if (_formKey.currentState!.validate()) {
      final url =
          'https://6733f41fa042ab85d1187497.mockapi.io/api/v1/ObatDokter/${widget.medicine.id}';

      final response = await http.put(
        Uri.parse(url),
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

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil diperbarui')),
        );
        Navigator.pop(
            context, true); // Mengirim nilai true untuk memberitahu perubahan
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.medicine.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama Obat'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'URL Gambar'),
                ),
                TextFormField(
                  controller: dosageController,
                  decoration: const InputDecoration(labelText: 'Dosis'),
                ),
                TextFormField(
                  controller: compositionController,
                  decoration: const InputDecoration(labelText: 'Komposisi'),
                ),
                TextFormField(
                  controller: functionController,
                  decoration: const InputDecoration(labelText: 'Fungsi'),
                ),
                TextFormField(
                  controller: usageController,
                  decoration:
                      const InputDecoration(labelText: 'Cara Penggunaan'),
                ),
                TextFormField(
                  controller: instructionsController,
                  decoration: const InputDecoration(labelText: 'Instruksi'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: updateMedicine,
                  child: const Text('Simpan Perubahan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
