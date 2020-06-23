import 'package:flutter/material.dart';
import 'dart:math';

class Dice extends StatefulWidget {
  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int leftDiceNumber;
  int rightDiceNumber;

  @override
  void initState() {
    super.initState();
    leftDiceNumber = 1;
    rightDiceNumber = 1;
  }

  void diceChange() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  void cheat() {
    print('inside cheat');
    //TODO : 1 - add modalBottomSheet here with input for the cheat number
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tricky Dice!'),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.deepOrangeAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Image.asset('assets/images/dice$leftDiceNumber.png'),
                  onPressed: diceChange,
                  onLongPress: cheat,
                  padding: EdgeInsets.all(0),
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Image.asset('assets/images/dice$rightDiceNumber.png'),
                  onPressed: diceChange,
                  onLongPress: cheat,
                  padding: EdgeInsets.all(0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
