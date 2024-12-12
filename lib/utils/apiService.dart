import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.cerdaspantaubanjir.my.id';

  static Future<List<Map<String, dynamic>>> fetchDataSensor() async {
    final response = await http.get(Uri.parse(baseUrl + '/sensors-activities'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchDataBroadcast() async {
    final response = await http.get(Uri.parse(baseUrl + '/broadcast-list'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
