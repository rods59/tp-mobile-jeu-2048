import 'package:flutter/material.dart';

class GameGrid extends StatelessWidget {
  final List<int> grid;

  const GameGrid({Key? key, required this.grid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.9;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: CustomPaint(
        painter: _GameGridPainter(grid),
      ),
    );
  }
}

class _GameGridPainter extends CustomPainter {
  final List<int> grid;

  _GameGridPainter(this.grid);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final tileSize = size.width / 4;

    for (int i = 0; i < grid.length; i++) {
      final row = i ~/ 4;
      final col = i % 4;
      final x = col * tileSize;
      final y = row * tileSize;

      paint.color = grid[i] == 0
          ? Colors.grey[300]!
          : Colors.orange[(grid[i].toString().length * 100)] ?? Colors.orange;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, tileSize, tileSize),
          const Radius.circular(8),
        ),
        paint,
      );

      if (grid[i] > 0) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: '${grid[i]}',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x + (tileSize - textPainter.width) / 2,
              y + (tileSize - textPainter.height) / 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
