import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailFeature extends StatefulWidget {
  final String feature;
  const DetailFeature({Key? key, required this.feature}) : super(key: key);
  @override
  State<DetailFeature> createState() => _DetailFeatureState();
}

class _DetailFeatureState extends State<DetailFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(widget.feature),
        ],
      ),
    );
  }
}
