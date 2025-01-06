import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  CalculatorAppState createState() => CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {
  String equation = '';
  String result = '';
  bool isButtonPressed = false;

  void isButtonPressedFunction() {
    setState(() {
      if (isButtonPressed == false) {
        isButtonPressed = true;
      } else if (isButtonPressed = true) {
        isButtonPressed = false;
      }
    });
  }

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '';
        result = '';
      } else if (buttonText == '⌫') {
        equation = equation.substring(0, equation.length - 1);
      } else if (buttonText == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(equation);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        equation += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('⌫'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('+'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('-'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildButton('.'),
                    buildButton('0'),
                    buildButton('C'),
                    buildButton('*'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('='),
                    buildButton('/'),
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

  Widget buildButton(String buttonText) {
    return InkWell(
      onTap: () {
        isButtonPressedFunction();
        buttonPressed(buttonText);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        onEnd: () {
          setState(() {
            isButtonPressed = false;
          });
        },
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: isButtonPressed ? 78 : 80,
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
            boxShadow: isButtonPressed
                ? []
                : [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(6, 6),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(-6, -6),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ]),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}
