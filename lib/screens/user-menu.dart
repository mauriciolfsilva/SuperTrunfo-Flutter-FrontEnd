import 'package:flutter/material.dart';

class UserMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu de Salas'),
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
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            buttonWidget('Criar Sala'),
                            buttonWidget('Entrar'),
                          ])),
                  salasBoxesWidget(),
                  salasBoxesWidget(),
                  salasBoxesWidget(),
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
      child: Text("Aqui ficariam as informações de cada sala.",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: "Calibri",
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.justify));
}
