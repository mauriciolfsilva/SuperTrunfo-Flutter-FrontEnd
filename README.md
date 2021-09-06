# Super Trunfo

## Resumo

O aplicativo Super Trunfo UFF é um app programado em dart usando o framework flutter com um banco de dados firebase firestore, a ideia por trás do aplicativo é um jogo no modelo de super trunfo com o tema de elementos químicos.

## Regras

O jogo é dividido em turnos e em cada turno apenas 1 dos jogadores joga e o outro observa as animações mas depende da sorte, vence o jogo o jogador que obter, primeiro, 7 vitórias em 7 turnos diferentes.

- Quem começa jogando?
O primeiro jogador a entrar na sala será o jogador que escolherá o atributo no primeiro turno.

- Quando o jogo termina?
Assim que um dos jogadores obter 7 pontos.

- Quando um atributo de um elemento ganha de outro?
Quando um atributo de um elemento for maior do que o outro.

## Tecnologia
	
O código do app foi escrito em dart com o framework flutter, usamos os widgets do flutter para programar todas as animações e comportamentos do jogo, também usamos o FlutterFire para manter a conexão do nosso app com o firebase firestore, para manter a fluidez do jogo e a comunicação entre os 2 jogadores que estão na partida utilizamos do recurso de listener do FlutterFire onde uma função que é executada assim que jogo carrega para os 2 jogadores é chamada e a cada alteração no banco de dados mais especificamente no documento que carrega o id da partida no banco de dados é alterado esse listener captura os dados do banco e altera o jogo para os 2 jogadores.

## Instalação
........

## Equipe IC/UFF

- [Mauricio Leonardo Fernandes Da Silva](https://github.com/mauriciolfsilva)
- [Matheus Ribeiro Aragão](https://github.com/MatheusAragao1) 
- [Henrique De Morais Porto](https://github.com/henriporto)
- [Victor Faria Fernandes](https://github.com/) 
- [João Pedro López da Cruz](https://github.com/JoaoLopez)
- [Pedro Cassa Dias](https://github.com/pedrocassa)
