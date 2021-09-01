import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:grupoazul20211/screens/main-menu.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../consts/Cards.dart' as CardsAtributtes;

Widget resultado(bool gameWin, BuildContext context) {
  String text;
  MaterialColor cor;
  String imgurl;
  if (gameWin) {
    text = "Vitória";
    cor = Colors.cyan;
    imgurl = "assets/images/dance-anime-omae-wa-mou-shindeiru.gif";
  } else {
    text = "Derrota";
    cor = Colors.cyan;
    imgurl = "assets/images/loser.gif"; // mudar
  }
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
                          "$imgurl",
                          height: 120.0,
                          width: 120.0,
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

class Carta extends StatelessWidget {
  int id;
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
    return FittedBox(
        fit: BoxFit.fill,
        child: Stack(alignment: Alignment.center, children: [
          Container(
              width: 300,
              height: 450,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
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
                      height: 50,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 30,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                onSurface: Colors.transparent,
                              ),
                              onPressed: () => {
                                    if (_TestePhaseState.jogadorPrincipal ==
                                        _TestePhaseState.jogadorTurno)
                                      {
                                        _TestePhaseState.escolherAtributoTurno(
                                            "densidade")
                                      }
                                  },
                              child: Row(children: <Widget>[
                                Icon(Icons.star, color: Colors.blue, size: 20),
                                Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Densidade:\n ${this.densidade} g/cm3',
                                      style: TextStyle(
                                        color: Colors.teal.shade900,
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 14.0,
                                      ),
                                    ))
                              ])))),
                  Container(
                      width: 260,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 30,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                onSurface: Colors.transparent,
                              ),
                              onPressed: () => {
                                    if (_TestePhaseState.jogadorPrincipal ==
                                        _TestePhaseState.jogadorTurno)
                                      {
                                        _TestePhaseState.escolherAtributoTurno(
                                            "raio")
                                      }
                                  },
                              child: Row(children: <Widget>[
                                Icon(Icons.star, color: Colors.green, size: 20),
                                Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Raio covalente:\n ${this.raio} pm',
                                      style: TextStyle(
                                        color: Colors.teal.shade900,
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 14.0,
                                      ),
                                    ))
                              ])))),
                  Container(
                      width: 260,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 30,
                          child: TextButton(
                              onPressed: () => {
                                    if (_TestePhaseState.jogadorPrincipal ==
                                        _TestePhaseState.jogadorTurno)
                                      {
                                        _TestePhaseState.escolherAtributoTurno(
                                            "fusao")
                                      }
                                  },
                              child: Row(children: <Widget>[
                                Icon(Icons.star,
                                    color: Colors.teal.shade900, size: 20),
                                Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Ponto de fusão:\n ${this.fusao}°C',
                                      style: TextStyle(
                                        color: Colors.teal.shade900,
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 14.0,
                                      ),
                                    ))
                              ])))),
                  Container(
                      width: 260,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 30,
                          child: TextButton(
                              onPressed: () => {
                                    if (_TestePhaseState.jogadorPrincipal ==
                                        _TestePhaseState.jogadorTurno)
                                      {
                                        _TestePhaseState.escolherAtributoTurno(
                                            "energia")
                                      }
                                  },
                              child: Row(children: <Widget>[
                                Icon(Icons.star,
                                    color: Colors.teal.shade900, size: 20),
                                Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Energia de ionização:\n ${this.energia} kJ/mol',
                                      style: TextStyle(
                                        color: Colors.teal.shade900,
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 14.0,
                                      ),
                                    ))
                              ])))),
                ],
              ))
        ]));
  }
}

class Game extends StatefulWidget {
  _TestePhaseState createState() => _TestePhaseState();
}

class _TestePhaseState extends State<Game> {
  // variavel "inicio" indica que acabamos de iniciar o jogo
  static bool inicio = true;

  // estados do jogo
  static bool gameWin = false; // true quando vence
  static bool gameFinish =
      false; // true quando acaba o jogo -> true p/ ver animação de derrota/vitória

  static String p1AnimateState = 'deck';
  static String p2AnimateState = 'deck';
  static int p1Score = 0;
  static int p2Score = 0;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> cardKey1 = GlobalKey<FlipCardState>();

  static String animateState = 'deck';
  static String jogador1, jogador2, jogadorTurno;
  static int pontuacaoJogador1, pontuacaoJogador2;
  static int idCartaTurnoJogadorTurno, idCartaTurnoJogadorNaoTurno;
  static var atributoTurno;
  static int cartaSorteada;
  static var jogadorPrincipal, gameId;
  static var cartasNoDeck = [1, 2, 3];
  static var timeoutTurno, timeoutSugestaoUsuario;
  static var sugestaoUsuario;
  static bool firstLoad = false;

  static double animateWidth(String state) {
    if (state == 'zoom')
      return 315;
    else if (state == 'display')
      return 190;
    else if (state == 'showCards') return 190;
    return 150;
  }

  static double animateHeight(String state) {
    if (state == 'zoom')
      return 400;
    else if (state == 'display')
      return 290;
    else if (state == 'showCards') return 290;
    return 150;
  }

  static Alignment p1AnimateAlignment(String state) {
    switch (state) {
      case 'deck':
        return Alignment.bottomRight;
      case 'draw':
        return Alignment.bottomCenter;
      case 'zoom':
        return Alignment.center;
      case 'display':
        return Alignment.centerRight;
      case 'showCards':
        return Alignment.centerRight;
    }
  }

  static Alignment p2AnimateAlignment(String state) {
    switch (state) {
      case 'deck':
        return Alignment.topLeft;
      case 'draw':
        return Alignment.topCenter;
      case 'display':
        return Alignment.centerLeft;
      case 'showCards':
        return Alignment.centerLeft;
    }
  }

  static String p1UpdateState(String state) {
    if (state == "draw")
      return "zoom";
    else if (state == "zoom")
      return "display";
    else if (state == "display")
      return "showCards";
    else if (state == "deck")
      return "draw";
    else
      return "deck";
  }

  static String p2UpdateState(String state, String p1State) {
    if (state == "deck" && p1State == "draw")
      return "draw";
    else if (state == "draw" && p1State == "zoom")
      return "draw";
    else if (state == "draw" && p1State == "display")
      return "display";
    else if (state == "display" && p1State == "showCards")
      return "showCards";
    else
      return "deck";
  }

  static Alignment animateAlignment(String state) {
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

  static bool jodadorPrincipalEJogadorTurno() {
    return jogadorPrincipal == jogadorTurno;
  }

  static bool atributoTurnoEscolhido() {
    return atributoTurno != null;
  }

  static bool jogadorPrincipalSacouCarta() {
    return cartaSorteada != null;
  }

  static String getSugestaoUsuario() {
    if (!jogadorPrincipalSacouCarta())
      return "Saque uma carta!";
    else if (jodadorPrincipalEJogadorTurno() && !atributoTurnoEscolhido())
      return "Escolha o atributo da carta!";
    else
      return "Espere o outro jogador jogar!";
  }

  void atualizarSugestaoUsuario() {
    String sugestaoUsuario = getSugestaoUsuario();
    setState(() => sugestaoUsuario = "Dica: $sugestaoUsuario");
  }

  static void iniciarTemporizadoresDoJogo() {
    timeoutTurno = Timer(Duration(seconds: 60), () {
      //this.timeoutSugestaoUsuario.cancel();
      print("USUÁRIO DESISTIU DO JOGO!");
    });
  }

  static String getNomeJogadorAdversario() {
    return jogador1 == jogadorPrincipal ? jogador2 : jogador1;
  }

  void passarTurno() async {
    calcularPontuacaoRodada();
    var jogadorAdversario = getNomeJogadorAdversario();
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(gameId).update({
      "idCartaTurnoJogadorNaoTurno": null,
      "idCartaTurnoJogadorTurno": null,
      "atributoTurno": null,
      "jogadorTurno": jogadorAdversario,
    });
    cartaSorteada = null;
  }

  static void atualizarAtributoTurno(dadosPartida) {
    atributoTurno = dadosPartida['atributoTurno'];
  }

  static void atualizarJogadorTurno(dadosPartida) {
    jogadorTurno = dadosPartida['jogadorTurno'];
  }

  static void atualizarPontuacaoJogadores(dadosPartida) {
    pontuacaoJogador1 = dadosPartida['pontuacaoJogador1'];
    pontuacaoJogador2 = dadosPartida['pontuacaoJogador2'];
  }

  static void atualizarIdsCartasTurnoJogadores(dadosPartida) {
    idCartaTurnoJogadorTurno = dadosPartida['idCartaTurnoJogadorTurno'];
    idCartaTurnoJogadorNaoTurno = dadosPartida['idCartaTurnoJogadorNaoTurno'];
  }

  static void atualizarCartasNoDeck(dadosDaPartida) {
    var cartasRemovidas = dadosDaPartida['cartasRemovidas'];
    var conjuntoRemovidas = Set.from(cartasRemovidas);
    var conjuntoDeck = Set.from(cartasNoDeck);
    cartasNoDeck = List.from(conjuntoDeck.difference(conjuntoRemovidas));
  }

  static void atualizarAtributos(DocumentSnapshot partida) {
    var dadosPartida = partida.data();
    atualizarCartasNoDeck(dadosPartida);
    atualizarIdsCartasTurnoJogadores(dadosPartida);
    atualizarPontuacaoJogadores(dadosPartida);
    atualizarJogadorTurno(dadosPartida);
    atualizarAtributoTurno(dadosPartida);
  }

  static void verificarSePartidaFinalizada(DocumentSnapshot partida) {
    var dadosPartida = partida.data();
    p1Score = dadosPartida['pontuacaoJogador1'];
    p2Score = dadosPartida['pontuacaoJogador2'];
  }

  Future<void> listenerDoJogo() async {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(gameId).snapshots().listen((result) {
      atualizarAtributos(result);
      atualizarSugestaoUsuario();
      verificarSePartidaFinalizada(result);
    });
  }

  static void inserirCartaJogadorBD(carta) {
    var atributoBD = jodadorPrincipalEJogadorTurno()
        ? "idCartaTurnoJogadorTurno"
        : "idCartaTurnoJogadorNaoTurno";
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(gameId).update({atributoBD: carta});
  }

  static void atualizarCartasRemovidasBD(cartaRemovida) {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(gameId).update({
      "cartasRemovidas": FieldValue.arrayUnion([cartaRemovida])
    });
  }

  static sortearCarta(List cartas) {
    cartas.shuffle();
    return cartas[0];
  }

  //Essa função deve ser chamada quando o jogador
  //desejar selecionar uma nova carta do baralho
  void sacarCarta() {
    if (cartaSorteada == null) {
      cartaSorteada = sortearCarta(cartasNoDeck);
      atualizarCartasRemovidasBD(cartaSorteada);
      inserirCartaJogadorBD(cartaSorteada);
      print(cartaSorteada);
      var carta = CardsAtributtes.properties[cartaSorteada];

      showMyDialog('Sacando a carta',
          'Carta Sorteada ' + cartaSorteada.toString(), carta['nome']);
    }
  }

  static void escolherAtributoTurno(atributo) {
    if (jogadorPrincipal == jogadorTurno) {
      var db = FirebaseFirestore.instance;
      db.collection('partidas').doc(gameId).update({"atributoTurno": atributo});
    }
  }

  static void calcularPontuacaoRodada() {
    if (jogadorPrincipal == jogadorTurno) {
      var cartaJogadorPrincipal =
          CardsAtributtes.properties[idCartaTurnoJogadorTurno];
      var cartaJogadorAdversario =
          CardsAtributtes.properties[idCartaTurnoJogadorNaoTurno];

      var principalVencedor = cartaJogadorPrincipal[atributoTurno] >
          cartaJogadorAdversario[atributoTurno];
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
      db.collection('partidas').doc(gameId).update(updateQuery);
    }
    // calcular baseado nos 2 ids de cartas escolhidas no banco e pelo atributo escolhido quem venceu a rodada,
    // somar ponto no banco para o jogador que venceu e zerar demais atributos de jogo no banco, como ids e atributo escolhido.
    // passar a vez para o proximo jogador
  }

  Future<List> getJogadoresBD() async {
    var db = FirebaseFirestore.instance;
    DocumentSnapshot partida =
        await db.collection('partidas').doc(gameId).get();
    var dados = partida.data();
    return [dados['jogador1'], dados['jogador2'], dados['jogadorTurno']];
  }

  Future<void> inicializarAtributos(context) async {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    jogadorPrincipal = arguments['playerName'];
    gameId = arguments['gameId'];
    var jogadores = await getJogadoresBD();
    jogador1 = jogadores[0];
    jogador2 = jogadores[1];
    jogadorTurno = jogadores[2];
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
    if (!firstLoad) {
      inicializarAtributos(context);
      listenerDoJogo();
      iniciarTemporizadoresDoJogo();
      firstLoad = true;
    }
    Timer(Duration(seconds: 1), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (inicio) {
          mostraWidgetPorUmTempo(context: context, widget: vsText());
          inicio = false;
        }
      });
    });

    Carta cartaDaVez =
        Carta(1, "Hidrogênio", 0.0008988, 38, -259.14, 1312.0, 2.2, 7);

    List<Carta> cartas = [
      Carta(1, "Hidrogênio", 0.0008988, 38, -259.14, 1312.0, 2.2, 7000),
      Carta(2, "Hélio", 0.0001786, 32, -272.2, 2372.3, 0, 0),
      Carta(3, "Lítio", 0.535, 134, 180.54, 520.2, 0.98, 0.007),
      Carta(6, "Carbono", 2.46, 77, 4440, 1086.5, 2.55, 16000),
      Carta(7, "Nitrogênio", 0.001251, 75, -210.00, 1402.3, 3.04, 1800),
      Carta(8, "Oxigênio", 0.001429, 73, -218.79, 1313.9, 3.44, 43000),
      Carta(9, "Flúor", 0.0017, 71, -219.62, 1681.0, 3.98, 2.6),
      Carta(11, "Sódio", 0.968, 154, 97.72, 495.8, 0.93, 100),
      Carta(12, "Magnésio", 1.738, 130, 650, 737.7, 1.31, 19),
      Carta(13, "Alumínio", 2.7, 118, 660.32, 577.5, 1.61, 0.060),
      Carta(14, "Silício", 2.33, 111, 1414, 786.5, 1.90, 1),
      Carta(15, "Fósforo", 1.823, 106, 44.15, 1011.8, 2.19, 780),
      Carta(16, "Enxofre", 2.08, 102, 95.3, 999.6, 2.58, 140),
      Carta(17, "Cloro", 0.0032, 99, -101.5, 1251.2, 3.16, 95),
      Carta(18, "Argônio", 0.001784, 97, -189.35, 1520.6, 0, 0),
      Carta(19, "Potássio", 0.856, 196, 63.38, 418.8, 0.82, 140),
      Carta(20, "Cálcio", 1.55, 174, 842, 589.8, 1.00, 1000),
      Carta(24, "Crômio (Cromo)", 7.15, 127, 1907, 652.9, 1.66, 0.014),
      Carta(26, "Ferro", 7.874, 125, 1538, 762.5, 1.83, 4.2),
      Carta(29, "Cobre", 8.92, 138, 1084.62, 745.5, 1.90, 0.072),
      Carta(30, "Zinco", 7.14, 131, 419.53, 906.4, 1.65, 2.3),
      Carta(33, "Arsênio", 5.727, 119, 817, 947.0, 2.18, 0.007),
      Carta(47, "Prata", 10.49, 153, 961.78, 731.0, 1.93, 0.002),
      Carta(50, "Estanho", 7.31, 141, 231.93, 708.6, 1.96, 0.02),
      Carta(53, "Iodo", 4.94, 133, 113.7, 1008.4, 2.66, 0.02),
      Carta(55, "Césio", 1.879, 225, 28.44, 375.7, 0.79, 0.006),
      Carta(57, "Lantânio", 6.146, 169, 920, 538.1, 1.10, 0.0008),
      Carta(78, "Platina", 21.09, 128, 1768.3, 870, 2.28, 0),
      Carta(79, "Ouro", 19.30, 144, 1064.18, 890.1, 2.54, 0.0002),
      Carta(80, "Mercúrio", 13.534, 149, -38.83, 1007.1, 2.00, 0.006),
      Carta(82, "Chumbo", 11.34, 147, 327.46, 715.6, 2.33, 0.12),
      Carta(92, "Urânio", 19.05, 118, 1132.2, 597.6, 1.38, 0.0001)
    ];

    return new Scaffold(
        appBar: AppBar(
            title: Center(
                child:
                    Text('${jogador1} ${p1Score} x ${p2Score} ${jogador2}'))),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height - 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Background.png'),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken))),
              child: Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: AnimatedAlign(
                    alignment: p2AnimateAlignment(p2AnimateState),
                    duration: Duration(seconds: 1),
                    child: AnimatedContainer(
                        width: animateWidth(p2AnimateState),
                        height: animateHeight(p2AnimateState),
                        duration: Duration(seconds: 1),
                        child: FlipCard(
                          key: cardKey,
                          flipOnTouch: false,
                          direction: FlipDirection.HORIZONTAL,
                          front: Container(
                              decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(5),
                          )),
                          back: cartaDaVez,
                        )),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: AnimatedAlign(
                        alignment: p1AnimateAlignment(p1AnimateState),
                        duration: Duration(seconds: 1),
                        child: AnimatedContainer(
                            width: animateWidth(p1AnimateState),
                            height: animateHeight(p1AnimateState),
                            duration: Duration(seconds: 1),
                            child: FlipCard(
                                key: cardKey1,
                                flipOnTouch: false,
                                direction: FlipDirection.HORIZONTAL,
                                front: TextButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(0))),
                                    child: Container(
                                        decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    onPressed: () {
                                      setState(() {
                                        p1AnimateState =
                                            p1UpdateState(p1AnimateState);
                                        p2AnimateState = p2UpdateState(
                                            p2AnimateState, p1AnimateState);
                                        switch (p1AnimateState) {
                                          case "showCards":
                                            cardKey.currentState.toggleCard();
                                            cardKey1.currentState.toggleCard();
                                            break;
                                          case "deck":
                                            cardKey.currentState.toggleCard();
                                            break;
                                          case "draw":
                                            cardKey1.currentState.toggleCard();
                                            break;
                                          default:
                                            false;
                                        }
                                      });
                                    }),
                                back: FittedBox(
                                  fit: BoxFit.fill,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(0))),
                                      child: cartaDaVez,
                                      onPressed: () {
                                        setState(() {
                                          p1AnimateState =
                                              p1UpdateState(p1AnimateState);
                                          p2AnimateState = p2UpdateState(
                                              p2AnimateState, p1AnimateState);
                                          switch (p1AnimateState) {
                                            case "showCards":
                                              cardKey.currentState.toggleCard();

                                              break;
                                            case "deck":
                                              cardKey.currentState.toggleCard();
                                              cardKey1.currentState
                                                  .toggleCard();
                                              break;
                                            case "draw":
                                              cardKey1.currentState
                                                  .toggleCard();
                                              break;
                                            default:
                                              false;
                                          }
                                        });
                                      }),
                                ))))),
                gameFinish ? resultado(gameWin, context) : Container(),
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
              '${_TestePhaseState.jogador1}   ', //${this.nome} ?
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
              '   ${_TestePhaseState.jogador2}', //${this.nome} ?
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
