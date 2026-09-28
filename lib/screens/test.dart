import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Container Demo")),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Apple'), Text('Banana'), Text('Mango')]),
      ),
    ),
  );
}

