import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'widgets/button_widget.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  CalculatorAppState createState() => CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {
  String equation = '';
  String result = '0';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '';
        result = '0';
      } else if (buttonText == '⌫') {
        if (equation.isNotEmpty) {
          equation = equation.substring(0, equation.length - 1);
        }
      } else if (buttonText == '=') {
        if (equation.isNotEmpty) {
          try {
            Parser p = Parser();
            Expression exp = p.parse(equation);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = 'Error';
          }
        }
      } else {
        equation += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.bottomRight,
            child: Text(
              equation,
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.bottomRight,
            child: Text(
              result,
              style:
                  const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedCalculatorButton(
                        text: '7', onPressed: buttonPressed),
                    AnimatedCalculatorButton(
                        text: '8', onPressed: buttonPressed),
                    AnimatedCalculatorButton(
                        text: '9', onPressed: buttonPressed),
                    AnimatedCalculatorButton(
                        text: '⌫', onPressed: buttonPressed),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedCalculatorButton(
                        text: '4', onPressed: buttonPressed),
                    AnimatedCalculatorButton(
                        text: '5', onPressed: buttonPressed),
                    AnimatedCalculatorButton(
                        text: '6', onPressed: buttonPressed),
                    AnimatedCalculatorButton(
                        text: '+', onPressed: buttonPressed,),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedCalculatorButton(
                      text: '1',
                      onPressed: buttonPressed,
                    ),
                    AnimatedCalculatorButton(
                        text: '2', onPressed: buttonPressed,),
                    AnimatedCalculatorButton(
                        text: '3', onPressed: buttonPressed),
                    AnimatedCalculatorButton(
                        text: '-', onPressed: buttonPressed),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedCalculatorButton(
                      text: '.',
                      onPressed: buttonPressed,
                    ),
                    AnimatedCalculatorButton(
                      text: '0',
                      onPressed: buttonPressed,
                    ),
                    AnimatedCalculatorButton(
                      text: 'C',
                      onPressed: buttonPressed,
                    ),
                    AnimatedCalculatorButton(
                      text: '*',
                      onPressed: buttonPressed,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedCalculatorButton(
                      text: '=',
                      onPressed: buttonPressed,
                    ),
                    AnimatedCalculatorButton(
                      text: '/',
                      onPressed: buttonPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

