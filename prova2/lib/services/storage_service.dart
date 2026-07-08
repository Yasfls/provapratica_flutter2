import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/livro.dart';

class StorageService {
  static const String _favoritosKey = 'favoritos_key';

  Future<void> salvarFavorito(Livro livro) async {
    final prefs = await SharedPreferences.getInstance();
    List<Livro> favoritos = await obterFavoritos();
    
    // Evita duplicatas
    if (!favoritos.any((l) => l.id == livro.id)) {
      favoritos.add(livro);
      List<String> favoritosJson = favoritos.map((l) => json.encode(l.toJson())).toList();
      await prefs.setStringList(_favoritosKey, favoritosJson);
    }
  }

  Future<void> removerFavorito(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<Livro> favoritos = await obterFavoritos();
    
    favoritos.removeWhere((l) => l.id == id);
    List<String> favoritosJson = favoritos.map((l) => json.encode(l.toJson())).toList();
    await prefs.setStringList(_favoritosKey, favoritosJson);
  }

  Future<List<Livro>> obterFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favoritosString = prefs.getStringList(_favoritosKey);
    
    if (favoritosString == null) return [];
    
    return favoritosString.map((str) => Livro.fromLocalJson(json.decode(str))).toList();
  }

  Future<bool> isFavorito(String id) async {
    List<Livro> favoritos = await obterFavoritos();
    return favoritos.any((l) => l.id == id);
  }
}