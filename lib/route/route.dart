import 'package:flutter/material.dart';
import 'package:grupoazul20211/screens/game.dart';
import 'package:grupoazul20211/screens/main-menu.dart';
import 'package:grupoazul20211/screens/user-menu.dart';

/*
 * Descricao do modulo:
 * Esse arquivo implementa o método controller que retorna cada rota (tela a ser exibida) do aplicativo.
 *
 * Github:
 * https://github.com/mauriciolfsilva/SuperTrunfo-Flutter-FrontEnd
 */


//Route Names
const String mainMenuPage = 'Home';
const String userMenuPage = 'UserMenu';
const String gamePage = 'Game';
const String testPage = 'Teste';

//Controla as rotas da aplicação
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
    default:
      throw ('Rota inexistente');
  }
}
