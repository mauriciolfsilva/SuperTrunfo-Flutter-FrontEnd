import 'package:flutter/material.dart';

//classe que extende estados que serão usados para manipular as informações
//na tela.
class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String playerName, playerPassword, playerEmail, playerId;
  String screenController = 'Home';

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
                          onChanged: (value) {
                            if (value.length > 0) {
                              playerName = value;
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
                          screenController = 'Cadastrar';
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
