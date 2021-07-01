import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String playerName = '';
  bool showInput = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            showInput
                ? SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showInput = !showInput;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                      ),
                      child: Text('Iniciar Jogo'),
                    ),
                  )
                : SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showInput = !showInput;
                        });
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
                            labelText: 'Enter your username'),
                      ),
                    ),
                  ),
            !showInput
                ? SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showInput = !showInput;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                      ),
                      child: Text('Confirm'),
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}
