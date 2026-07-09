# App de Busca e Organização de Livros 

Atividade Avaliativa desenvolvida em Flutter, com o objetivo de consultar a API pública Open Library, exibir resultados de busca e salvar livros favoritos localmente.

---

## Informações Acadêmicas

- **Nome do curso:** Análise e Desenvolvimento de Sistemas
- **Nome da unidade curricular:** 5° Semestre

### Equipe Desenvolvedora e Contribuições

- **[Luciana Rodrigues](https://github.com/lucikkjl)**: Responsável pela estrutura de pastas do projeto, configuração inicial no `main.dart`, implementação da pasta de serviços (API e armazenamento) e ajustes de cores e contraste utilizando o Material 3.
- **[Tainá Friedemann](https://github.com/seizakawaMilky)**: Responsável pela modelagem de dados, criando a estrutura e as regras de conversão JSON no arquivo `livro.dart`.
- **[Yasmin Friedemann](https://github.com/Yasfls)**: Responsável pelo desenvolvimento completo da pasta `screens`, criando todas as interfaces do usuário, fluxos de navegação e exibição dos estados da aplicação. Criação do READ.ME

---

## Principais Funcionalidades

1. **Busca de Livros:** Consulta à [Open Library API](https://openlibrary.org/dev/docs/api/search) por título, autor ou palavras-chave.
2. **Listagem Dinâmica:** Exibição dos resultados em tela contendo título, autor e capa do livro.
3. **Detalhes do Livro:** Tela dedicada mostrando informações adicionais, como editora e ano de publicação.
4. **Favoritos (Armazenamento Local):** Funcionalidade para favoritar e desfavoritar livros, com os dados persistindo localmente no dispositivo via `shared_preferences`.
5. **Tratamento de Estados:** Indicadores de carregamento (*loading*) durante as buscas e mensagens de feedback claras em caso de erros de rede ou ausência de resultados.
6. **Design Acessível:** Interface limpa, responsiva e com alto contraste, utilizando os esquemas de cores dinâmicos do Material Design 3.

---

## Explicação Técnica das Tecnologias Utilizadas

- **Flutter & Dart:** Framework e linguagem principais utilizados para a construção da interface e lógica do aplicativo mobile.
- **Pacote `http`:** Utilizado para realizar as requisições assíncronas (GET) à API REST da Open Library, tratando as respostas em formato JSON.
- **Pacote `shared_preferences`:** Implementado para garantir o armazenamento local leve. Os objetos de livros favoritados são convertidos para `String` (JSON) e salvos no dispositivo, garantindo a persistência dos dados entre as execuções do app.
- **Material Design 3:** Adotado para padronização visual, garantindo componentes modernos (como botões e cards) e esquemas de cores acessíveis por padrão.
- **Git & GitHub:** Utilizados para o versionamento do projeto e unificação do código.

---

## Como instalar e executar o app

1. Certifique-se de ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado na sua máquina.
2. Clone este repositório no seu terminal:
   ```bash
   git clone https://github.com/Yasfls/provapratica_flutter2.git