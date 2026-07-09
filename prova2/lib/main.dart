import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca de Livros',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 104, 71, 51),
          brightness: Brightness.light, 
        ),
        useMaterial3: true,
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 104, 71, 51),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}