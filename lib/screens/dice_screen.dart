import 'package:flutter/material.dart';
import 'dart:math';
import 'package:numberpicker/numberpicker.dart';

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  bool isCheatActivated = false;
  int leftDiceNumber;
  int rightDiceNumber;

  int cheatLeftNumber;
  int cheatRightNumber;

  @override
  void initState() {
    super.initState();
    leftDiceNumber = 1;
    rightDiceNumber = 1;
  }

  void diceChange() {
    setState(() {
      if (!isCheatActivated) {
        leftDiceNumber = Random().nextInt(6) + 1;
        rightDiceNumber = Random().nextInt(6) + 1;
      } else {
        leftDiceNumber = cheatLeftNumber;
        rightDiceNumber = cheatRightNumber;
        isCheatActivated = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tricky Dice!'),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        elevation: 1.0,
      ),
      backgroundColor: Colors.deepOrangeAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              dieFace(leftDiceNumber, 'left'),
              dieFace(rightDiceNumber, 'right'),
            ],
          ),
        ],
      ),
    );
  }

  Expanded dieFace(int diceNumber, String position) {
    return Expanded(
      child: FlatButton(
        child: Image.asset('assets/images/dice$diceNumber.png'),
        onPressed: diceChange,
        padding: EdgeInsets.all(0),
        onLongPress: () => _cheatDialog(position),
      ),
    );
  }

  _cheatDialog(String position) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            title: Text("Pick $position number"),
            highlightSelectedValue: true,
            zeroPad: true,
            minValue: 1,
            maxValue: 6,
            initialIntegerValue: 1,
          );
        }).then((value) {
      if (value != null) {
        setState(() {
          if (position == 'left') {
            cheatLeftNumber = value;
          } else {
            cheatRightNumber = value;
          }

          print('left = $cheatLeftNumber');
          print('right = $cheatRightNumber');

          if (cheatLeftNumber != null && cheatRightNumber != null) {
            isCheatActivated = true;
            // diceChange();
          }
        });
      }
    });
  }
}
