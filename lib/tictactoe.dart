import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  bool _gameOver = false;
  String _result = '';
  String _playerXName = '';
  String _playerOName = '';
  int _playerXScore = 0;
  int _playerOScore = 0;
  final TextEditingController _playerXController = TextEditingController();
  final TextEditingController _playerOController = TextEditingController();

  void _checkWinner() {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var combination in winningCombinations) {
      if (_board[combination[0]] != '' &&
          _board[combination[0]] == _board[combination[1]] &&
          _board[combination[1]] == _board[combination[2]]) {
        _gameOver = true;
        if (_board[combination[0]] == 'X') {
          _result = '$_playerXName hat gewonnen!';
          _playerXScore++;
        } else {
          _result = '$_playerOName hat gewonnen!';
          _playerOScore++;
        }
        return;
      }
    }

    if (!_board.contains('')) {
      _gameOver = true;
      _result = 'Unentschieden!';
    }
  }

  void _handleTap(int index) {
    if (_board[index] == '' && !_gameOver) {
      setState(() {
        _board[index] = _currentPlayer;
        _checkWinner();
        if (!_gameOver) {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _gameOver = false;
      _result = '';
    });
  }

  void _resetAll() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _gameOver = false;
      _result = '';
      _playerXScore = 0;
      _playerOScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
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
            TextField(
              controller: _playerXController,
              decoration: InputDecoration(
                labelText: 'Spieler X Name',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {
                  _playerXName = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _playerOController,
              decoration: InputDecoration(
                labelText: 'Spieler O Name',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {
                  _playerOName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => _handleTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _board[index],
                          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _gameOver
                  ? _result
                  : 'Spieler ${_currentPlayer == 'X' ? _playerXName : _playerOName}\'s Zug',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('$_playerXName: $_playerXScore', style: const TextStyle(fontSize: 20)),
                Text('$_playerOName: $_playerOScore', style: const TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: _resetGame,
              child: const Text('Spiel zurücksetzen'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: _resetAll,
              child: const Text('Alles zurücksetzen'),
            ),
          ],
        ),
      ),
    );
  }
}
