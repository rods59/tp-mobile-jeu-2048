import 'dart:math';

List<int> mergeLeft(List<int> grid) {
  List<int> newGrid = List.filled(16, 0);
  for (int row = 0; row < 4; row++) {
    List<int> currentRow = grid.sublist(row * 4, row * 4 + 4)..removeWhere((e) => e == 0);
    List<int> mergedRow = [];

    for (int i = 0; i < currentRow.length; i++) {
      if (i + 1 < currentRow.length && currentRow[i] == currentRow[i + 1]) {
        mergedRow.add(currentRow[i] * 2);
        i++;
      } else {
        mergedRow.add(currentRow[i]);
      }
    }

    while (mergedRow.length < 4) {
      mergedRow.add(0);
    }

    for (int i = 0; i < 4; i++) {
      newGrid[row * 4 + i] = mergedRow[i];
    }
  }
  return newGrid;
}

List<int> mergeRight(List<int> grid) {
  return mergeLeft(grid.reversed.toList()).reversed.toList();
}

List<int> mergeUp(List<int> grid) {
  List<int> rotated = _transpose(grid);
  rotated = mergeLeft(rotated);
  return _transpose(rotated);
}

List<int> mergeDown(List<int> grid) {
  List<int> rotated = _transpose(grid);
  rotated = mergeRight(rotated);
  return _transpose(rotated);
}

List<int> _transpose(List<int> grid) {
  List<int> transposed = List.filled(16, 0);
  for (int i = 0; i < 16; i++) {
    int row = i ~/ 4;
    int col = i % 4;
    transposed[col * 4 + row] = grid[i];
  }
  return transposed;
}

int generateRandomTile(List<int> grid) {
  final random = Random();
  List<int> emptyTiles = [];

  for (int i = 0; i < 16; i++) {
    if (grid[i] == 0) {
      emptyTiles.add(i);
    }
  }

  if (emptyTiles.isNotEmpty) {
    return emptyTiles[random.nextInt(emptyTiles.length)];
  } else {
    return -1;
  }
}
