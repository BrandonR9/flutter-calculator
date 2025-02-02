import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // For evaluating expressions

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = ''; // Stores the input expression
  String _result = ''; // Stores the calculated result

  // Function to handle button presses
  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final evalResult = evaluator.eval(expression, {});
          _result = '= $evalResult';
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Calculator Application')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Text(_expression, style: const TextStyle(fontSize: 50)),
                  
                  Text(_result, style: const TextStyle(fontSize: 58, fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
            ),
          ),
          _buildCalculatorButtons(),
        ],
      ),
    );
  }

  Widget _buildCalculatorButtons() {
    final buttons = [
      ['7', '8', '9', ' / '],
      ['4', '5', '6', ' * '],
      ['1', '2', '3', ' - '],
      ['C', '0', '=', ' + '],
    ];

    return Column(
      children: buttons.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((btnText) {
            return _buildButton(btnText);
          }).toList(),
        );
      }).toList(),
    );
  }

  Widget _buildButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 80,
        height: 80,
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: text == 'C' ? Colors.red : (text == '=' ? Colors.green : Colors.blue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(text, style: const TextStyle(fontSize: 28, color: Colors.white)),
        ),
      ),
    );
  }
}