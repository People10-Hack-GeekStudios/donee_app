import 'package:flutter/material.dart';

class ScaleAnimationWidget extends StatefulWidget {
  final Widget child;
  final bool animate;
  const ScaleAnimationWidget(
      {Key? key, this.animate = true, required this.child})
      : super(key: key);

  @override
  _ScaleAnimationWidgetState createState() => _ScaleAnimationWidgetState();
}

class _ScaleAnimationWidgetState extends State<ScaleAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      controller = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 700))
        ..addListener(() {
          setState(() {});
        });

      animation = Tween<double>(begin: 0, end: 1)
          .animate(CurvedAnimation(parent: controller, curve: Curves.bounceIn));

      controller.forward();
    }
  }

  @override
  void dispose() {
    if (widget.animate) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate) {
      return ScaleTransition(scale: animation, child: widget.child);
    }
    return widget.child;
  }
}
