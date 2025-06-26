import 'package:flutter/material.dart';

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
            child: QuizPage(),
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

int result = 0;

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  List<String> questions = [
    "The capital of Australia is Sydney.",
    "Lightning never strikes the same place twice.",
    "The human body has four lungs.",
    "Sharks are mammals.",
    "The Great Wall of China is visible from space.",
    "Bananas grow on trees.",
    "Sound travels faster in water than in air.",
    "Venus is the hottest planet in our solar system.",
    "Albert Einstein failed math in school.",
    "A group of crows is called a murder.",
  ];
  List<int> answers = [2, 2, 2, 2, 2, 2, 1, 1, 2, 1];
  int questionNo = 0;
  void generateAnswer(int btnNo, int answer) {
    if (btnNo == answer) {
      scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      result++;
    } else {
      scoreKeeper.add(Icon(Icons.close, color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                questions[questionNo],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ),
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
                  generateAnswer(1, answers[questionNo]);
                  questionNo++;
                  if (questionNo == 10) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultPage()),
                    );
                  }
                });
              },
            ),
          ),
        ),
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
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                setState(() {
                  generateAnswer(2, answers[questionNo]);
                  questionNo++;
                  if (questionNo == 10) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultPage()),
                    );
                  }
                });
              },
            ),
          ),
        ),

        //TODO: Add a Row here as your score keeper
        Row(children: scoreKeeper),
      ],
    );
  }
}

class ResultPage extends StatelessWidget {
  Widget goodOrBad() {
    if (result >= 5) {
      return Icon(Icons.emoji_emotions, color: Colors.green, size: 100);
    } else {
      return Icon(Icons.sentiment_dissatisfied, color: Colors.red, size: 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text('Quiz Result'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              goodOrBad(),
              SizedBox(height: 30),
              Text(
                'Your Score',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$result / 10',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: result >= 5 ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                icon: Icon(Icons.refresh),
                label: Text('Restart Quiz', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  result = 0; // Reset score
                  Navigator.pop(context); // Go back to QuizPage
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 15.0,
                  ),
                  backgroundColor: Colors.blue,
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
