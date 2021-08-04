import 'package:flutter/material.dart';

class Carta {
  int id; // numero atomico
  String nome;
  double densidade;
  double raio;
  double fusao;
  double energia;
  double negatividade;
  double abundancia;
  Carta(this.id, this.nome, this.densidade, this.raio, this.fusao, this.energia,
      this.negatividade, this.abundancia);

// falta outras caracteristicas de um elemento.

}

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Carta cartaDaVez = Carta(1, "Hélio", 0.0008988, 38, -259.14, 1312.0, 2.2, 7); //teste
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo.png',
                fit: BoxFit.contain,
                height: 51,
              ),
              /*Container(
                  padding: const EdgeInsets.all(16.0), child: Text('Carta'))*/
            ],
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 100.0,
              backgroundImage: AssetImage('assets/images/${cartaDaVez.id}.jpg'),
            ),
            Text(
              '${cartaDaVez.nome}',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${cartaDaVez.id}',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                color: Colors.teal.shade100,
                fontSize: 20.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              //espacinho
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.teal.shade100,
              ),
            ),
            Card(
                //falta reduzir os cards pra caber mais de 4 ou fazer scroll
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Densidade: ${cartaDaVez.densidade} g/cm3',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 14.0,
                    ),
                  ),
                )),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Colors.lightGreenAccent,
                  ),
                  title: Text(
                    'Raio covalente: ${cartaDaVez.raio} pm',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.teal.shade900,
                        fontFamily: 'Source Sans Pro'),
                  ),
                )),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Ponto de fusão: ${cartaDaVez.fusao}°C',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.teal.shade900,
                        fontFamily: 'Source Sans Pro'),
                  ),
                )),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Colors.redAccent,
                  ),
                  title: Text(
                    '1ª Energia de ionização: ${cartaDaVez.energia} kJ/mol',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.teal.shade900,
                        fontFamily: 'Source Sans Pro'),
                  ),
                )),
            /*Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.purpleAccent,
              ),
              title: Text(
                '${(cartaDaVez.negatividade)}',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.teal.shade900,
                    fontFamily: 'Source Sans Pro'),
              ),
            )),
        Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.brown,
              ),
              title: Text(
                '${cartaDaVez.abundancia}',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.teal.shade900,
                    fontFamily: 'Source Sans Pro'),
              ),
            )),*/
          ],
        )),
      ),
    );
  }
}
