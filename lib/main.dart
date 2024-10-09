import 'package:flutter/material.dart';
import 'tictactoe.dart'; // Importiere die Tic Tac Toe Datei
import 'hangman.dart'; // Importiere die Hangman Datei

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const TicTacToe(), // Route für Tic Tac Toe
        '/hangman': (context) => const Hangman(), // Route für Hangman
      },
    );
  }
}
