class Livro {
  final String id;
  final String titulo;
  final String autor;
  final String capaUrl;
  final String editora;
  final String anoPublicacao;
 
  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.capaUrl,
    required this.editora,
    required this.anoPublicacao,
  });
 
  // Converte o JSON da Open Library para o nosso Objeto
  factory Livro.fromJson(Map<String, dynamic> json) {
    // A Open Library retorna a capa usando o cover_i
    final coverId = json['cover_i'];
    final coverUrl = coverId != null
        ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
        : ''; // URL vazia se não tiver capa
 
    return Livro(
      id: json['key'] ?? '',
      titulo: json['title'] ?? 'Título Desconhecido',
      autor: (json['author_name'] != null && (json['author_name'] as List).isNotEmpty)
          ? json['author_name'][0]
          : 'Autor Desconhecido',
      capaUrl: coverUrl,
      editora: (json['publisher'] != null && (json['publisher'] as List).isNotEmpty)
          ? json['publisher'][0]
          : 'Editora Desconhecida',
      anoPublicacao: json['first_publish_year']?.toString() ?? 'Ano Desconhecido',
    );
  }
 
  // Converte o Objeto para JSON (necessário para o SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'capaUrl': capaUrl,
      'editora': editora,
      'anoPublicacao': anoPublicacao,
    };
  }
 
  // Cria o Livro a partir do JSON salvo localmente
  factory Livro.fromLocalJson(Map<String, dynamic> json) {
    return Livro(
      id: json['id'],
      titulo: json['titulo'],
      autor: json['autor'],
      capaUrl: json['capaUrl'],
      editora: json['editora'],
      anoPublicacao: json['anoPublicacao'],
    );
  }
}