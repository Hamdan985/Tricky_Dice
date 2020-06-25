import 'package:flutter/material.dart';
import 'dart:math';

class Dice extends StatefulWidget {
  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
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
      }
      else{
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
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: Colors.deepOrangeAccent,
              child: Center(
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
                    RaisedButton(
                      color: Colors.greenAccent,
                      onPressed: () {
                        Navigator.pop(context);
                        handleChange();
                      },
                      child: Text('Cheat'),
                    ),
                  ],
                ),
              ),
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
              Expanded(
                child: FlatButton(
                  child: Image.asset('assets/images/dice$leftDiceNumber.png'),
                  onPressed: diceChange,
                  onLongPress: () => cheat(context),
                  padding: EdgeInsets.all(0),
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Image.asset('assets/images/dice$rightDiceNumber.png'),
                  onPressed: diceChange,
                  onLongPress: () => cheat(context),
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
