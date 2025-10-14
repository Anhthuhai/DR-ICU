import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class LaunchImageGenerator {
  static Future<void> generateLaunchImages() async {
    // Create different sizes
    final sizes = [
      {'name': 'LaunchImage.png', 'width': 168.0, 'height': 185.0},
      {'name': 'LaunchImage@2x.png', 'width': 336.0, 'height': 370.0},
      {'name': 'LaunchImage@3x.png', 'width': 504.0, 'height': 555.0},
    ];

    for (final size in sizes) {
      await _generateSingleImage(
        size['name'] as String,
        size['width'] as double,
        size['height'] as double,
      );
    }
  }

  static Future<void> _generateSingleImage(
    String filename,
    double width,
    double height,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    
    // Background gradient
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF0077BE), // Medical blue
        Color(0xFFE8F4F8), // Light blue
      ],
    );
    
    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, width, height));
    
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
    
    // Draw medical cross
    final crossPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    final crossSize = width * 0.15;
    final centerX = width / 2;
    final centerY = height / 2 - 20;
    
    // Horizontal bar of cross
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: crossSize * 2,
        height: crossSize * 0.6,
      ),
      crossPaint,
    );
    
    // Vertical bar of cross
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: crossSize * 0.6,
        height: crossSize * 2,
      ),
      crossPaint,
    );
    
    // Draw app name
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'DR-ICU',
        style: TextStyle(
          color: Colors.white,
          fontSize: width * 0.08,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        centerX - textPainter.width / 2,
        centerY + crossSize + 20,
      ),
    );
    
    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    
    // Save to file (you'll need to implement file saving based on your platform)
    debugPrint('Generated $filename with ${pngBytes.length} bytes');
  }
}

// Widget to preview the design
class LaunchImagePreview extends StatelessWidget {
  const LaunchImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Launch Image Preview')),
      body: Center(
        child: Container(
          width: 168,
          height: 185,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0077BE), // Medical blue
                Color(0xFFE8F4F8), // Light blue
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Medical cross
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Container(
                    width: 15,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'DR-ICU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LaunchImageGenerator.generateLaunchImages();
        },
        child: Icon(Icons.download),
      ),
    );
  }
}
