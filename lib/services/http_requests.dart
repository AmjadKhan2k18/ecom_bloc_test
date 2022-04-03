import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequest {
  static String baseUrl = 'https://api.mercadolibre.com/';

  static Future<dynamic> get({required String endUrl}) async {
    final uri = Uri.parse('$baseUrl$endUrl');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        return null;
      }
    } catch (e) {
      throw Exception('Something went wrong!');
    }
  }
}
