import 'package:flutter/material.dart';

class CustomAnimatedScale extends StatefulWidget {
  const CustomAnimatedScale({
    super.key,
    required this.onTap,
    required this.child,
  });

  final VoidCallback onTap;
  final Widget child;
  @override
  State<CustomAnimatedScale> createState() => _CustomAnimatedScale();
}

class _CustomAnimatedScale extends State<CustomAnimatedScale>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 230),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tapDown(TapDownDetails details) async {
    await _controller.forward();
    // _controller.isCompleted ? _controller.reverse() : null;
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      // behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTapCancel: () => _controller.reverse(from: _controller.value),
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
