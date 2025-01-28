import 'dart:convert';
import 'register.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/api_service.dart';
import '../screens/home_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void _login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      _showErrorDialog("Error", "Username dan password harus diisi.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(BaseUrl.login));
      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);

        final user = users.firstWhere(
          (user) =>
              user['username'] == usernameController.text &&
              user['password'] == passwordController.text,
          orElse: () => null,
        );

        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          _showErrorDialog("Gagal", "Username atau password salah.");
        }
      } else {
        _showErrorDialog(
            "Gagal", "Terjadi kesalahan server. Silakan coba lagi nanti.");
      }
    } catch (e) {
      _showErrorDialog("Error", "Terjadi kesalahan: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
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
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: isSmallScreen
            ? Column(
                children: [
                  _buildHeader(context, isSmallScreen),
                  _buildForm(context, isSmallScreen),
                ],
              )
            : Row(
                children: [
                  Expanded(
                      flex: 2, child: _buildHeader(context, isSmallScreen)),
                  Expanded(flex: 3, child: _buildForm(context, isSmallScreen)),
                ],
              ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmallScreen) {
    return Container(
      color: const Color(0xFFEFFAF3),
      padding: EdgeInsets.all(isSmallScreen ? 16.0 : 32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://1.bp.blogspot.com/-31qyn_HmosM/XOjdDSrGErI/AAAAAAAAHAU/T0gw0u891C0poN1y5OFF6-fjwDikX5bCgCLcBGAs/s1600/kisspng-cartoon-physician-drawing-the-bearded-doctor-5a709b8ba1acc5.7743401215173292916622.png',
              width: isSmallScreen ? 200 : 300,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error,
                  size: 100,
                  color: Colors.red,
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Welcome to MadEase",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3A6351),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 16.0 : 32.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Log In",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A6351),
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isLoading
                    ? const CircularProgressIndicator(
                        key: ValueKey(1),
                        color: Color(0xFF3A6351),
                      )
                    : ElevatedButton(
                        key: ValueKey(2),
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3A6351),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 5.0,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Register(),
                    ),
                  );
                },
                child: const Text(
                  "Create a New Account",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF3A6351),
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
