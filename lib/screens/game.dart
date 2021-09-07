import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:show_up_animation/show_up_animation.dart';
import '../consts/Cards.dart' as CardsAtributtes;

/*
 * Descricao do modulo:
 * Carrega os métodos e dados necessários para a parte jogável do aplicativo.
 * Entre elas:
 *      Widgets visual para a carta e sua movimentação.
 *      Métodos para as funcionalidades da parte jogável.
 *
 * Github:
 * https://github.com/mauriciolfsilva/SuperTrunfo-Flutter-FrontEnd
 */


//Widget de resultado do jogo
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
                          SystemChannels.platform
                              .invokeMethod<void>('SystemNavigator.pop');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                        ),
                        child: Text(
                          'Sair do jogo',
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

//Widget de carta do jogo
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
                          color: _TestePhaseState.atributoTurno == "densidade"
                              ? Colors.yellow
                              : Colors.white,
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
                                            _TestePhaseState.jogadorTurno &&
                                        (_TestePhaseState.p1AnimateState ==
                                                "display" ||
                                            _TestePhaseState.p1AnimateState ==
                                                "zoom"))
                                      {
                                        _TestePhaseState.escolherAtributoTurno(
                                            "densidade"),
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
                          color: _TestePhaseState.atributoTurno == "raio"
                              ? Colors.yellow
                              : Colors.white,
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
                                            _TestePhaseState.jogadorTurno &&
                                        (_TestePhaseState.p1AnimateState ==
                                                "display" ||
                                            _TestePhaseState.p1AnimateState ==
                                                "zoom"))
                                      {
                                        _TestePhaseState.escolherAtributoTurno(
                                            "raio"),
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
                          color: _TestePhaseState.atributoTurno == "fusao"
                              ? Colors.yellow
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 30,
                          child: TextButton(
                              onPressed: () => {
                                    if (_TestePhaseState.jogadorPrincipal ==
                                            _TestePhaseState.jogadorTurno &&
                                        (_TestePhaseState.p1AnimateState ==
                                                "display" ||
                                            _TestePhaseState.p1AnimateState ==
                                                "zoom"))
                                      {
                                        _TestePhaseState.escolherAtributoTurno(
                                            "fusao"),
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
                          color: _TestePhaseState.atributoTurno == "energia"
                              ? Colors.yellow
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 30,
                          child: TextButton(
                              onPressed: () => {
                                    if (_TestePhaseState.jogadorPrincipal ==
                                            _TestePhaseState.jogadorTurno &&
                                        (_TestePhaseState.p1AnimateState ==
                                                "display" ||
                                            _TestePhaseState.p1AnimateState ==
                                                "zoom"))
                                      {
                                        _TestePhaseState.escolherAtributoTurno(
                                            "energia"),
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

//Classe que cria um estado com a classe principal, mantemos o nome de _TestePhaseState por familiaridade
//de todos os desenvolvedor do projeto.
class Game extends StatefulWidget {
  _TestePhaseState createState() => _TestePhaseState();
}

//classe principal do jogo
class _TestePhaseState extends State<Game> {
  // variavel "inicio" indica que acabamos de iniciar o jogo
  static bool inicio = true;

  static bool naoVirou = true;

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
  static String jogador1, jogador2, jogadorTurno = "inicio";
  static int pontuacaoJogador1, pontuacaoJogador2;
  static int idCartaTurnoJogadorTurno, idCartaTurnoJogadorNaoTurno;
  static var atributoTurno;
  static var cartasQueSairamDoDeck;
  static var jogadorPrincipal, gameId;
  static var timeoutTurno, timeoutSugestaoUsuario;
  static var sugestaoUsuario;
  static bool firstLoad = false;
  static String estadoAnimacaoDoAdversario;

  static Carta cartaDaVez;
  static Carta cartaDaVezAdversario;

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

  Alignment p2AnimateAlignment(String state) {
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

  //Metodo que atualiza o estado da animação do jogador que está jogando no turno no banco
  // com o objetivo do listener replicar essa informação para o segundo jogador
  void atualizarEstadoDaAnimacaoNoBanco(String estado) {
    var db = FirebaseFirestore.instance;
    if (jogadorPrincipal == jogadorTurno) {
      db
          .collection('partidas')
          .doc(gameId)
          .update({"estadoAnimacaoJogadorTurno": estado});
    }
  }

  // Atualiza as animações do jogador que não é o responsavel pelo turno, sendo um metodo somente disparado
  // pelo listener
  String p1UpdateStateNaoTurno(String state) {
    if (state == "draw") {
      state = "zoom";
    } else if (state == "zoom") {
      state = "display";
    } else if (state == "display") {
      state = "showCards";
    } else if (state == "deck") {
      sacarCarta();
      state = "draw";
    } else if (state == "showCards") {
      jogadorTurno = jogadorPrincipal;
      state = "deck";
    }
    return state;
  }

  // Atualiza as animações do jogador responsavel pelo turno sendo disparado por evento de click
  String p1UpdateState(String state) {
    if (state == "draw") {
      state = "zoom";
    } else if (state == "zoom" && atributoTurno != null) {
      state = "display";
    } else if (state == "display") {
      state = "showCards";
    } else if (state == "deck") {
      sacarCarta();
      state = "draw";
      atualizarEstadoDaAnimacaoNoBanco(state);
    } else if (state == "showCards" && atributoTurno != null) {
      //cartaDaVez = null;
      //cartaDaVezAdversario = null;
      state = "deck";
      //atualizarEstadoDaAnimacaoNoBanco(state);
      calcularPontuacaoRodada(state);
      jogadorTurno = 'teste';
      return state;
    }
    atualizarEstadoDaAnimacaoNoBanco(state);
    return state;
  }

  // Atualiza as animações da carta auxiliar na tela
  String p2UpdateState(String state, String p1State) {
    if (state == "deck" && p1State == "draw")
      return "draw";
    else if (state == "draw" && p1State == "zoom")
      return "draw";
    else if (state == "draw" && p1State == "display")
      return "display";
    else if (state == "display" && p1State == "showCards")
      return "showCards";
    else if (state == "showCards" && p1State == "deck")
      return "deck";
    else
      return state;
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

// verifica se o jogador principal ou seja o dono do celular é o jogador que está jogando no turno
  static bool jodadorPrincipalEJogadorTurno() {
    return jogadorPrincipal == jogadorTurno;
  }

// verifica se algum atributo foi escolhido nesse turno
  static bool atributoTurnoEscolhido() {
    return atributoTurno != null;
  }

// verifica se  o jogador dono do celular sacou alguma carta
  static bool jogadorPrincipalSacouCarta() {
    return cartaDaVez != null;
  }

// obtem uma string que auxilia o usuario em qual ação tomar
  static String getSugestaoUsuario() {
    if (!jogadorPrincipalSacouCarta())
      return "Saque uma carta!";
    else if (jodadorPrincipalEJogadorTurno() && !atributoTurnoEscolhido())
      return "Escolha o atributo da carta!";
    else
      return "Espere o outro jogador jogar!";
  }

// atualiza a string de sugestao do usuario e renderiza na tela
  void atualizarSugestaoUsuario() {
    String sugestaoUsuario = getSugestaoUsuario();
    setState(() => sugestaoUsuario = "Dica: $sugestaoUsuario");
  }

// inicia uma contagem de tempo maximo de ação que o usuario pode tomar
  static void iniciarTemporizadoresDoJogo() {
    timeoutTurno = Timer(Duration(seconds: 60), () {
      //this.timeoutSugestaoUsuario.cancel();
      print("USUÁRIO DESISTIU DO JOGO!");
    });
  }

// obtem o nome de usuario do jogador q está jogando no celular do adversario
  static String getNomeJogadorAdversario() {
    return jogador1 == jogadorPrincipal ? jogador2 : jogador1;
  }

// funcao desativada durante o desenvolvimento
  // void passarTurno() async {
  //   calcularPontuacaoRodada();
  //   var jogadorAdversario = getNomeJogadorAdversario();
  //   var db = FirebaseFirestore.instance;
  //   db.collection('partidas').doc(gameId).update({
  //     "idCartaTurnoJogadorNaoTurno": null,
  //     "idCartaTurnoJogadorTurno": null,
  //     "atributoTurno": null,
  //     //"jogadorTurno": jogadorAdversario,
  //     //"estadoAnimacaoJogadorTurno": "deck",
  //   });
  //   //cartaDaVez = null;
  // }

// atualiza o atributo escolhido no banco
  void atualizarAtributoTurno(dadosPartida) {
    setState(() {
      atributoTurno = dadosPartida['atributoTurno'];
    });
  }

// atualiza o jogador do turno
// OBS: Funcao desativada durante desenvolvimento
  void atualizarJogadorTurno(dadosPartida) {
    // setState(() {
    //   // por algum motivo o jogadorTurno não está sendo refletido na variavel
    //   //jogadorTurno = dadosPartida['jogadorTurno'];
    // });
  }

  // Atualiza a pontuacao dos 2 jogadores
  static void atualizarPontuacaoJogadores(dadosPartida) {
    pontuacaoJogador1 = dadosPartida['pontuacaoJogador1'];
    pontuacaoJogador2 = dadosPartida['pontuacaoJogador2'];
  }

//Instancia uma nova carta
  static Carta atribuirCarta(int idCarta) {
    int id = CardsAtributtes.properties[idCarta]['id'];
    String nome = CardsAtributtes.properties[idCarta]['nome'];
    double densidade = CardsAtributtes.properties[idCarta]['densidade'];
    double raio = CardsAtributtes.properties[idCarta]['raio'];
    double fusao = CardsAtributtes.properties[idCarta]['fusao'];
    double energia = CardsAtributtes.properties[idCarta]['energia'];
    double negatividade = CardsAtributtes.properties[idCarta]['negatividade'];

    return new Carta(
        id, nome, densidade, raio, fusao, energia, negatividade, 0.0);
  }

  // atualiza no banco os ids de cada carta dos jogadores
  void atualizarIdsCartasTurnoJogadores(dadosPartida) {
    idCartaTurnoJogadorTurno = dadosPartida['idCartaTurnoJogadorTurno'];
    idCartaTurnoJogadorNaoTurno = dadosPartida['idCartaTurnoJogadorNaoTurno'];
    setState(() {
      if (jogadorPrincipal == jogadorTurno && cartaDaVez != null) {
        cartaDaVezAdversario = atribuirCarta(idCartaTurnoJogadorNaoTurno);
      } else if (jogadorPrincipal != jogadorTurno && cartaDaVez != null) {
        cartaDaVezAdversario = atribuirCarta(idCartaTurnoJogadorTurno);
      }
    });
  }

// remove todas as cartas que ja foram jogadas do deck dos jogadores
  static void atualizarCartasNoDeck(dadosDaPartida) {
    var cartasRemovidas = dadosDaPartida['cartasRemovidas'];
    cartasQueSairamDoDeck = cartasRemovidas;
  }

  // disparada pelo listener esse funcao atualiza os estados compartilhados entre os 2 jogadores
  void atualizarAtributos(DocumentSnapshot partida) {
    var dadosPartida = partida.data();
    atualizarCartasNoDeck(dadosPartida);
    atualizarIdsCartasTurnoJogadores(dadosPartida);
    atualizarPontuacaoJogadores(dadosPartida);
    atualizarJogadorTurno(dadosPartida);
    atualizarAtributoTurno(dadosPartida);
  }

// verifica se a partida ja foi finalizada e informa se o jogador venceu ou perdeu
  void verificarSePartidaFinalizada(DocumentSnapshot partida) {
    var dadosPartida = partida.data();
    p1Score = dadosPartida['pontuacaoJogador1'];
    p2Score = dadosPartida['pontuacaoJogador2'];

    var jogadorCel = jogadorPrincipal == jogador1;

    if ((p1Score >= 7 && jogadorCel) || (p2Score >= 7 && !jogadorCel)) {
      setState(() {
        gameFinish = true;
        gameWin = true;
      });
    } else if ((p1Score >= 7 && !jogadorCel) || (p2Score >= 7 && jogadorCel)) {
      setState(() {
        gameFinish = true;
        gameWin = false;
      });
    }
  }

// movimenta as animacoes do jogador que não é o responsavel pelo turno
  void movimentarJogadorNaoTurno(DocumentSnapshot partida) {
    var dadosPartida = partida.data();
    var ultimoEstagio = dadosPartida['estadoAnimacaoJogadorTurno'];
    if (jogadorPrincipal != jogadorTurno && p1AnimateState != ultimoEstagio) {
      setState(() {
        p1AnimateState = p1UpdateStateNaoTurno(p1AnimateState);
        p2AnimateState = p2UpdateState(p2AnimateState, p1AnimateState);

        switch (p1AnimateState) {
          case "showCards":
            if (naoVirou) {
              cardKey.currentState.toggleCard();
              naoVirou = false;
            }
            break;
          case "deck":
            cardKey.currentState.toggleCard();
            cardKey1.currentState.toggleCard();
            naoVirou = true;
            break;
          case "draw":
            cardKey1.currentState.toggleCard();
            break;
          default:
            "deck";
        }
      });
    }
  }

// funcao principal do multiplayer, ouve a sala de partida no banco de dados e dispara automaticamente
// sempre que acontece alguma mudança no banco de dados, atualizando os estados no celular dos 2 jogadores
  Future<void> listenerDoJogo() async {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(gameId).snapshots().listen((result) {
      atualizarAtributos(result);
      atualizarSugestaoUsuario();
      verificarSePartidaFinalizada(result);
      movimentarJogadorNaoTurno(result);
    });
  }

  // atualiza a carta sacado no banco
  static void inserirCartaJogadorBD(carta) {
    var atributoBD = jodadorPrincipalEJogadorTurno()
        ? "idCartaTurnoJogadorTurno"
        : "idCartaTurnoJogadorNaoTurno";
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(gameId).update({atributoBD: carta});
  }

  // atualiza a lista de cartas removidas no banco
  static void atualizarCartasRemovidasBD(cartaRemovida) {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(gameId).update({
      "cartasRemovidas": FieldValue.arrayUnion([cartaRemovida])
    });
  }

  // sorteia uma carta aleatoria para o jogador usar no turno
  static sortearCarta(dynamic cartas) {
    var conjuntoRemovidas = Set.from(cartasQueSairamDoDeck);
    var conjuntoDeck = Set.from(cartas.keys.toList());
    var cards = List.from(conjuntoDeck.difference(conjuntoRemovidas));
    cards.shuffle();
    return cards[0];
  }

  //Essa função deve ser chamada quando o jogador
  //desejar selecionar uma nova carta do baralho
  void sacarCarta() {
    var cartaSorteadaNum = sortearCarta(CardsAtributtes.properties);
    print(cartaSorteadaNum);
    int id = CardsAtributtes.properties[cartaSorteadaNum]['id'];
    String nome = CardsAtributtes.properties[cartaSorteadaNum]['nome'];
    double densidade =
        CardsAtributtes.properties[cartaSorteadaNum]['densidade'];
    double raio = CardsAtributtes.properties[cartaSorteadaNum]['raio'];
    double fusao = CardsAtributtes.properties[cartaSorteadaNum]['fusao'];
    double energia = CardsAtributtes.properties[cartaSorteadaNum]['energia'];
    double negatividade =
        CardsAtributtes.properties[cartaSorteadaNum]['negatividade'];

    cartaDaVez =
        new Carta(id, nome, densidade, raio, fusao, energia, negatividade, 0.0);

    atualizarCartasRemovidasBD(cartaSorteadaNum);
    inserirCartaJogadorBD(cartaSorteadaNum);
  }

  // atualiza no banco de dados o atributo escolhido no turno
  static void escolherAtributoTurno(atributo) {
    if (jogadorPrincipal == jogadorTurno) {
      var db = FirebaseFirestore.instance;
      db.collection('partidas').doc(gameId).update({"atributoTurno": atributo});
    }
  }

  // calcula quem venceu a rodada baseado nos atributos das cartas
  static void calcularPontuacaoRodada(String state) {
    if (jogadorPrincipal == jogadorTurno) {
      var cartaJogadorPrincipal =
          CardsAtributtes.properties[idCartaTurnoJogadorTurno];
      var cartaJogadorAdversario =
          CardsAtributtes.properties[idCartaTurnoJogadorNaoTurno];

      var principalVencedor = cartaJogadorPrincipal[atributoTurno] >
          cartaJogadorAdversario[atributoTurno];
      var updateQuery;

      if (jogadorPrincipal == jogador1 && principalVencedor) {
        updateQuery = {
          "pontuacaoJogador1": FieldValue.increment(1),
          "estadoAnimacaoJogadorTurno": state
        };
      } else if (jogadorPrincipal == jogador2 && principalVencedor) {
        updateQuery = {
          "pontuacaoJogador2": FieldValue.increment(1),
          "estadoAnimacaoJogadorTurno": state
        };
      } else if (jogadorPrincipal == jogador1 && !principalVencedor) {
        updateQuery = {
          "pontuacaoJogador2": FieldValue.increment(1),
          "estadoAnimacaoJogadorTurno": state
        };
      } else if (jogadorPrincipal == jogador2 && !principalVencedor) {
        updateQuery = {
          "pontuacaoJogador1": FieldValue.increment(1),
          "estadoAnimacaoJogadorTurno": state
        };
      }

      var db = FirebaseFirestore.instance;
      db.collection('partidas').doc(gameId).update(updateQuery);
    }
    // calcular baseado nos 2 ids de cartas escolhidas no banco e pelo atributo escolhido quem venceu a rodada,
    // somar ponto no banco para o jogador que venceu e zerar demais atributos de jogo no banco, como ids e atributo escolhido.
    // passar a vez para o proximo jogador
  }

  // obtem os nomes de usuarios dos jogadores
  Future<List> getJogadoresBD() async {
    var db = FirebaseFirestore.instance;
    DocumentSnapshot partida =
        await db.collection('partidas').doc(gameId).get();
    var dados = partida.data();
    return [dados['jogador1'], dados['jogador2'], dados['jogadorTurno']];
  }

  // inicializa os estados com os valores do banco e dos arguments enviados pela tela anterior
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
      //iniciarTemporizadoresDoJogo();
      firstLoad = true;
    }
    Timer(Duration(seconds: 1), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (inicio) {
          //mostraWidgetPorUmTempo(context: context, widget: vsText());
          inicio = false;
        }
      });
    });

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
                          back: cartaDaVezAdversario,
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
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    onPressed: () {
                                      setState(() {
                                        if (jogadorPrincipal == jogadorTurno) {
                                          p1AnimateState =
                                              p1UpdateState(p1AnimateState);
                                          p2AnimateState = p2UpdateState(
                                              p2AnimateState, p1AnimateState);

                                          switch (p1AnimateState) {
                                            case "showCards":
                                              if (naoVirou) {
                                                cardKey.currentState
                                                    .toggleCard();
                                                cardKey1.currentState
                                                    .toggleCard();
                                                naoVirou = false;
                                              }
                                              break;
                                            case "deck":
                                              cardKey.currentState.toggleCard();
                                              naoVirou = true;
                                              break;
                                            case "draw":
                                              cardKey1.currentState
                                                  .toggleCard();
                                              break;
                                            default:
                                              "deck";
                                          }
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
                                          if (jogadorPrincipal ==
                                              jogadorTurno) {
                                            p1AnimateState =
                                                p1UpdateState(p1AnimateState);
                                            p2AnimateState = p2UpdateState(
                                                p2AnimateState, p1AnimateState);
                                            switch (p1AnimateState) {
                                              case "showCards":
                                                if (naoVirou) {
                                                  cardKey.currentState
                                                      .toggleCard();
                                                  naoVirou = false;
                                                }
                                                break;
                                              case "deck":
                                                cardKey.currentState
                                                    .toggleCard();
                                                cardKey1.currentState
                                                    .toggleCard();
                                                naoVirou = true;
                                                break;
                                              case "draw":
                                                cardKey1.currentState
                                                    .toggleCard();
                                                break;
                                              default:
                                                "deck";
                                            }
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
