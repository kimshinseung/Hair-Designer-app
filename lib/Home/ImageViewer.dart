
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, required this.path});
  final Widget path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: path,
      ),
    );
  }
}
