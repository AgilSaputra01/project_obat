import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';
import '../widgets/medicine_grid_item.dart';
import '../models/medicine.dart';
import './detail_screen.dart';
import './add.dart';
import './edit.dart'; // Tambahkan file edit_screen.dart untuk halaman edit.

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Medicine>> futureMedicines;

  final List<String> imageUrls = [
    'https://i.pinimg.com/736x/3d/c5/54/3dc55441f4aa448de1d656811b41e753.jpg',
    'https://i.pinimg.com/736x/9f/72/8f/9f728fb4b086684d297502fd4c743557.jpg',
    'https://i.pinimg.com/736x/5d/94/e2/5d94e2358dad64ebd638445d0f48250b.jpg',
    'https://i.pinimg.com/736x/76/fe/7f/76fe7febdb15205f18d086f5bf2b2b70.jpg',
    'https://i.pinimg.com/736x/c7/a6/a0/c7a6a0ed01e0f1def630502d68019778.jpg',
  ];

  @override
  void initState() {
    super.initState();
    futureMedicines = apiService.fetchMedicines();
  }

  Future<void> _refreshMedicines() async {
    setState(() {
      futureMedicines = apiService.fetchMedicines(); // Memanggil ulang data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7196da),
        elevation: 4,
        title: const Text(
          'MedEase',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Slider otomatis
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
              ),
              items: imageUrls.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Daftar Obat-obatan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Medicine>>(
              future: futureMedicines,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada data obat'));
                } else {
                  final medicines = snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = medicines[index];
                      return Stack(
                        children: [
                          MedicineGridItem(
                            medicine: medicine,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(medicine: medicine),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () async {
                                    // Menunggu hasil dari halaman Edit
                                    bool? result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Edit(medicine: medicine),
                                      ),
                                    );
                                    if (result == true) {
                                      _refreshMedicines(); // Refresh data jika berhasil
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () async {
                                    final response = await http.delete(
                                      Uri.parse(
                                          'https://6733f41fa042ab85d1187497.mockapi.io/api/v1/ObatDokter/${medicine.id}'),
                                    );
                                    if (response.statusCode == 200) {
                                      setState(() {
                                        medicines.removeAt(index);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Obat berhasil dihapus')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Gagal menghapus obat')),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddScreen(),
            ),
          );
          if (result == true) {
            _refreshMedicines(); // Refresh data setelah menambah data
          }
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
