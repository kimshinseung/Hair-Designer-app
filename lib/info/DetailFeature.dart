import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailFeature extends StatefulWidget {
  final Map<String, String> featureData;

  DetailFeature({Key? key, required this.featureData}) : super(key: key);
  @override
  State<DetailFeature> createState() => _DetailFeatureState();
}

class _DetailFeatureState extends State<DetailFeature> {

  @override
  Widget build(BuildContext context) {
    String feature = widget.featureData['feature'] ?? 'Unknown';
    String date = widget.featureData['date'] ?? 'Unknown';

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 80,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(date,style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(feature, style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold
            ),),
          ),
        ],
      ),
    );
  }
}
