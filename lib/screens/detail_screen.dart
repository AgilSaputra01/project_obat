import 'package:flutter/material.dart';
import '../models/medicine.dart';

class DetailScreen extends StatelessWidget {
  final Medicine medicine;

  const DetailScreen({Key? key, required this.medicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(medicine.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              medicine.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 100);
              },
            ),
            const SizedBox(height: 16),
            Text(
              medicine.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Komposisi: ${medicine.composition}'),
            const SizedBox(height: 8),
            Text('Dosis: ${medicine.dosage}'),
            const SizedBox(height: 8),
            Text('Fungsi: ${medicine.function}'),
            const SizedBox(height: 8),
            Text('Instruksi: ${medicine.instructions}'),
          ],
        ),
      ),
    );
  }
}
