import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/medicine.dart';
import '../screens/edit.dart';

class BaseUrl {
  static String login =
      'https://6733f41fa042ab85d1187497.mockapi.io/api/v1/user';
  static String register =
      'https://6733f41fa042ab85d1187497.mockapi.io/api/v1/user';
  static String add =
      'https://6733f41fa042ab85d1187497.mockapi.io/api/v1/ObatDokter';
  static String edit =
      'https://6733f41fa042ab85d1187497.mockapi.io/api/v1/user';
}

class ApiService {
  final String baseUrl =
      'https://6733f41fa042ab85d1187497.mockapi.io/api/v1/ObatDokter';

  Future<List<Medicine>> fetchMedicines() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Medicine.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load medicines');
      }
    } catch (e) {
      updateRecipe(recipe, Map<String, dynamic> updatedRecipe) {}
      throw Exception('Error fetching medicines: $e');
    }
  }

  updateRecipe(recipe, Map<String, dynamic> updatedRecipe) {}
}
