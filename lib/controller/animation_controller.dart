import 'package:flutter/material.dart';

class MyAnimationController extends StatefulWidget {
  const MyAnimationController({super.key});

  @override
  State<MyAnimationController> createState() => _MyAnimationControllerState();
}

class _MyAnimationControllerState extends State<MyAnimationController> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> animationOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
        vsync: this
    );
    animationOffset = Tween<Offset>(
      begin: Offset(0, 5),
      end: Offset.zero,
    ).animate(parent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
