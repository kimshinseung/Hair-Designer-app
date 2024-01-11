import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({Key? key, required this.imageProvider}) : super(key: key);
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(image: imageProvider),
      ),
    );
  }
}