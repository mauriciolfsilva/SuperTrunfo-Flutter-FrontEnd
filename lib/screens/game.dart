import 'package:cloud_firestore/cloud_firestore.dart';
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
  // _GameState createState() => _GameState();

  _TestePhaseState createState() => _TestePhaseState();
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

class _TestePhaseState extends State<Game> {
  String animateState = 'deck';
  String jogador2;
  String jogadorDoTurno;
  bool realizarAcao = false;
  int cartaEscolhida;
  var listaCartas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  void passarTurno(String gameId) async {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(gameId).update({
      "jogadorTurno": jogador2,
      "turnoAtivo": false,
    });
  }

  void listenerParaRemoverCartas(String gameId) {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(gameId).snapshots().listen((result) {
      var cartasRemovidas = result.data()['cartasRemovidas'];
      var conjuntoDeck = Set.from(listaCartas);
      var conjuntoRemovidas = Set.from(cartasRemovidas);

      listaCartas = List.from(conjuntoDeck.difference(conjuntoRemovidas));
    });
  }

  void realizarAcaoNoTurno() {
    print('aqui2');
    realizarAcao = true;
  }

  void receberTurno(String gameId, String jogadorPrincipal) async {
    var db = FirebaseFirestore.instance;
    var data;
    await db
        .collection('partidas')
        .doc(gameId)
        .get()
        .then((doc) => {data = doc.data()});

    jogador2 = data['jogador2'];

    db.collection('partidas').doc(gameId).snapshots().listen((result) {
      var turnoAtivo = result.data()['turnoAtivo'];
      jogadorDoTurno = result.data()['jogadorTurno'];
      if (jogadorDoTurno == jogadorPrincipal && turnoAtivo != true) {
        db.collection('partidas').doc(gameId).update({
          "turnoAtivo": true,
        });

        realizarAcaoNoTurno();
      }
    });
  }

  double animateWidth(String state) {
    if (state == 'zoom') return 100;
    return 1000;
  }

  Alignment animateAlignment(String state) {
    switch (state) {
      case 'deck':
        print(1);
        return Alignment.bottomRight;
      case 'draw':
        print(2);
        return Alignment.bottomCenter;
      case 'zoom':
        print(3);
        return Alignment.center;
      default:
        print(4);
        return Alignment.bottomCenter;
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    var jogadorPrincipal = arguments['playerName'];
    var gameId = arguments['gameId'];
    Carta cartaDaVez =
        Carta(1, "Hélio", 0.0008988, 38, -259.14, 1312.0, 2.2, 7);
    receberTurno(gameId, jogadorPrincipal); //
    listenerParaRemoverCartas(gameId);
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
            child: PageView(children: <Widget>[
              RaisedButton(
                child: Column(
                  children: [
                    Text(
                      'Jogador: ' +
                          jogadorPrincipal +
                          '\n' +
                          'GameId: ' +
                          gameId +
                          '\n' +
                          'Cartas ainda disponiveis: ' +
                          listaCartas.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (realizarAcao) {
                            cartaEscolhida =
                                (listaCartas.toList()..shuffle()).first;

                            print(cartaEscolhida);
                            print('aqui');

                            var db = FirebaseFirestore.instance;

                            db.collection('partidas').doc(gameId).update({
                              "cartasRemovidas":
                                  FieldValue.arrayUnion([cartaEscolhida])
                            });

                            realizarAcao = false;
                          }
                          ;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                      ),
                      child: Text(
                        'Sacar Carta',
                        style: new TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          passarTurno(gameId);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                      ),
                      child: Text(
                        'Passar turno',
                        style: new TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ValueListenableBuilder(
              //   //TODO 2nd: listen playerPointsToAdd
              //   valueListenable: listaCartas,
              //   builder: (context, value, widget) {
              //     //TODO here you can setState or whatever you need
              //     return Text(
              //         //TODO e.g.: create condition with playerPointsToAdd's value
              //         value == 0
              //             ? 'playerPointsToAdd equals 0 right now'
              //             : value.toString());
              //   },
              // ),

              AnimatedAlign(
                alignment: animateAlignment(animateState),
                duration: Duration(seconds: 1),
                child: AnimatedContainer(
                  width: animateWidth(animateState),
                  duration: Duration(seconds: 1),
                  child: cartaDaVez,
                ),
              )
            ]),
          ),
        ));
  }
}
