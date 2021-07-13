import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';
  var userAnswer = '';
  bool showAnswer = false;

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: 50),
                      Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userQuestion,
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userAnswer,
                          style: TextStyle(fontSize: showAnswer ? 40 : 20),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Buttons(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = '';
                              userAnswer = '';
                            });
                          },
                          buttonText: buttons[index],
                          color: Color(0xFF272727),
                          textColor: Colors.deepPurple[400],
                        );
                      } else if (index == 1) {
                        return Buttons(
                          buttonTapped: () {
                            if (userQuestion != '') {
                              setState(
                                () {
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1);
                                  equalPressed();
                                },
                              );
                            } else {
                              setState(
                                () {
                                  userQuestion = '';
                                  userAnswer = '';
                                },
                              );
                            }
                          },
                          buttonText: buttons[index],
                          color: Color(0xFF272727),
                          textColor: Colors.deepPurple[400],
                        );
                      } else if (index == buttons.length - 1) {
                        return Buttons(
                          buttonTapped: () {
                            setState(
                              () {
                                showAnswer = true;
                              },
                            );
                          },
                          buttonText: buttons[index],
                          color: Colors.deepPurple[400],
                          textColor: Colors.white,
                        );
                      } else
                        return Buttons(
                          buttonTapped: () {
                            setState(() {
                              userQuestion += buttons[index];
                              showAnswer = false;
                              if (!isOperator(buttons[index])) equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Color(0xFF272727),
                          textColor: isOperator(buttons[index])
                              ? Colors.deepPurple[400]
                              : Colors.white,
                        );
                    }),
              ))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    Parser p = Parser();
    Expression exp = p.parse(userQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
