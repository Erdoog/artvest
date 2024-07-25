import 'package:flutter/material.dart';

class NodeConnectionPage extends StatelessWidget {
  const NodeConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Node test'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(MediaQuery.sizeOf(context).width * 0.5, MediaQuery.sizeOf(context).height * 0.5),
          painter: NodePainter(),
        ),
      ),
    );
  }
}

class NodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint nodePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0;

    // Position
    final double nodeRadius = 5.0;
    final List<Offset> nodes = [
      Offset(size.width * 0.7, size.height * 0.2),
      Offset(size.width * 0.3, size.height * 0.3),
      Offset(size.width * 0.6, size.height * 0.4),
      Offset(size.width * 0.4, size.height * 0.5),
      Offset(size.width * 0.5, size.height * 0.6),
      Offset(size.width * 0.6, size.height * 0.7),
    ];

    // Draw the lines
    for (int i = 0; i < nodes.length - 1; i++) {
      canvas.drawLine(nodes[i], nodes[i + 1], linePaint);
    }

    // Draw the nodes
    for (Offset node in nodes) {
      var shadowPath = Path()..addOval(Rect.fromCircle(center: Offset(node.dx, node.dy), radius: nodeRadius * 2.0));
      var shadowPaint = Paint()
        ..color = Colors.white
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20.0);
      canvas.drawPath(shadowPath, shadowPaint);
      canvas.drawCircle(node, nodeRadius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
