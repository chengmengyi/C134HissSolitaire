import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Scaffold(body: AnimatedCardDemo())));
}

class AnimatedCardDemo extends StatefulWidget {
  const AnimatedCardDemo({super.key});

  @override
  State<AnimatedCardDemo> createState() => _AnimatedCardDemoState();
}

class _AnimatedCardDemoState extends State<AnimatedCardDemo> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;
  bool _isVisible = false; // 初始隐藏
  final Random _random = Random();

  void _startAnimation() {
    final size = MediaQuery.of(context).size;

    double startX = _random.nextBool() ? -100 : size.width + 100;
    double startY = _random.nextDouble() * (size.height - 100);

    double centerX = (size.width - 100) / 2;
    double centerY = (size.height - 100) / 2;

    double endX = _random.nextBool() ? -100 : size.width + 100;
    double endY = _random.nextDouble() * (size.height - 100);

    _controller?.dispose();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(startX, startY),
          end: Offset(centerX, centerY),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: ConstantTween<Offset>(Offset(centerX, centerY)),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(centerX, centerY),
          end: Offset(endX, endY),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
    ]).animate(_controller!);

    setState(() {
      _isVisible = true;
    });

    _controller!.forward().whenComplete(() {
      setState(() {
        _isVisible = false;
      });
    });
  }

  void _stopAnimation() {
    _controller?.stop();
    setState(() {
      _isVisible = false;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 点击按钮触发动画
        Positioned(
          bottom: 50,
          left: 50,
          child: ElevatedButton(
            onPressed: _startAnimation,
            child: const Text("开始动画"),
          ),
        ),
        if (_isVisible && _animation != null)
          AnimatedBuilder(
            animation: _animation!,
            builder: (context, child) {
              return Positioned(
                left: _animation!.value.dx,
                top: _animation!.value.dy,
                child: GestureDetector(
                  onTap: _stopAnimation,
                  child: child,
                ),
              );
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text(
                "点我",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
      ],
    );
  }
}