import 'package:flutter/material.dart';

void main() {
  runApp(MyCalculatorApp());
}

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              input,
              style: TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              result,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          CalculatorButtons(
            onButtonPressed: (buttonText) {
              setState(() {
                if (buttonText == '=') {
                  try {
                    result = _evaluateExpression();
                  } catch (e) {
                    result = 'Error';
                  }
                  input = '';
                } else if (buttonText == 'C') {
                  input = '';
                  result = '';
                } else {
                  input += buttonText;
                }
              });
            },
          ),
        ],
      ),
    );
  }





String _evaluateExpression() {
  try {
    var result = _calculateExpression(input);
    return result.toString();
  } catch (e) {
    return 'Error';
  }
}

double _calculateExpression(String expression) {
  // Split the expression into numbers and operators
  final parts = expression.split(RegExp(r'(\+|-|\*|/)'));

  // Extract operators
  final operators = expression.replaceAll(RegExp(r'[^-+*/]'), '');

  // Initialize result with the first number
  var result = double.parse(parts[0]);

  // Perform calculations based on operators
  for (var i = 0; i < operators.length; i++) {
    final nextNumber = double.parse(parts[i + 1]);
    final operator = operators[i];

    switch (operator) {
      case '+':
        result += nextNumber;
        break;
      case '-':
        result -= nextNumber;
        break;
      case '*':
        result *= nextNumber;
        break;
      case '/':
        result /= nextNumber;
        break;
    }
  }

  return result;
}

}
class CalculatorButtons extends StatelessWidget {
  final Function(String) onButtonPressed;

  CalculatorButtons({required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('7'),
            _buildButton('8'),
            _buildButton('9'),
            _buildButton('/'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('4'),
            _buildButton('5'),
            _buildButton('6'),
            _buildButton('*'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('1'),
            _buildButton('2'),
            _buildButton('3'),
            _buildButton('-'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('C'),
            _buildButton('0'),
            _buildButton('='),
            _buildButton('+'),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {
        onButtonPressed(buttonText);
      },
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
