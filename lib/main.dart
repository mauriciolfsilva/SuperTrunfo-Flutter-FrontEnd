import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grupoazul20211/route/route.dart' as router;

/*
 * Descricao do modulo:
 * Widget raiz do aplicativo que tem como rota inicial o MainMenu.
 *
 * Github:
 * https://github.com/mauriciolfsilva/SuperTrunfo-Flutter-FrontEnd
 */

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
      onGenerateRoute: router.controller,
      initialRoute: router.mainMenuPage,
    );
  }
}
