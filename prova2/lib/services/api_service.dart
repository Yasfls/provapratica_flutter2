import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/livro.dart';

class ApiService {
  static const String _baseUrl = 'https://openlibrary.org/search.json';

  Future<List<Livro>> buscarLivros(String query) async {
    // Tratamento de erro de rede e conexão
    try {
      final url = Uri.parse('$_baseUrl?q=${query.replaceAll(' ', '+')}&limit=15');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List docs = data['docs'];
        
        return docs.map((json) => Livro.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar resultados');
      }
    } catch (e) {
      throw Exception('Erro de conexão. Verifique sua internet.');
    }
  }
}