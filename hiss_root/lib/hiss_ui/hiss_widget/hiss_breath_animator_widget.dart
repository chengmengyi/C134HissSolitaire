import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';

class HissBreathAnimatorWidget extends HissRootStateful{
  bool start;
  Widget child;
  Function(AnimationController controller)? controllerCallback;

  HissBreathAnimatorWidget({
    required this.start,
    required this.child,
    this.controllerCallback,
  });

  @override
  State<StatefulWidget> createState() => _HissBreathAnimatorWidgetState();
}

class _HissBreathAnimatorWidgetState extends HissRootStatefulState<HissBreathAnimatorWidget> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimator();
  }

  @override
  initContent() => AnimatedBuilder(
    animation: _animation,
    builder: (context, child) {
      return Transform.scale(
        scale: _animation.value,
        filterQuality: FilterQuality.high,
        child: child,
      );
    },
    child: widget.child,
  );


  _initAnimator(){
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(null!=widget.controllerCallback){
        widget.controllerCallback?.call(_controller);
        return;
      }
      if (widget.start) {
        _controller.reset();
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}