import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.blueAccent, // Warna AppBar
        elevation: 0, // Menghilangkan bayangan AppBar
      ),
      body: Stack(
        children: [
          // Latar belakang berwarna
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff94b7f4), Colors.lightBlueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 40),
              // Avatar dengan bayangan
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: const NetworkImage(
                    'https://i.pinimg.com/736x/4f/41/5e/4f415e10c461e4f16ea794fe28395c7f.jpg', // Gambar profil
                  ),
                  backgroundColor: Colors.white,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check,
                          size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Nama dan informasi pengguna
              const Text(
                'Agil Saputra',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '22TI023',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              // Card untuk informasi tambahan
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading:
                              const Icon(Icons.email, color: Colors.blueAccent),
                          title: const Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('agilsaputra@gmail.com'),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.grey),
                            onPressed: () {
                              // Aksi untuk edit email
                            },
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading:
                              const Icon(Icons.phone, color: Colors.blueAccent),
                          title: const Text(
                            'Phone',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('+6287761459651'),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.grey),
                            onPressed: () {
                              // Aksi untuk edit telepon
                            },
                          ),
                        ),
                        const Divider(),
                        const Spacer(),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Aksi logout
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text('Logout'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xffa1bff4), // Warna latar tombol
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
