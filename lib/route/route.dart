import 'package:flutter/material.dart';
import 'package:grupoazul20211/screens/game.dart';
import 'package:grupoazul20211/screens/main-menu.dart';
import 'package:grupoazul20211/screens/user-menu.dart';
import 'package:grupoazul20211/screens/teste-jogabilidade.dart';

//Route Names
const String mainMenuPage = 'Home';
const String userMenuPage = 'UserMenu';
const String gamePage = 'Game';
const String testPage = 'Teste';

//Controller
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case mainMenuPage:
      return MaterialPageRoute(
          settings: settings, builder: (context) => MainMenu());
    case userMenuPage:
      return MaterialPageRoute(
          settings: settings, builder: (context) => UserMenu());
    case gamePage:
      return MaterialPageRoute(
          settings: settings, builder: (context) => Game());
    case testPage:
      return MaterialPageRoute(
          settings: settings, builder: (context) => TestePhase());
    default:
      throw ('Rota inexistente');
  }
}
