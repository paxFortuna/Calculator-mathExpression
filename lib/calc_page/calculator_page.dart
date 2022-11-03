import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:ui_calculator_refactor/calc_page/components/buttons.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _HomePageState();
}

class _HomePageState extends State<CalculatorPage> {
  var userQeustion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQeustion,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemCount: buttons.length,
              itemBuilder: (context, index) {

                // clear button : 0 -> button 'C'
                if (index == 0) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQeustion = '';
                        userAnswer = '';
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.green,
                    textColor: Colors.white,
                  );

                  // Delete Button: 1 -> button 'DEL'
                } else if (index == 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQeustion = userQeustion.substring(
                            0, userQeustion.length - 1);
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red,
                    textColor: Colors.white,
                  );

                  // Equal Button : '='
                } else if (index == buttons.length - 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                  );

                  // Rest of the buttons
                } else {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQeustion += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.deepPurple
                        : Colors.deepPurple[50],
                    textColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.deepPurple,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQeustion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    // (1) Parse expression:
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    // Bind variables and evaluate the expression as real number.
    // (2) Bind variables:
    ContextModel cm = ContextModel();
    // (3) Evaluate expression:
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
