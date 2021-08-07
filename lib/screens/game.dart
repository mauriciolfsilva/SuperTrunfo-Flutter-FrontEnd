import 'package:flutter/material.dart';

class Carta extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: 310,
        height: 410,
        decoration: BoxDecoration(color: Colors.white),
      ),
      Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(color: Colors.red),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/${this.id}.jpg'),
              ),
              Text(
                '${this.nome}',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${this.id}',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Colors.teal.shade100,
                  fontSize: 16.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                  width: 260,
                  height: 30,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(children: <Widget>[
                    Icon(Icons.star, color: Colors.blue, size: 20),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          'Densidade: ${this.densidade} g/cm3',
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 14.0,
                          ),
                        ))
                  ])),
              Container(
                  width: 260,
                  height: 30,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(children: <Widget>[
                    Icon(Icons.star, color: Colors.green, size: 20),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          'Raio covalente: ${this.raio} pm',
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 14.0,
                          ),
                        ))
                  ])),
              Container(
                  width: 260,
                  height: 30,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(children: <Widget>[
                    Icon(Icons.star, color: Colors.teal.shade900, size: 20),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          'Ponto de fusão: ${this.fusao}°C',
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 14.0,
                          ),
                        ))
                  ])),
              Container(
                  width: 260,
                  height: 30,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(children: <Widget>[
                    Icon(Icons.star, color: Colors.teal.shade900, size: 20),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          'Energia de ionização: ${this.energia} kJ/mol',
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 12.0,
                          ),
                        ))
                  ])),
            ],
          ))
    ]);
  }
}

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Carta cartaDaVez =
      Carta(1, "Hélio", 0.0008988, 38, -259.14, 1312.0, 2.2, 7); //teste
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          body: new Container(alignment: Alignment.center, child: cartaDaVez)),
    );
  }
}
