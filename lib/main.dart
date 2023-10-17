import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDemo(),
    );
  }
}

class GestureDemo extends StatelessWidget {
  void _handleTap() {
    print('Tapped!');
  }

  void _handleHorizontalSwipe(DragUpdateDetails details) {
    print('Swiped horizontally: ${details.delta.dx}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _handleTap,
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(50.0),
                child: Text('Tap me'),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onHorizontalDragUpdate: _handleHorizontalSwipe,
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(50.0),
                child: Text('Swipe horizontally'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
