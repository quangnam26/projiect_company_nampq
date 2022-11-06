import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';

class JumpingDotsProgressIndicator extends StatefulWidget {
  final int numberOfDots;
  final double beginTweenValue = 0.0;
  final double endTweenValue = 8.0;

  const JumpingDotsProgressIndicator({
    this.numberOfDots = 5,
  });

  @override
  // ignore: no_logic_in_create_state
  _JumpingDotsProgressIndicatorState createState() => _JumpingDotsProgressIndicatorState(
        numberOfDots: numberOfDots,
      );
}

class _JumpingDotsProgressIndicatorState extends State<JumpingDotsProgressIndicator> with TickerProviderStateMixin {
  int numberOfDots = 0;
  final List<AnimationController> controllers = [];
  final List<Animation<double>> animations = [];
  final List<Widget> _widgets = [];

  _JumpingDotsProgressIndicatorState({
    required this.numberOfDots,
  });

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < numberOfDots; i++) {
      // adding controllers
      controllers.add(AnimationController(duration: const Duration(milliseconds: 350), vsync: this));
      // adding animation values
      animations.add(
        Tween(begin: widget.beginTweenValue, end: widget.endTweenValue).animate(controllers[i])
          ..addStatusListener(
            (AnimationStatus status) {
              if (status == AnimationStatus.completed) controllers[i].reverse();
              if (i == numberOfDots - 1 && status == AnimationStatus.dismissed) {
                controllers[0].forward();
              }
              if (animations[i].value > widget.endTweenValue / 2 && i < numberOfDots - 1) {
                controllers[i + 1].forward();
              }
            },
          ),
      );
      // adding list of widgets
      _widgets.add(
        Padding(
          padding: const EdgeInsets.only(right: 1.0),
          child: JumpingDot(
            animation: animations[i],
          ),
        ),
      );
    }
    // animating first dot in the list
    controllers[0].forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.0,
      child: IntrinsicWidth(
        child: Row(
          children: _widgets,
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < numberOfDots; i++) {
      controllers[i].dispose();
    }
    super.dispose();
  }
}

class JumpingDot extends AnimatedWidget {
  const JumpingDot({Key? key, required Animation<double> animation})
      : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return SizedBox(
      height: animation.value,
      width: 15,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorResources.NEUTRALS_4,
        ),
      ),
    );
  }
}
