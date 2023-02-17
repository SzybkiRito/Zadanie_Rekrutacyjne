import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.result});
  final dynamic result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$result',
          style: const TextStyle(fontSize: 64),
        ),
      ),
    );
  }
}
