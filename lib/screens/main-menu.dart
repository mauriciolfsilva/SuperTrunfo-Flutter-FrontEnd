import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grupoazul20211/route/route.dart' as router;

/*
 * Descricao do modulo:
 * Carrega os métodos e dados necessários para o processo de login e cadastro de usuário.
 *
 * Github:
 * https://github.com/mauriciolfsilva/SuperTrunfo-Flutter-FrontEnd
 */


//classe que extende estados que serão usados para manipular as informações
//na tela.
class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool _obscureText = true;
  String playerName, playerPassword, playerEmail, playerId;
  String screenController = 'Home';

  //Metodo que valida se o nome do usuário existe no banco
  Future<bool> usernameValidation() async {
    var db = FirebaseFirestore.instance;
    DocumentSnapshot foundedUser =
        await db.collection('usuarios').doc(playerName).get();
    return foundedUser.data() == null
        ? Future<bool>.value(true)
        : Future<bool>.value(false);
  }

  //Metodo que registra um novo usuario no banco
  void signInNewUser() async {
    var db = FirebaseFirestore.instance;
    var validNewUser = await usernameValidation();
    if (validNewUser) {
      db.collection('usuarios').doc(playerName).set({
        "usuario": playerName,
        "senha": playerPassword,
        "estado": "indisponivel",
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Cadastro'),
              content: new Text('Usuario cadastrado com sucesso'),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Cadastro'),
              content: new Text('Erro ao cadastrar usuario já existe'),
            );
          });
    }
  }

  // Loga um usuário levando o mesmo para a sala de busca de partidas
  void logInUser() async {
    var db = FirebaseFirestore.instance;
    DocumentSnapshot foundedUser =
        await db.collection('usuarios').doc(playerName).get();
    if (foundedUser.exists &&
        foundedUser.data()['usuario'] == playerName &&
        foundedUser.data()['senha'] == playerPassword) {
      await db.collection('usuarios').doc(playerName).update({
        'estado': 'disponivel',
      });
      Navigator.pushReplacementNamed(context, router.userMenuPage,
          arguments: {'playerName': playerName});
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Login'),
              content: new Text('Erro usuario ou senha invalidos'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Background.png'),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black45, BlendMode.darken))),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/Logo.png',
                height: 350.0,
              ),
              screenController == 'Home'
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                screenController = 'Login';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.videogame_asset,
                                  color: Colors.pink,
                                  size: 24.0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Iniciar Jogo',
                                  style: new TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                screenController = 'Regras';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.menu_book,
                                  color: Colors.pink,
                                  size: 24.0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Regras',
                                  style: new TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(),
              screenController == 'Regras'
                  ? Card(
                      child: ListTile(
                        title: RichText(
                          text: TextSpan(
                            text: '',
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Quem começa?\n',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                  text: 'O primeiro a entrar na sala.\n\n'),
                              TextSpan(
                                text: 'Quando o jogo termina?\n',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                  text:
                                      'Assim que um dos jogadores obter 7 pontos.\n\n'),
                              TextSpan(
                                text:
                                    'Quando um atributo de um elemento ganha do outro?\n',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: 'Quando ele for maior.\n'),
                            ],
                          ),
                        ),
                      ),
                      elevation: 8,
                      shadowColor: Colors.blue,
                      margin: EdgeInsets.all(20),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 1)),
                    )
                  : Column(),
              screenController == 'Login' || screenController == 'Cadastrar'
                  ? SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: TextFormField(
                          validator: (val) => val.length < 4
                              ? 'Nome de usuario muito curto.'
                              : null,
                          onChanged: (value) {
                            if (value.length > 0) {
                              playerName = value;
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Digite seu usuario'),
                        ),
                      ),
                    )
                  : Column(),
              screenController == 'Login' || screenController == 'Cadastrar'
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        top: 20,
                        right: 40,
                        bottom: 20,
                      ),
                      child: SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: TextFormField(
                            obscureText: _obscureText,
                            validator: (val) =>
                                val.length < 4 ? 'Senha muito curta.' : null,
                            onChanged: (value) {
                              if (value.length > 0) {
                                playerPassword = value;
                              }
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Digite sua senha'),
                          ),
                        ),
                      ))
                  : Column(),
              screenController == 'Login'
                  ? SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            logInUser();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.login,
                              color: Colors.pink,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Login',
                              style: new TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(),
              screenController == 'Home' || screenController == 'Cadastrar'
                  ? SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (screenController == 'Cadastrar') {
                              signInNewUser();
                            } else {
                              screenController = 'Cadastrar';
                            }
                            // var db = FirebaseFirestore.instance;
                            // db.collection("usuarios").add({
                            //   "nome": playerName,
                            // });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.assistant_photo,
                              color: Colors.pink,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Cadastrar',
                              style: new TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(),
              screenController != 'Home'
                  ? SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            screenController = 'Home';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.pink,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Retornar',
                              style: new TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(),
            ],
          ),
        ),
      ),
    );
  }
}
