import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grupoazul20211/route/route.dart' as router;
import 'package:grupoazul20211/screens/game.dart';
import 'package:flip_card/flip_card.dart';

//classe que extende estados que serão usados para manipular as informações
//na tela.
class TestePhase extends StatefulWidget {
  @override
  _TestePhaseState createState() => _TestePhaseState();
}

class _TestePhaseState extends State<TestePhase> {
  String p1AnimateState = 'deck';
  String p2AnimateState = 'deck';

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  double animateWidth(String state) {
    if (state == 'zoom')
      return 315;
    else if (state == 'display')
      return 205;
    else if (state == 'showCards') return 205;
    return 150;
  }

  double animateHeight(String state) {
    if (state == 'zoom')
      return 400;
    else if (state == 'display')
      return 300;
    else if (state == 'showCards') return 300;
    return 150;
  }

  Alignment p1AnimateAlignment(String state) {
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

  String p1UpdateState(String state) {
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

  String p2UpdateState(String state, String p1State) {
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

  @override
  Widget build(BuildContext context) {
    Carta cartaDaVez =
        Carta(1, "Hélio", 0.0008988, 38, -259.14, 1312.0, 2.2, 7);
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
          child: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: AnimatedAlign(
                alignment: p2AnimateAlignment(p2AnimateState),
                duration: Duration(seconds: 1),
                child: AnimatedContainer(
                    width: animateWidth(p2AnimateState) - 10,
                    height: animateHeight(p2AnimateState) - 15,
                    margin: EdgeInsets.all(10),
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
                        back: Container(
                            decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        )))),
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
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                      style: TextButton.styleFrom(primary: Colors.transparent),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: cartaDaVez,
                      ),
                      onPressed: () {
                        setState(() {
                          p1AnimateState = p1UpdateState(p1AnimateState);
                          p2AnimateState =
                              p2UpdateState(p2AnimateState, p1AnimateState);
                          (p1AnimateState == "showCards")
                              ? cardKey.currentState.toggleCard()
                              : false;
                          (p1AnimateState == "deck")
                              ? cardKey.currentState.toggleCard()
                              : false;
                        });
                      }),
                ),
              ),
            )
          ]),
        )));
  }
}
