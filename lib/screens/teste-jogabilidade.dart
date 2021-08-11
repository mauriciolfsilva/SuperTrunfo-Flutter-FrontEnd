import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grupoazul20211/route/route.dart' as router;
import 'package:grupoazul20211/screens/game.dart';

//classe que extende estados que serão usados para manipular as informações
//na tela.
class TestePhase extends StatefulWidget {
  @override
  _TestePhaseState createState() => _TestePhaseState();
}

class _TestePhaseState extends State<TestePhase> {
  String animateState = 'deck';

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
              child: AnimatedAlign(
                alignment: animateAlignment(animateState),
                duration: Duration(seconds: 1),
                child: AnimatedContainer(
                  width: animateWidth(animateState),
                  height: animateWidth(animateState),
                  duration: Duration(seconds: 1),
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.transparent),
                      child: cartaDaVez,
                      onPressed: () {
                        setState(() {
                          animateState =
                              animateState == 'draw' ? 'zoom' : 'draw';
                        });
                      }),
                ),
              )),
        ));
  }
}
