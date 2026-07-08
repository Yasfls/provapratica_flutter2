import 'package:flutter/material.dart';
import '../models/livro.dart';
import '../services/storage_service.dart';
import 'detalhes_screen.dart';
 
class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});
 
  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}
 
class _FavoritosScreenState extends State<FavoritosScreen> {
  final StorageService _storageService = StorageService();
  List<Livro> _favoritos = [];
  bool _isLoading = true;
 
  @override
  void initState() {
    super.initState();
    _carregarFavoritos();
  }
 
  void _carregarFavoritos() async {
    final favoritos = await _storageService.obterFavoritos();
    setState(() {
      _favoritos = favoritos;
      _isLoading = false;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Favoritos'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoritos.isEmpty
              ? const Center(child: Text('Você ainda não tem livros favoritos.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _favoritos.length,
                  itemBuilder: (context, index) {
                    final livro = _favoritos[index];
                    return Card(
                      child: ListTile(
                        leading: livro.capaUrl.isNotEmpty
                            ? Image.network(livro.capaUrl, width: 50, fit: BoxFit.cover)
                            : const Icon(Icons.book, size: 50),
                        title: Text(livro.titulo),
                        subtitle: Text(livro.autor),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await _storageService.removerFavorito(livro.id);
                            _carregarFavoritos();
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesScreen(livro: livro),
                            ),
                          ).then((_) => _carregarFavoritos());
                        },
                      ),
                    );
                  },
                ),
    );
  }
}