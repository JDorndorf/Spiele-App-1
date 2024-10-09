import 'package:flutter/material.dart';
import 'dart:math';

class Hangman extends StatefulWidget {
  const Hangman({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HangmanState createState() => _HangmanState();
}

class _HangmanState extends State<Hangman> {
  List<String> words = [
    'FLUTTER',
    'DART',
    'PROGRAMMING',
    'MOBILE',
    'DEVELOPER',
    'APPLICATION',
    'CODE',
    'DEBUG',
    'FUNCTION',
    'VARIABLE',
  ];

  String word = '';
  List<String> guessedLetters = [];
  int maxAttempts = 6;
  int attempts = 0;

  void startGame() {
    word = words[Random().nextInt(words.length)];
    guessedLetters = [];
    attempts = 0;
  }

  void guessLetter(String letter) {
    if (!guessedLetters.contains(letter) && attempts < maxAttempts) {
      setState(() {
        guessedLetters.add(letter);
        if (!word.contains(letter)) {
          attempts++;
        }
      });
    }
  }

  bool get isGameOver => attempts >= maxAttempts || isWordGuessed;

  bool get isWordGuessed => word.split('').every((letter) => guessedLetters.contains(letter));

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                'Menü',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.games),
              title: const Text('Tic Tac Toe'),
              onTap: () {
                Navigator.pop(context); // Drawer schließen
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.hail_outlined),
              title: const Text('Hangman'),
              onTap: () {
                Navigator.pop(context); // Drawer schließen
                Navigator.pushReplacementNamed(context, '/hangman');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Versuche: ${maxAttempts - attempts}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              word.split('').map((letter) => guessedLetters.contains(letter) ? letter : '_').join(' '),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (isGameOver)
              Text(
                isWordGuessed ? 'Du hast gewonnen!' : 'Du hast verloren! Das Wort war: $word',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              children: List.generate(26, (index) {
                String letter = String.fromCharCode(index + 65); // ASCII für Buchstaben A-Z
                return GestureDetector(
                  onTap: () => guessLetter(letter),
                  child: Chip(
                    label: Text(letter),
                    backgroundColor: guessedLetters.contains(letter)
                        ? Colors.grey
                        : Colors.blue,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: startGame,
              child: const Text('Neues Spiel starten'),
            ),
          ],
        ),
      ),
    );
  }
}
