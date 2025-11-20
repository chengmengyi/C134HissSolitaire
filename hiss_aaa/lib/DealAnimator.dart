import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hiss_aaa/test.dart';

class DealAnimator {
  final TickerProvider vsync;
  final GlobalKey stockKey;

  // 动画控制器
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  // 需要发的牌
  List<CardModel> _cards = [];

  // 牌的位置计算：外部提供函数
  late double Function(int index) targetX;
  late double Function(int index) targetY;

  bool _isPrepared = false;

  DealAnimator({
    required this.vsync,
    required this.stockKey,
  });

  Offset _getStockPosition() {
    final render = stockKey.currentContext?.findRenderObject() as RenderBox?;
    if (render == null) return Offset.zero;
    return render.localToGlobal(Offset.zero);
  }

  /// 初始化 28 张发牌动画（7 列结构）
  void prepare(List<CardModel> cards) {
    _cards = cards;

    _controllers = List.generate(
      cards.length,
          (_) => AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 250),
      ),
    );

    _animations = List.generate(
      cards.length,
          (_) => AlwaysStoppedAnimation(const Offset(0, 0)),
    );

    _isPrepared = true;
  }

  /// 创建每张牌的动画 Tween
  void _buildAnimations() {
    final stockPos = _getStockPosition();

    for (int i = 0; i < _cards.length; i++) {
      final endX = targetX(i);
      final endY = targetY(i);

      // SlideTransition 的 offset 是相对偏移，需转比例
      final dx = (stockPos.dx - endX) / 50.0;
      final dy = (stockPos.dy - endY) / 90.0;

      _animations[i] = Tween<Offset>(
        begin: Offset(dx, dy),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controllers[i],
          curve: Curves.easeOut,
        ),
      );
    }
  }

  List<Animation<Offset>> get animations => _animations;

  /// 顺序播放 28 张发牌动画
  Future<void> play() async {
    if (!_isPrepared) return;

    _buildAnimations();

    // 顺序播放：给人自然感
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].forward();
      await Future.delayed(const Duration(milliseconds: 45));
    }
  }

  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
  }
}