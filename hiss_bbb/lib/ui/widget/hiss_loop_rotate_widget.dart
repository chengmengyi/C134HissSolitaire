import 'package:flutter/material.dart';

class HissLoopRotateWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const HissLoopRotateWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<HissLoopRotateWidget> createState() => _LoopRotateState();
}

class _LoopRotateState extends State<HissLoopRotateWidget> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(); // 无限循环
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}
