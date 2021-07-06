import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './screens/main-menu.dart';

// Inicia o app como um todo
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicia o Firebase
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainMenu(),
    );
  }
}
