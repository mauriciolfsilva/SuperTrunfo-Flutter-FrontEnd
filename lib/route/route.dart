import 'package:flutter/material.dart';
import 'package:grupoazul20211/screens/main-menu.dart';
import 'package:grupoazul20211/screens/user-menu.dart';

//Route Names
const String mainMenuPage = 'Home';
const String userMenuPage = 'UserMenu';

//Controller
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case mainMenuPage:
      return MaterialPageRoute(builder: (context) => MainMenu());
    case userMenuPage:
      return MaterialPageRoute(builder: (context) => UserMenu());
    default:
      throw ('Rota inexistente');
  }
}
