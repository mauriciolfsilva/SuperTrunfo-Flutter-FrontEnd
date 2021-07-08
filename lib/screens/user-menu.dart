import 'package:flutter/material.dart';

class UserMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Menu'),
      ),
      body: Center(
        child: Text('Pagina do usuario escolher criar ou entrar em uma sala'),
      ),
    );
  }
}
