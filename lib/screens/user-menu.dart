import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grupoazul20211/route/route.dart' as router;

class UserMenu extends StatelessWidget {
  Future<bool> anyGameWaitingToStart() async {
    var db = FirebaseFirestore.instance;
    var foundedGame =
        await db.collection('partidas').where('jogador2', isNull: true).get();
    if (foundedGame.docs.length > 0) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  void startNewGame(String playerName, BuildContext context) async {
    if (await anyGameWaitingToStart()) {
      //achar partida
      signInMatch(playerName, context);
    } else {
      //criar partida
      createNewGame(playerName, context);
    }
  }

  void waitingForPlayer(
      String playerName, String gameId, BuildContext context) {
    var db = FirebaseFirestore.instance;

    db.collection('partidas').doc(gameId).snapshots().listen((result) {
      if (result.data()['jogador2'] != null) {
        //irPara a partida
        sendToGame(context, gameId, playerName);
      }
    });
  }

  sendToGame(BuildContext context, String gameId, String playerName) {
    Navigator.pushReplacementNamed(context, router.gamePage,
        arguments: {'gameId': gameId, 'playerName': playerName});
  }

  void signInMatch(String playerName, BuildContext context) async {
    var db = FirebaseFirestore.instance;
    var foundedGame =
        await db.collection('partidas').where('jogador2', isNull: true).get();
    if (foundedGame.docs.length > 0) {
      var gameId = foundedGame.docs[0].id;

      db.collection('partidas').doc(gameId).update({
        "jogador2": playerName,
      });
      sendToGame(context, gameId, playerName);
    }
  }

  void createNewGame(String playerName, BuildContext context) async {
    var db = FirebaseFirestore.instance;
    db.collection('partidas').doc().set({
      "jogador1": playerName,
      "jogador2": null,
      "jogadorTurno": playerName,
      "idCartaTurnoJogadorTurno": null,
      "idCartaTurnoJogadorNaoTurno": null,
      "atributoTurno": null,
      "pontuacaoJogador1": 0,
      "pontuacaoJogador2": 0,
      "cartasRemovidas": [],
    });

    var gameIdQuery =
        await db.collection('partidas').where('jogador2', isNull: true).get();

    waitingForPlayer(playerName, gameIdQuery.docs[0].id, context);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;

    startNewGame(arguments['playerName'], context);

    CollectionReference reference =
        FirebaseFirestore.instance.collection('usuarios');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((docChange) {
        arguments['playerName'] = 'teste';
      });
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(arguments['playerName']),
          backgroundColor: Colors.orange,
        ),
        resizeToAvoidBottomInset: true,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Background.png'),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black45, BlendMode.darken))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  salasBoxesWidget(),
                  // salasBoxesWidget(),
                  // salasBoxesWidget(),
                ])));
  }
}

Widget buttonWidget(String texto) {
  return SizedBox(
      width: 150,
      child: ElevatedButton(
          child: Text(
            texto,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: "Calibri",
                fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.orange),
          onPressed: () {}));
}

Widget salasBoxesWidget() {
  return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(15),
      width: 370,
      height: 100,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          color: Colors.orange),
      child: Text("Buscando outros jogadores...",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: "Calibri",
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.justify));
}
