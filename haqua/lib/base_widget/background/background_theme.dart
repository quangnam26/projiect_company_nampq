import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class BackgroundTheme extends StatelessWidget {
  final int precent;
  BackgroundTheme({
    Key? key,
    required this.precent,
  }) : super(key: key);

  final ConfettiController _controllerCenter = ConfettiController(
    duration: const Duration(
      seconds: 10,
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (precent < 80) {
      _controllerCenter.stop();
    } else {
      _controllerCenter.play();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                height: IZIDimensions.iziSize.height,
                width: IZIDimensions.iziSize.width,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
                    shouldLoop: true, // start again as soon as the animation is finished
                    emissionFrequency: 0.05, // how often it should emit
                    numberOfParticles: 5, // number of particles to emit
                    gravity: 0.05, // gravity - or fall speed
                    colors: const [
                      ColorResources.GREEN,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple,
                    ], // manually specify the colors to be used
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
