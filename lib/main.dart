import 'package:flutter/material.dart';
import 'dart:io';
import 'package:window_size/window_size.dart' as window_size;
import 'pages/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    var window = await window_size.getWindowInfo();
    if (window.screen != null) {
      final screenFrame = window.screen!.visibleFrame;
      final width = 500.0;
      final height = 700.0;
      final left = ((screenFrame.width - width) / 2).roundToDouble();
      final top = ((screenFrame.height - height) / 3).roundToDouble();
      final frame = Rect.fromLTWH(left, top, width, height);
      window_size.setWindowFrame(frame);
      window_size.setWindowMinSize(Size(1.0 * width, 1.0 * height));
      window_size.setWindowMaxSize(Size(1.0 * width, 1.0 * height));
    }
  }
  runApp(const MyApp());
}
