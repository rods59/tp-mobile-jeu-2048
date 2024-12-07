import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import '../widgets/game_grid.dart';
import '../logique/game_logic.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<int> grid = List.filled(16, 0);
  bool isRandomGrid = false;          // Pour la génération aléatoire
  int goal = 2048;
  int moveCount = 0;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    setState(() {
      grid = List.filled(16, 0);
      moveCount = 0;
      _generateRandomTile(); // Génération des deux tuiles
      _generateRandomTile();
    });
  }

  // Génèration tuile random
  void _generateRandomTile() {
    List<int> emptyTiles = [];
    for (int i = 0; i < grid.length; i++) {
      if (grid[i] == 0) {
        emptyTiles.add(i);
      }
    }
    if (emptyTiles.isNotEmpty) {
      int randomIndex = emptyTiles[Random().nextInt(emptyTiles.length)];
      grid[randomIndex] = 2;
    }
  }

  // Génération grille aléatoire
  void _startRandomGrid() {
    setState(() {
      grid = List.filled(16, 0);
      moveCount = 0;
      for (int i = 0; i < 16; i++) {
        if (Random().nextBool()) {
          grid[i] = (1 << Random().nextInt(4));
        }
      }
    });
  }

  // Gestion des Swipes
  void _handleSwipe(SwipeDirection direction) {
    setState(() {
      moveCount++;
      if (direction == SwipeDirection.left) grid = mergeLeft(grid);
      if (direction == SwipeDirection.right) grid = mergeRight(grid);
      if (direction == SwipeDirection.up) grid = mergeUp(grid);
      if (direction == SwipeDirection.down) grid = mergeDown(grid);
      _generateRandomTile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu du 2048'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Jeu du 2048',
                applicationVersion: '1.0',
                children: [const Text('Jeu expérimental du 2048 par SELWA Rodolphe')],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CheckboxListTile(
            title: const Text('Grille aléatoire'),
            value: isRandomGrid,
            onChanged: (bool? value) {
              setState(() {
                isRandomGrid = value ?? false;
              });
            },
          ),
          // Objectifs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Objectif : '),
              DropdownButton<int>(
                value: goal,
                items: [256, 512, 1024, 2048, 4096].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    goal = newValue ?? 2048;
                  });
                },
              ),
            ],
          ),
          // Affichage coups
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Nombre de coups : $moveCount'),
          ),
          // Zone de la grille
          Expanded(
            child: SwipeDetector(
              onSwipe: (SwipeDirection direction, Offset offset) {
                _handleSwipe(direction);
              },
              child: Center(
                child: GameGrid(grid: grid),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          if (isRandomGrid) {
            _startRandomGrid();
          } else {
            _startNewGame();
          }
        },
      ),
    );
  }
}
