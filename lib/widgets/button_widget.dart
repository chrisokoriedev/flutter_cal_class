import 'package:flutter/material.dart';

class AnimatedCalculatorButton extends StatefulWidget {
  final String text;
  final void Function(String) onPressed;

  const AnimatedCalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<AnimatedCalculatorButton> createState() =>
      _AnimatedCalculatorButtonState();
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
