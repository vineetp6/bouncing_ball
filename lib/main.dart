// Basic bouncing ball app
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyGame()));
}

class MyGame extends StatefulWidget {
  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  static const double ballSpeed = 200.0;
  static const double jumpDistance = 50.0;
  Random random = Random();

  double ballX = 0;
  double ballY = 0;
  double directionX = 1;
  double directionY = 1;

  void _initialize(BuildContext context) {
    ballX = MediaQuery.of(context).size.width / 2;
    ballY = MediaQuery.of(context).size.height / 2;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize(context);
    });
  }

  void jump() {
    setState(() {
      // Generate random direction
      directionX = random.nextBool() ? 1 : -1;
      directionY = random.nextBool() ? 1 : -1;

      // Adjust ball position after jump
      ballX += directionX * jumpDistance;
      ballY += directionY * jumpDistance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: jump,
        child: CustomPaint(
          painter: BallPainter(ballX, ballY),
          size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        ),
      ),
    );
  }
}

class BallPainter extends CustomPainter {
  final double ballX;
  final double ballY;

  BallPainter(this.ballX, this.ballY);

  @override
  void paint(Canvas canvas, Size size) {
    final ballPaint = Paint()..color = Colors.blue;
    canvas.drawCircle(Offset(ballX, ballY), 20, ballPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
