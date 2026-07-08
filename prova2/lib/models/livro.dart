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

  factory Livro.fromJson(Map<String, dynamic> json) {
    final coverId = json['cover_i'];
    final coverUrl = coverId != null
        ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
        : '';
 
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