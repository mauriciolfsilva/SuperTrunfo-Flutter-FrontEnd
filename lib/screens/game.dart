import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grupoazul20211/screens/main-menu.dart';
import 'package:show_up_animation/show_up_animation.dart';
import '../consts/Cards.dart' as CardsAtributtes;

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
  _TestePhaseState createState() => _TestePhaseState();
}

class _TestePhaseState extends State<Game> {
  String animateState = 'deck';
  String jogador1, jogador2, jogadorTurno;
  int pontuacaoJogador1, pontuacaoJogador2;
  int idCartaTurnoJogadorTurno, idCartaTurnoJogadorNaoTurno;
  var atributoTurno;
  int cartaSorteada;
  var jogadorPrincipal, gameId;
  var cartasNoDeck = [1, 2, 3];

  double animateWidth(String state) {
    if (state == 'zoom') return 300;
    return 100;
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

  String getNomeJogadorAdversario() {
    return this.jogador1 == this.jogadorPrincipal
        ? this.jogador2
        : this.jogador1;
  }

  void passarTurno() async {
    calcularPontuacaoRodada();
    var jogadorAdversario = getNomeJogadorAdversario();
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(this.gameId).update({
      "idCartaTurnoJogadorNaoTurno": null,
      "idCartaTurnoJogadorTurno": null,
      "atributoTurno": null,
      "jogadorTurno": jogadorAdversario,
    });
    this.cartaSorteada = null;
  }

  bool jodadorPrincipalEJogadorTurno() {
    return this.jogadorPrincipal == this.jogadorTurno;
  }

  void atualizarAtributoTurno(dadosPartida) {
    this.atributoTurno = dadosPartida['atributoTurno'];
  }

  void atualizarJogadorTurno(dadosPartida) {
    this.jogadorTurno = dadosPartida['jogadorTurno'];
  }

  void atualizarPontuacaoJogadores(dadosPartida) {
    this.pontuacaoJogador1 = dadosPartida['pontuacaoJogador1'];
    this.pontuacaoJogador2 = dadosPartida['pontuacaoJogador2'];
  }

  void atualizarIdsCartasTurnoJogadores(dadosPartida) {
    this.idCartaTurnoJogadorTurno = dadosPartida['idCartaTurnoJogadorTurno'];
    this.idCartaTurnoJogadorNaoTurno =
        dadosPartida['idCartaTurnoJogadorNaoTurno'];
  }

  void atualizarCartasNoDeck(dadosDaPartida) {
    var cartasRemovidas = dadosDaPartida['cartasRemovidas'];
    var conjuntoRemovidas = Set.from(cartasRemovidas);
    var conjuntoDeck = Set.from(this.cartasNoDeck);
    this.cartasNoDeck = List.from(conjuntoDeck.difference(conjuntoRemovidas));
  }

  void atualizarAtributos(DocumentSnapshot partida) {
    var dadosPartida = partida.data();
    atualizarCartasNoDeck(dadosPartida);
    atualizarIdsCartasTurnoJogadores(dadosPartida);
    atualizarPontuacaoJogadores(dadosPartida);
    atualizarJogadorTurno(dadosPartida);
    atualizarAtributoTurno(dadosPartida);
  }

  Future<void> listenerDoJogo() async {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(this.gameId).snapshots().listen((result) {
      atualizarAtributos(result);

      /*
      if (jodadorPrincipalEJogadorTurno() &&
          idCartaTurnoJogadorTurno == null) {
        solicitarSaqueDeCarta();
      } else if (jogadorTurno == jogadorPrincipal &&
          idCartaTurnoJogadorTurno != null) {
        if (idCartaTurnoJogadorNaoTurno != null) {
          calcularPontuacaoRodada();
        } else {
          esperarJogadorNaoTurnoRetirarCarta();
        }
      } else if (jogadorTurno != jogadorPrincipal &&
          idCartaTurnoJogadorNaoTurno == null) {
        solicitarSaqueDeCartaNaoTurno();
      } else if (jogadorTurno != jogadorPrincipal &&
          idCartaTurnoJogadorNaoTurno != null) {
        if (idCartaTurnoJogadorTurno != null) {
          esperarJogador1CalcularPontuacao();
        } else {
          esperarJogadorTurnoRetirarCarta();
        }
      }
      */
    });
  }

  void solicitarSaqueDeCarta() {
    // Escrever na tela para o jogador sacar a carta
  }

  void solicitarEscolhaDeAtributoDaCarta() {
    // Pedir para o jogador selecionar o atributo da rodada
  }

  void inserirCartaJogadorBD(carta) {
    var atributoBD = jodadorPrincipalEJogadorTurno()
        ? "idCartaTurnoJogadorTurno"
        : "idCartaTurnoJogadorNaoTurno";
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(this.gameId).update({atributoBD: carta});
  }

  void atualizarCartasRemovidasBD(cartaRemovida) {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(this.gameId).update({
      "cartasRemovidas": FieldValue.arrayUnion([cartaRemovida])
    });
  }

  sortearCarta(List cartas) {
    cartas.shuffle();
    return cartas[0];
  }

  //Essa função deve ser chamada quando o jogador
  //desejar selecionar uma nova carta do baralho
  void sacarCarta() {
    if (this.cartaSorteada == null) {
      this.cartaSorteada = sortearCarta(this.cartasNoDeck);
      atualizarCartasRemovidasBD(this.cartaSorteada);
      inserirCartaJogadorBD(this.cartaSorteada);
      print(this.cartaSorteada);
      var carta = CardsAtributtes.properties[this.cartaSorteada];

      showMyDialog('Sacando a carta',
          'Carta Sorteada ' + this.cartaSorteada.toString(), carta['nome']);
    }
  }

  void escolherAtributoTurno(atributo) {
    if (jogadorPrincipal == jogadorTurno) {
      var db = FirebaseFirestore.instance;
      db
          .collection('partidas')
          .doc(this.gameId)
          .update({"atributoTurno": atributo});
    }
  }

  void calcularPontuacaoRodada() {
    if (jogadorPrincipal == jogadorTurno) {
      var cartaJogadorPrincipal =
          CardsAtributtes.properties[idCartaTurnoJogadorTurno];
      var cartaJogadorAdversario =
          CardsAtributtes.properties[idCartaTurnoJogadorNaoTurno];

      var principalVencedor =
          cartaJogadorPrincipal[atributoTurno] > cartaJogadorAdversario;
      var updateQuery;

      if (jogadorPrincipal == jogador1 && principalVencedor) {
        updateQuery = {"pontuacaoJogador1": FieldValue.increment(1)};
      } else if (jogadorPrincipal == jogador2 && principalVencedor) {
        updateQuery = {"pontuacaoJogador2": FieldValue.increment(1)};
      } else if (jogadorPrincipal == jogador1 && !principalVencedor) {
        updateQuery = {"pontuacaoJogador2": FieldValue.increment(1)};
      } else if (jogadorPrincipal == jogador2 && !principalVencedor) {
        updateQuery = {"pontuacaoJogador1": FieldValue.increment(1)};
      }

      var db = FirebaseFirestore.instance;
      db.collection('partidas').doc(this.gameId).update(updateQuery);
    }
    // calcular baseado nos 2 ids de cartas escolhidas no banco e pelo atributo escolhido quem venceu a rodada,
    // somar ponto no banco para o jogador que venceu e zerar demais atributos de jogo no banco, como ids e atributo escolhido.
    // passar a vez para o proximo jogador
  }

  void solicitarSaqueDeCartaNaoTurno() {
    // Escrever na tela para o jogador sacar a carta
    // Preencher no banco qual o id da carta selecionada pelo jogador do Nao turno
    // preencher no banco qual id de carta foi removida pelo jogador
  }

  void esperarJogadorNaoTurnoRetirarCarta() {
    //Animacao ou mensagem de aguardando ação do proximo jogador
  }

  void esperarJogador1CalcularPontuacao() {
    //Animacao ou mensagem de aguardando ação do proximo jogador
  }

  void esperarJogadorTurnoRetirarCarta() {
    //Animacao ou mensagem de aguardando ação do proximo jogador
  }

  Future<List> getJogadoresBD() async {
    var db = FirebaseFirestore.instance;
    DocumentSnapshot partida =
        await db.collection('partidas').doc(this.gameId).get();
    var dados = partida.data();
    return [dados['jogador1'], dados['jogador2'], dados['jogadorTurno']];
  }

  Future<void> inicializarAtributos(context) async {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    this.jogadorPrincipal = arguments['playerName'];
    this.gameId = arguments['gameId'];
    var jogadores = await getJogadoresBD();
    this.jogador1 = jogadores[0];
    this.jogador2 = jogadores[1];
    this.jogadorTurno = jogadores[2];
  }

  Future<void> showMyDialog(
      String title, String firstLine, String secondLine) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(firstLine),
                Text(secondLine),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    inicializarAtributos(context);
    listenerDoJogo();
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
              child: Column(children: [
                RaisedButton(
                  child: const Text('Sacar carta'),
                  color: Colors.red,
                  elevation: 4.0,
                  splashColor: Colors.yellow,
                  onPressed: () {
                    sacarCarta();
                  },
                ),
                RaisedButton(
                  child: const Text('Passar turno'),
                  color: Colors.red,
                  elevation: 4.0,
                  splashColor: Colors.purple,
                  onPressed: () {
                    passarTurno();
                  },
                ),
                Column(
                    children: (jogadorPrincipal == jogadorTurno)
                        ? [
                            RaisedButton(
                              child: const Text('Escolher Atributo: Raio'),
                              color: Colors.blue,
                              elevation: 4.0,
                              splashColor: Colors.purple,
                              onPressed: () {
                                escolherAtributoTurno('raio');
                              },
                            ),
                            RaisedButton(
                              child: const Text('Escolher Atributo: Densidade'),
                              color: Colors.blue,
                              elevation: 4.0,
                              splashColor: Colors.purple,
                              onPressed: () {
                                escolherAtributoTurno('densidade');
                              },
                            ),
                            RaisedButton(
                              child: const Text('Escolher Atributo: Fusão'),
                              color: Colors.blue,
                              elevation: 4.0,
                              splashColor: Colors.purple,
                              onPressed: () {
                                escolherAtributoTurno('fusao');
                              },
                            ),
                            RaisedButton(
                              child: const Text('Escolher Atributo: Energia'),
                              color: Colors.blue,
                              elevation: 4.0,
                              splashColor: Colors.purple,
                              onPressed: () {
                                escolherAtributoTurno('energia');
                              },
                            ),
                            RaisedButton(
                              child:
                                  const Text('Escolher Atributo: Negatividade'),
                              color: Colors.blue,
                              elevation: 4.0,
                              splashColor: Colors.purple,
                              onPressed: () {
                                escolherAtributoTurno('negatividade');
                              },
                            ),
                            RaisedButton(
                              child:
                                  const Text('Escolher Atributo: Abundancia'),
                              color: Colors.blue,
                              elevation: 4.0,
                              splashColor: Colors.purple,
                              onPressed: () {
                                escolherAtributoTurno('abundancia');
                              },
                            )
                          ]
                        : []),
                AnimatedAlign(
                    alignment: animateAlignment(animateState),
                    duration: Duration(seconds: 1),
                    child: AnimatedContainer(
                      width: animateWidth(animateState),
                      duration: Duration(seconds: 1),
                      child: ElevatedButton(
                          child: Image.asset('assets/images/1.jpg'),
                          onPressed: () {
                            setState(() {
                              animateState =
                                  animateState == 'draw' ? 'zoom' : 'draw';
                            });
                          }),
                    )),
              ])),
        ));
  }
}

class TestePhase extends StatefulWidget {
  @override
  _TestePhaseState createState() => _TestePhaseState();
}

void mostraWidgetPorUmTempo({@required BuildContext context, Widget widget}) {
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(builder: (context) => widget);
  Overlay.of(context).insert(overlayEntry);
  Timer(Duration(seconds: 4), () => overlayEntry.remove());
}

Widget vsText() {
  return Center(
    child: ShowUpAnimation(
      //suaviza a entrada pra usar tem q por dependencia no pubspec
      delayStart: Duration(seconds: 0),
      animationDuration: Duration(seconds: 1),
      curve: Curves.bounceIn,
      direction: Direction.vertical,
      offset: 0.5,
      child: Material(
        type: MaterialType.transparency,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Jogador 1   ', //${this.nome} ?
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/images/vs.png',
              width: 50,
              height: 50,
              //fit: BoxFit.fill,
            ),
            Text(
              '   Jogador 2', //${this.nome} ?
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Widget que mostra a tela de vitória ou derrota no fim da partida
/* pra testar ta na linha 196
*/
Widget resultado(String text, MaterialColor cor, BuildContext context) {
  return Stack(
    children: <Widget>[
      BackdropFilter(
        // deixa o fundo borrado
        filter: ImageFilter.blur(
          sigmaX: 8.0,
          sigmaY: 8.0,
        ),
        child: Container(
          color: Colors.transparent,
        ),
      ),
      Center(
        child: ShowUpAnimation(
          //suaviza a entrada pra usar tem q por dependencia no pubspec
          delayStart: Duration(seconds: 0),
          animationDuration: Duration(seconds: 1),
          curve: Curves.bounceIn,
          direction: Direction.vertical,
          offset: 0.5,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              height: 200,
              width: 350,
              child: Card(
                shadowColor: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          text,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 65.0,
                            color: cor,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 7.0,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          "assets/images/dance-anime-omae-wa-mou-shindeiru.gif",
                          height: 125.0,
                          width: 125.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MainMenu()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                        ),
                        child: Text(
                          'Jogar novamente',
                          style: new TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
