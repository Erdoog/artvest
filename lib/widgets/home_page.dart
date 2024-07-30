import 'package:artvest/widgets/nodes-test.dart';
import 'package:flutter/material.dart';
import 'package:artvest/widgets/chat.dart';
import 'package:artvest/widgets/educational_page.dart';
import 'package:artvest/widgets/chart_page.dart';
import 'package:artvest/widgets/charity.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArtVest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  static const nodePositions = [
    [.34 - 0.24, .07 + 0.2],
    [.63 - 0.24, .22 + 0.2],
    [.44 - 0.24, .47 + 0.2],
    [.55 - 0.24, .69 + 0.2],
    [.38 - 0.24, .96 + 0.2]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArtVest'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
                    child: const Column(
                        children: [
                          const Text(
                            'Welcome to ArtVest',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Center(
                            child: Text(
                              'Learn the art of investment with our community!',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                  ),
                  const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => CharityListPage()),
                  //     );
                  //   },
                  //   child: const Text('Support Of Social Projects'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => ChartPage()),
                  //     );
                  //   },
                  //   child: const Text('Simulation Of Investment Art'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => ChatPage()),
                  //     );
                  //   },
                  //   child: const Text('AI Chat - Financial Consultant'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => VideoPage()),
                  //     );
                  //   },
                  //   child: const Text('Basic Knowledge Of Finance'),
                  // ),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      child: Stack(
                          children: [
                            CustomPaint(
                              size: Size(MediaQuery.sizeOf(context).width * 0.5, MediaQuery.sizeOf(context).width * 0.7),
                              painter: NodePainter(),
                            ),
                            Positioned(
                              left: nodePositions[0][0] * MediaQuery.sizeOf(context).width * 0.7 + MediaQuery.sizeOf(context).width * .04,
                              top: nodePositions[0][1] * MediaQuery.sizeOf(context).width * 0.7 - MediaQuery.sizeOf(context).width * .07,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CharityListPage()),
                                  );
                                },
                                child: const Text('Support Of Social Projects'),
                              ),
                            ),
                            Positioned(
                              left: nodePositions[1][0] * MediaQuery.sizeOf(context).width * 0.7 + MediaQuery.sizeOf(context).width * .04,
                              top: nodePositions[1][1] * MediaQuery.sizeOf(context).width * 0.7 - MediaQuery.sizeOf(context).width * .04,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ChartPage()),
                                  );
                                },
                                child: const Text('Simulation Of Investment Art'),
                              ),
                            ),
                            Positioned(
                              left: nodePositions[2][0] * MediaQuery.sizeOf(context).width * 0.7 + MediaQuery.sizeOf(context).width * .04,
                              top: nodePositions[2][1] * MediaQuery.sizeOf(context).width * 0.7 - MediaQuery.sizeOf(context).width * .04,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ChatPage()),
                                  );
                                },
                                child: const Text('AI Chat - Financial Consultant'),
                              ),
                            ),
                            Positioned(
                              left: nodePositions[3][0] * MediaQuery.sizeOf(context).width * 0.7 + MediaQuery.sizeOf(context).width * .04,
                              top: nodePositions[3][1] * MediaQuery.sizeOf(context).width * 0.7 - MediaQuery.sizeOf(context).width * .04,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => VideoPage()),
                                  );
                                },
                                child: const Text('Basic Knowledge Of Finance'),
                              ),
                            ),
                            Positioned(
                              left: nodePositions[4][0] * MediaQuery.sizeOf(context).width * 0.7 + MediaQuery.sizeOf(context).width * .04,
                              top: nodePositions[4][1] * MediaQuery.sizeOf(context).width * 0.7 - MediaQuery.sizeOf(context).width * .04,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ChartPage()),
                                  );
                                },
                                child: const Text('Simulation Of Investment Art'),
                              ),
                            ),
                          ]
                      )
                  ),
                  const SizedBox(height: 20),

                  Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width *  0.8),
                    child: const Column(
                    children: [
                      const Text(
                        'Our team focuses on the education of Kazakhstani citizens in sphere of investments',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ])
                  ),
                ],
              ),
          ],
        )
      ),
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
      Offset(size.width * (0.34 - 0.24) / widthHeightRatio, size.height * (0.10 + 0.2)),
      Offset(size.width * (0.63 - 0.24) / widthHeightRatio, size.height * (0.25 + 0.2)),
      Offset(size.width * (0.44 - 0.24) / widthHeightRatio, size.height * (0.50 + 0.2)),
      Offset(size.width * (0.55 - 0.24) / widthHeightRatio, size.height * (0.72 + 0.2)),
      Offset(size.width * (0.38 - 0.24) / widthHeightRatio, size.height * (0.99 + 0.2)),
    ];

    // Draw the lines
    for (int i = 0; i < nodes.length - 1; i++) {
      canvas.drawLine(nodes[i], nodes[i + 1], linePaint);
    }

    canvas.drawLine(Offset(0, 0), Offset(1, 0), Paint()..color = Colors.black);

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
