import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

ScrollController useScrollControllerForAnimation(
  AnimationController animationController,
) {
  final ScrollController scrollController = ScrollController();
  scrollController.addListener(() {
    print("Lên");
    switch (scrollController.position.userScrollDirection) {

      // Scrolling up - forward the animation (value goes to 1)
      case ScrollDirection.forward:
        animationController.forward();
        break;
      // Scrolling down - reverse the animation (value goes to 0)
      case ScrollDirection.reverse:
        animationController.reverse();
        break;
      case ScrollDirection.idle:
        break;
    }
  });
  return scrollController;
}



// ScrollController useScrollControllerForAnimation(
//   AnimationController animationController,
// ) {
  
//   return Hook.use(_ScrollControllerForAnimationHook(
//     animationController: animationController,
//   ));
// }

// class _ScrollControllerForAnimationHook extends Hook<ScrollController> {
//   final AnimationController animationController;

//   const _ScrollControllerForAnimationHook({
//     required this.animationController,
//   });

//   @override
//   _ScrollControllerForAnimationHookState createState() =>
//       _ScrollControllerForAnimationHookState();
// }

// class _ScrollControllerForAnimationHookState
//     extends HookState<ScrollController, _ScrollControllerForAnimationHook> {
//   late ScrollController _scrollController;

//   @override
//   void initHook() {
//     _scrollController = ScrollController();
//     _scrollController.addListener(() {
//       switch (_scrollController.position.userScrollDirection) {
//         case ScrollDirection.forward:
//           // State has the "widget" property
//           // HookState has the "hook" property
//           hook.animationController.forward();
//           break;
//         case ScrollDirection.reverse:
//           hook.animationController.reverse();
//           break;
//         case ScrollDirection.idle:
//           break;
//       }
//     });
//   }

//   // Build doesn't return a Widget but rather the ScrollController
//   @override
//   ScrollController build(BuildContext context) => _scrollController;

//   // This is what we came here for
//   @override
//   void dispose() => _scrollController.dispose();
// }