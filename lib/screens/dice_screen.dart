import 'package:flutter/material.dart';
import 'dart:math';

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

  void handleChange() {
    setState(() {
      print(leftDiceNumber);
      print(rightDiceNumber);
      isCheatActivated = true;
    });
  }

  void cheat(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            color: Colors.deepOrangeAccent,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onChanged: (value) {
                          cheatLeftNumber = int.parse(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onChanged: (value) {
                          cheatRightNumber = int.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    color: Colors.greenAccent,
                    onPressed: () {
                      Navigator.pop(context);
                      handleChange();
                    },
                    child: Text('Cheat'),
                  ),
                ),
              ],
            ),
          );
        });
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
              dieFace(leftDiceNumber),
              dieFace(rightDiceNumber),
            ],
          ),
        ],
      ),
    );
  }

  Expanded dieFace(int diceNumber) {
    return Expanded(
      child: FlatButton(
        child: Image.asset('assets/images/dice$diceNumber.png'),
        onPressed: diceChange,
        onLongPress: () => cheat(context),
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
