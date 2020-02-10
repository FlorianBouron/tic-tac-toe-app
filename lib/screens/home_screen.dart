import 'package:flutter/material.dart';

import '../widgets/custom_dialog.dart';
import '../models/game_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GameButton> buttonsList = [
    GameButton(id: 1),
    GameButton(id: 2),
    GameButton(id: 3),
    GameButton(id: 4),
    GameButton(id: 5),
    GameButton(id: 6),
    GameButton(id: 7),
    GameButton(id: 8),
    GameButton(id: 9),
  ];
  List player1 = List();
  List player2 = List();
  int activePlayer = 1;

  void _handleButton(GameButton gameButton) {
    setState(() {
      if (activePlayer == 1) {
        gameButton.text = "X";
        gameButton.background = Colors.red;
        activePlayer = 2;
        player1.add(gameButton.id);
      } else {
        gameButton.text = "O";
        gameButton.background = Colors.black;
        activePlayer = 1;
        player2.add(gameButton.id);
      }
      gameButton.isClickable = false;
      _checkWinner();
    });
  }

  void _checkWinner() {
    var winner = -1;

    // Row 1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // Row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // Row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // Column 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // Column 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // Column 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    // Diagonals
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            "Player 1 won",
            "Press the reset button to start again",
            _resetGame,
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            "Player 2 won",
            "Press the reset button to start again",
            _resetGame,
          ),
        );
      }
    }
  }

  void _resetGame() {
    // Assure than dialogs are closed
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    setState(() {
      buttonsList = [
        GameButton(id: 1),
        GameButton(id: 2),
        GameButton(id: 3),
        GameButton(id: 4),
        GameButton(id: 5),
        GameButton(id: 6),
        GameButton(id: 7),
        GameButton(id: 8),
        GameButton(id: 9),
      ];
      player1 = List();
      player2 = List();
      activePlayer = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: buttonsList.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100,
                height: 100,
                child: RaisedButton(
                  padding: const EdgeInsets.all(8),
                  onPressed: buttonsList[i].isClickable
                      ? () => _handleButton(buttonsList[i])
                      : null,
                  child: Text(
                    buttonsList[i].text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  color: buttonsList[i].background,
                  disabledColor: buttonsList[i].background,
                ),
              ),
            ),
          ),
          RaisedButton(
            child: Text(
              "Reset",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            color: Colors.black,
            padding: const EdgeInsets.all(20),
            onPressed: _resetGame,
          ),
        ],
      ),
    );
  }
}
