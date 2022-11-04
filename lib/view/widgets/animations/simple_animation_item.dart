import 'package:flutter/material.dart';

enum AnimationType { scale, size, slide, fade }

class SimpleAnimationItem extends StatefulWidget {
  final Widget child;
  final bool animate;
  final Duration delay;
  final Curve curve;
  final Offset? startOffset, endOffset;
  final List<AnimationType> animationTypes;

  const SimpleAnimationItem(
      {Key? key,
      this.animate = true,
      required this.child,
      this.startOffset,
      this.endOffset,
      this.curve = Curves.decelerate,
      this.delay = Duration.zero,
      required this.animationTypes})
      : super(key: key);

  @override
  _SimpleAnimationItemState createState() => _SimpleAnimationItemState();
}

class _SimpleAnimationItemState extends State<SimpleAnimationItem>
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
          .animate(CurvedAnimation(parent: controller, curve: widget.curve));

      Future.delayed(widget.delay).then((value) => controller.forward());
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
      Widget child = widget.child;
      for (var type in widget.animationTypes) {
        switch (type) {
          case AnimationType.scale:
            child = ScaleTransition(scale: animation, child: child);
            break;
          case AnimationType.size:
            child = SizeTransition(sizeFactor: animation, child: child);
            break;
          case AnimationType.fade:
            child = FadeTransition(opacity: animation, child: child);
            break;
          case AnimationType.slide:
            child = SlideTransition(
                position: animation.drive(Tween<Offset>(
                    begin: widget.startOffset ?? const Offset(1, 0),
                    end: widget.endOffset ?? Offset.zero)),
                child: child);
        }
      }

      return child;
    }
    return widget.child;
  }
}
