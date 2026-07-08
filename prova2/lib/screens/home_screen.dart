import 'package:flutter/material.dart';
import '../models/livro.dart';
import '../services/api_service.dart';
import 'detalhes_screen.dart';
import 'favoritos_screen.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _buscaController = TextEditingController();
 
  List<Livro> _resultados = [];
  bool _isLoading = false;
  String _mensagemErro = '';
 
  void _buscarLivros() async {
    if (_buscaController.text.trim().isEmpty) return;
 
    setState(() {
      _isLoading = true;
      _mensagemErro = '';
      _resultados = [];
    });
 
    try {
      final resultados = await _apiService.buscarLivros(_buscaController.text);
      setState(() {
        _resultados = resultados;
        if (_resultados.isEmpty) {
          _mensagemErro = 'Nenhum livro encontrado.';
        }
      });
    } catch (e) {
      setState(() {
        _mensagemErro = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
 
  void _limparBusca() {
    _buscaController.clear();
    setState(() {
      _resultados = [];
      _mensagemErro = '';
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca Flutter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritosScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _buscaController,
                    decoration: InputDecoration(
                      hintText: 'Busque por título ou autor...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _limparBusca,
                      ),
                    ),
                    onSubmitted: (_) => _buscarLivros(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _buscarLivros,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Icon(Icons.search),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (_isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (_mensagemErro.isNotEmpty)
              Expanded(child: Center(child: Text(_mensagemErro)))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _resultados.length,
                  itemBuilder: (context, index) {
                    final livro = _resultados[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: livro.capaUrl.isNotEmpty
                            ? Image.network(livro.capaUrl, width: 50, fit: BoxFit.cover)
                            : const Icon(Icons.book, size: 50),
                        title: Text(livro.titulo, maxLines: 2, overflow: TextOverflow.ellipsis),
                        subtitle: Text(livro.autor),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesScreen(livro: livro),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}