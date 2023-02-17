import 'package:flutter/material.dart';

import 'Screnns/webview_practice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice project',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const WebViewPractice(),
      debugShowCheckedModeBanner: false,
    );
  }
}
