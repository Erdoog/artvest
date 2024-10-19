
import 'package:flutter/material.dart';

class NodeConnectionPage extends StatelessWidget {
  const NodeConnectionPage({super.key});
  static const nodePositions = [
    [.34, .07 + 0.2],
    [.63, .22 + 0.2],
    [.44, .47 + 0.2],
    [.55, .69 + 0.2],
    [.38, .96 + 0.2]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nodes')
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.5,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(MediaQuery.sizeOf(context).width * 0.7, MediaQuery.sizeOf(context).width * 0.7),
                painter: NodePainter(),
              ),
              ...nodePositions.map((node) {
                return Positioned(
                  left: node[0] * MediaQuery.sizeOf(context).width * 0.7 + 20,
                  top: node[1] * MediaQuery.sizeOf(context).width * 0.7 - 20,
                  child: ElevatedButton(
                      onPressed: () {
                      }, child: const Text('Button')
                  )
                );
              })
            ]
          )
        )
      )
    );
  }
}

class NodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sizeNormal = size.height * 0.00486;

    final Paint nodePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0 * sizeNormal;

    // Position
    // const double nodeRadius = 5.0;
    var nodeRadius = 5.0 * sizeNormal;
    var widthHeightRatio = size.width / size.height;

    final List<Offset> nodes = [
      Offset(size.width * 0.34 / widthHeightRatio, size.height * (0.10 + 0.2)),
      Offset(size.width * 0.63 / widthHeightRatio, size.height * (0.25 + 0.2)),
      Offset(size.width * 0.44 / widthHeightRatio, size.height * (0.50 + 0.2)),
      Offset(size.width * 0.55 / widthHeightRatio, size.height * (0.72 + 0.2)),
      Offset(size.width * 0.38 / widthHeightRatio, size.height * (0.99 + 0.2)),
    ];

    // Draw the lines
    for (int i = 0; i < nodes.length - 1; i++) {
      canvas.drawLine(nodes[i], nodes[i + 1], linePaint);
    }

    canvas.drawLine(const Offset(0, 0), const Offset(1, 0), Paint()..color = Colors.black);
    
    // Draw the nodes
    for (Offset node in nodes) {
      var shadowPath = Path()..addOval(Rect.fromCircle(center: Offset(node.dx, node.dy), radius: nodeRadius * 2.0));
      var shadowPaint = Paint()
        ..color = Colors.white
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, nodeRadius * 4);
      canvas.drawPath(shadowPath, shadowPaint);
      canvas.drawCircle(node, nodeRadius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
