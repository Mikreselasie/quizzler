import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quizzler/question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBrain questionBrain = QuestionBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: StartPage(),
          ),
        ),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.quiz, size: 100, color: Colors.white),
              SizedBox(height: 30),
              Text(
                'Welcome to Quizzler!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Test your general knowledge by answering 10 true or false questions.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                icon: Icon(Icons.play_arrow),
                label: Text('Start Quiz', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int result = 0;
  List<Icon> scoreKeeper = [];

  void generateScoreKeeper(bool btnAns, bool answer) {
    if (btnAns == answer) {
      scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      result++;
    } else {
      scoreKeeper.add(Icon(Icons.close, color: Colors.red));
    }
  }

  void restartQuiz() {
    questionBrain.reset(); // regenerate questions
    setState(() {
      result = 0;
      scoreKeeper = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questionBrain.getQuestionNo() >= 10) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onAppOver(context, result, restartQuiz);
      });
      return Container();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 25.0,
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ),
        // True Button
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'OpenSans',
                ),
              ),
              onPressed: () {
                setState(() {
                  generateScoreKeeper(true, questionBrain.getQuestionAnswer());
                  questionBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        // False Button
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'OpenSans',
                ),
              ),
              onPressed: () {
                setState(() {
                  generateScoreKeeper(false, questionBrain.getQuestionAnswer());
                  questionBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        // Score Keeper
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}

_onAppOver(BuildContext context, int result, VoidCallback onRestart) {
  Alert(
    context: context,
    type: AlertType.none, // Disable default type icon
    title: "Game Over",
    content: Column(
      children: [
        result >= 5
            ? Icon(Icons.emoji_emotions, color: Colors.green, size: 100)
            : Icon(Icons.sentiment_dissatisfied, color: Colors.red, size: 100),
        SizedBox(height: 10),
        Text(
          "You scored $result out of 10",
          style: TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    style: AlertStyle(
      backgroundColor: Colors.grey.shade900,
      titleStyle: TextStyle(color: Colors.white),
    ),
    buttons: [
      DialogButton(
        child: Text("Replay", style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.pop(context);
          onRestart(); // your restart function
        },
        color: Colors.blue,
      ),
      DialogButton(
        child: Text("Quit", style: TextStyle(color: Colors.white)),
        onPressed: () => exit(0),
        color: Colors.red,
      ),
    ],
  ).show();
}
