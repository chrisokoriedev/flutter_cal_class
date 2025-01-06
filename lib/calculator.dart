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
              style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
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
                    AnimatedCalculatorButton(text: '7', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '8', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '9', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '⌫', onPressed: buttonPressed),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedCalculatorButton(text: '4', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '5', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '6', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '+', onPressed: buttonPressed),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedCalculatorButton(text: '1', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '2', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '3', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '-', onPressed: buttonPressed),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedCalculatorButton(text: '.', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '0', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: 'C', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '*', onPressed: buttonPressed),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedCalculatorButton(text: '=', onPressed: buttonPressed),
                    AnimatedCalculatorButton(text: '/', onPressed: buttonPressed),
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

class AnimatedCalculatorButton extends StatefulWidget {
  final String text;
  final void Function(String) onPressed;

  const AnimatedCalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<AnimatedCalculatorButton> createState() => _AnimatedCalculatorButtonState();
}

class _AnimatedCalculatorButtonState extends State<AnimatedCalculatorButton> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _shadowAnimation = Tween<double>(
      begin: 15.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed(widget.text);
      },
      onTapCancel: () => _controller.reverse(),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Container(
          width: 70,
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(6, 0),
                blurRadius: _shadowAnimation.value,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
    );
  }
}