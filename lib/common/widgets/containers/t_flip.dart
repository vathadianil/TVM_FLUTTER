import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TFlip extends StatefulWidget {
  const TFlip(
      {super.key,
      required this.foreGroudndWidget,
      required this.backGroundWidget});

  final Widget foreGroudndWidget;
  final Widget backGroundWidget;

  @override
  State<TFlip> createState() => _TFlipState();
}

class _TFlipState extends State<TFlip> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0015)
        ..rotateY(pi * _animation.value + ((_animation.value <= 0.5) ? 0 : pi)),
      child: GestureDetector(
        onTap: () {
          if (_status == AnimationStatus.dismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        child: _animation.value <= 0.5
            ? widget.foreGroudndWidget
            : widget.backGroundWidget,
      ),
    );
  }
}
