import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({super.key});
  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  String myHand = '✊';
  String computerHand = '✊';
  String result = '引き分け';
  void selectHand(String selectedHand) {
    myHand = selectedHand;
    print(myHand);
    setState(() {});
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(3);
    computerHand = randomNumberToHand(randomNumber);
  }

  void resultToPrint() {
    if (myHand == computerHand) {
      result = '引き分け';
      setState(() {});
    } else if (myHand == '✊' && computerHand == '✌' ||
        myHand == '✌' && computerHand == '✋' ||
        myHand == '✋' && computerHand == '✊') {
      result = '勝ち';
      setState(() {});
    } else if (myHand == '✊' && computerHand == '✋' ||
        myHand == '✌' && computerHand == '✊' ||
        myHand == '✋' && computerHand == '✌') {
      result = '負け';
      setState(() {});
    } else {
      result = '引き分け';
      setState(() {});
    }
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return '✊';
        break;
      case 1:
        return '✌';
        break;
      case 2:
        return '✋';
        break;
      default:
        return '✊';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ジャンケン'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            // 余白を追加
            SizedBox(height: 48),
            Text(
              computerHand,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            // 余白を追加
            SizedBox(height: 48),
            Text(
              myHand,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      selectHand('✊');
                      generateComputerHand();
                      resultToPrint();
                    },
                    child: Text('✊')),
                ElevatedButton(
                    onPressed: () {
                      selectHand('✌');
                      generateComputerHand();
                      resultToPrint();
                    },
                    child: Text('✌')),
                ElevatedButton(
                    onPressed: () {
                      selectHand('✋');
                      generateComputerHand();
                      resultToPrint();
                    },
                    child: Text('✋')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
