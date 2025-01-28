import 'package:flutter/material.dart';
import '../models/medicine.dart';

class MedicineGridItem extends StatefulWidget {
  final Medicine medicine;
  final VoidCallback onTap;

  const MedicineGridItem({
    Key? key,
    required this.medicine,
    required this.onTap,
  }) : super(key: key);

  @override
  _MedicineGridItemState createState() => _MedicineGridItemState();
}

class _MedicineGridItemState extends State<MedicineGridItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          ),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      widget.medicine.image,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isHovered)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black
                            .withOpacity(0.4), // Warna gelap transparan
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.medicine.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
