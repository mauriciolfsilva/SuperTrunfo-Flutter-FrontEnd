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
  _TestePhaseState createState() => _TestePhaseState();
}

class _TestePhaseState extends State<Game> {
  String animateState = 'deck';
  String jogador1, jogador2, jogadorDoTurno;
  bool realizarAcao = false;
  int cartaSorteada;
  var jogadorPrincipal, gameId;
  var cartasNoDeck = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  void passarTurno(String gameId) async {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(gameId).update({
      "jogadorTurno": jogador2,
    });
  }

  void removerCartas(DocumentSnapshot doc, String gameId) {
    var cartasRemovidas = doc.data()['cartasRemovidas'];
    var conjuntoDeck = Set.from(cartasNoDeck);
    var conjuntoRemovidas = Set.from(cartasRemovidas);

    cartasNoDeck = List.from(conjuntoDeck.difference(conjuntoRemovidas));
  }



  Future<void> listenerDoJogo() async {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(this.gameId).snapshots().listen((result) {
      removerCartas(result, this.gameId);
      jogadorDoTurno = result.data()['jogadorTurno'];

      print("JOGADOR DO TURNO ATUALIZADO: $jogadorDoTurno");
      print("LISTA DE CARTAS AUTORIZADAS: $cartasNoDeck");

      /*
      var idCartaTurnoJogadorTurno = result.data()['idCartaTurnoJogadorTurno'];
      var idCartaTurnoJogadorNaoTurno = result.data()['idCartaTurnoJogadorNaoTurno'];
      jogadorDoTurno = result.data()['jogadorTurno'];
      if (jogadorDoTurno == jogadorPrincipal &&
          idCartaTurnoJogadorTurno == null) {
        solicitarSaqueDeCarta();
      } else if (jogadorDoTurno == jogadorPrincipal &&
          idCartaTurnoJogadorTurno != null) {
        if (idCartaTurnoJogadorNaoTurno != null) {
          calcularPontuacaoRodada();
        } else {
          esperarJogadorNaoTurnoRetirarCarta();
        }
      } else if (jogadorDoTurno != jogadorPrincipal &&
          idCartaTurnoJogadorNaoTurno == null) {
        solicitarSaqueDeCartaNaoTurno();
      } else if (jogadorDoTurno != jogadorPrincipal &&
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

  void solicitarSaqueDeCarta(){
    // Escrever na tela para o jogador sacar a carta
  }

  void solicitarEscolhaDeAtributoDaCarta(){
    // Pedir para o jogador selecionar o atributo da rodada
  }
  
  bool jodadorPrincipalEJogadorDoTurno(){
    /*
    var db = FirebaseFirestore.instance;
    DocumentSnapshot foundedUser =
        await db.collection('partidas').doc(gameId).get();
    return foundedUser.data()['jogadorTurno'] == jogadorPrincipal
    */
    return jogadorPrincipal == jogadorDoTurno;
  }

  void inserirCartaJogadorBD(carta){
    var atributoBD = jodadorPrincipalEJogadorDoTurno() ?
                     "idCartaTurnoJogadorTurno" : "idCartaTurnoJogadorNaoTurno";
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(this.gameId).update({
      atributoBD: carta
    });
  }

  void atualizarCartasRemovidasBD(cartaRemovida){
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc(this.gameId).update({
      "cartasRemovidas":
          FieldValue.arrayUnion([cartaRemovida])
    });
  }

  ////OS TIPOS INT DESSA FUNÇÃO DEVEM SER FUTURAMENTE MODIFICADOS PARA Carta
  int sortearCarta(List<int> cartas){
    cartas.shuffle();
    return cartas[0];
  }

  //Essa função deve ser chamada quando o jogador
  //desejar selecionar uma nova carta do baralho
  void sacarCarta() {
    this.cartaSorteada = sortearCarta(this.cartasNoDeck);
    atualizarCartasRemovidasBD(this.cartaSorteada);
    inserirCartaJogadorBD(this.cartaSorteada);

    ////DEBUG
    print("CARTA SORTEADA: $this.cartaSorteada");
    ////
  }

  // Preencher no banco qual atributo escolhido pelo jogador do Turno
  

  void calcularPontuacaoRodada() {
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

  Future<List> getJogadoresBD() async {
    var db = FirebaseFirestore.instance;
    DocumentSnapshot partida = await db.collection('partidas').doc(this.gameId).get();
    var dados = partida.data();
    return [dados['jogador1'], dados['jogador2'], dados['jogadorTurno']];
  }

  Future<void> inicializarAtributos(context) async{
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    this.jogadorPrincipal = arguments['playerName'];
    this.gameId = arguments['gameId'];
    var jogadores = await getJogadoresBD();
    this.jogador1 = jogadores[0];
    this.jogador2 = jogadores[1];
    this.jogadorDoTurno = jogadores[2];
  }

  @override
  Widget build(BuildContext context) {
    inicializarAtributos(context);
    listenerDoJogo();

    Carta cartaDaVez = Carta(1, "Hélio", 0.0008988, 38, -259.14, 1312.0, 2.2, 7);
    
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
                          cartasNoDeck.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          sacarCarta();
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
