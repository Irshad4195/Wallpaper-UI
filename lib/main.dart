import 'package:flutter/material.dart';
import 'package:gallery_ui/sample1.dart';
import 'package:gallery_ui/samplw.dart';
import 'package:gallery_ui/wallpaper_screen.dart';

void main() {
  runApp(const WallpaperUI());
}

class WallpaperUI extends StatelessWidget {
  const WallpaperUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wallpaper App",
      home: Sample1(),
    );
  }
}
