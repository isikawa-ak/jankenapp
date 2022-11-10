import 'dart:ffi';
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
  int waveCount = 1;
  int win = 0;
  int lose = 0;
  int draw = 0;
  bool gameEnd = false;
  String gameResult = 'No Contest';
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
      draw++;
      setState(() {});
    } else if (myHand == '✊' && computerHand == '✌' ||
        myHand == '✌' && computerHand == '✋' ||
        myHand == '✋' && computerHand == '✊') {
      result = '勝ち';
      win++;
      setState(() {});
    } else if (myHand == '✊' && computerHand == '✋' ||
        myHand == '✌' && computerHand == '✊' ||
        myHand == '✋' && computerHand == '✌') {
      result = '負け';
      lose++;
      setState(() {});
    } else {
      result = '引き分け';
      setState(() {});
    }
  }

  void waveCountToAdd() {
    waveCount++;
    if (waveCount >= 6) {
      gameEnd = !gameEnd;
      waveResult();
    }
  }

  void waveResult() {
    if (win > lose) {
      gameResult = 'You Win!';
      setState(() {});
    } else if (lose > win) {
      gameResult = 'You Lose...';
      setState(() {});
    } else {
      gameResult = 'No Contest';
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
        child: Stack(
          children: [
            Visibility(
              visible: gameEnd,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      win.toString() +
                          '勝' +
                          lose.toString() +
                          '敗' +
                          draw.toString() +
                          '引き分け',
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      gameResult,
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: 48),
                    ElevatedButton(
                        onPressed: () {
                          waveCount = 1;
                          win = 0;
                          lose = 0;
                          draw = 0;
                          gameEnd = !gameEnd;
                          setState(() {});
                        },
                        child: Text('もう一度やる')),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !gameEnd,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '現在' + waveCount.toString() + '試合目',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  // 余白を追加
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        win.toString() + '勝',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        lose.toString() + '敗',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        draw.toString() + '引き分け',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    result,
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  // 余白を追加
                  SizedBox(height: 32),
                  Text(
                    computerHand,
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  // 余白を追加
                  SizedBox(height: 32),
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
                            waveCountToAdd();
                          },
                          child: Text('✊')),
                      ElevatedButton(
                          onPressed: () {
                            selectHand('✌');
                            generateComputerHand();
                            resultToPrint();
                            waveCountToAdd();
                          },
                          child: Text('✌')),
                      ElevatedButton(
                          onPressed: () {
                            selectHand('✋');
                            generateComputerHand();
                            resultToPrint();
                            waveCountToAdd();
                          },
                          child: Text('✋')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
