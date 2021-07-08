import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grupoazul20211/route/route.dart' as router;

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

  Future<bool> usernameValidation() async {
    var db = FirebaseFirestore.instance;
    DocumentSnapshot foundedUser =
        await db.collection('usuarios').doc(playerName).get();
    return foundedUser.data() == null
        ? Future<bool>.value(true)
        : Future<bool>.value(false);
  }

  void signInNewUser() async {
    var db = FirebaseFirestore.instance;
    var validNewUser = await usernameValidation();
    if (validNewUser) {
      db.collection('usuarios').doc(playerName).set({
        "usuario": playerName,
        "senha": playerPassword,
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
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
              height: 400.0,
            ),
            screenController == 'Home'
                ? SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          screenController = 'Login';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                      ),
                      child: Text(
                        'Iniciar Jogo',
                        style: new TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                : Text(''),
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
                : Text(''),
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
                : Text(''),
            screenController == 'Login'
                ? SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // var db = FirebaseFirestore.instance;
                          // db.collection("usuarios").add({
                          //   "nome": playerName,
                          // });
                        });
                        Navigator.pushNamed(context, router.userMenuPage);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                      ),
                      child: Text(
                        'Login',
                        style: new TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                : Text(''),
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
                      child: Text(
                        'Cadastrar',
                        style: new TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                : Text(''),
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
                        primary: Colors.redAccent,
                      ),
                      child: Text(
                        'Retornar',
                        style: new TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}
