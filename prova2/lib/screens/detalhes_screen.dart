import 'package:flutter/material.dart';
import '../models/livro.dart';
import '../services/storage_service.dart';
 
class DetalhesScreen extends StatefulWidget {
  final Livro livro;
 
  const DetalhesScreen({super.key, required this.livro});
 
  @override
  State<DetalhesScreen> createState() => _DetalhesScreenState();
}
 
class _DetalhesScreenState extends State<DetalhesScreen> {
  final StorageService _storageService = StorageService();
  bool _isFavorito = false;
 
  @override
  void initState() {
    super.initState();
    _verificarFavorito();
  }
 
  void _verificarFavorito() async {
    bool fav = await _storageService.isFavorito(widget.livro.id);
    setState(() {
      _isFavorito = fav;
    });
  }
 
  void _toggleFavorito() async {
    if (_isFavorito) {
      await _storageService.removerFavorito(widget.livro.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Removido dos favoritos!')),
      );
    } else {
      await _storageService.salvarFavorito(widget.livro);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Salvo nos favoritos!')),
      );
    }
    _verificarFavorito();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Livro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.livro.capaUrl.isNotEmpty)
              Image.network(widget.livro.capaUrl, height: 250)
            else
              const Icon(Icons.book, size: 150, color: Colors.grey),
            const SizedBox(height: 24),
            Text(
              widget.livro.titulo,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Por: ${widget.livro.autor}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
            ),
            const Divider(height: 40),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Editora'),
              subtitle: Text(widget.livro.editora),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Ano de Publicação'),
              subtitle: Text(widget.livro.anoPublicacao),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggleFavorito,
        icon: Icon(_isFavorito ? Icons.favorite : Icons.favorite_border),
        label: Text(_isFavorito ? 'Desfavoritar' : 'Favoritar'),
      ),
    );
  }
}