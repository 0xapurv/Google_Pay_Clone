import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class TickConfettiAnimation extends StatefulWidget {
  const TickConfettiAnimation({super.key});
  @override
  _TickConfettiAnimationState createState() => _TickConfettiAnimationState();
}

class _TickConfettiAnimationState extends State<TickConfettiAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controllerTick;
  late Animation<double> _animation;
  late ConfettiController _controllerConfetti;

  @override
  void initState() {
    super.initState();
  _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 4));
    // Initialize the animation controller
    _controllerTick = AnimationController(
      duration: Duration(seconds: 1), // Adjust the duration as needed
      vsync: this,
    );

    // Create a curved animation
    _animation = CurvedAnimation(
      parent: _controllerTick,
      curve: Curves.bounceOut,
    );

    // Start the animation after a delay
    Future.delayed(const Duration(seconds: 1), () {
      _controllerTick.forward();
      // Start the confetti animation after a short delay (you can adjust the duration).
      Future.delayed(const Duration(microseconds: 500), () {
        _controllerConfetti.play();
      });
    });
  }

  @override
  void dispose() {
    _controllerTick.dispose();
    _controllerConfetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ScaleTransition(
                scale: _animation,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.blue,
                    size: 100,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerConfetti,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    false, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used // define a custom shape/path.
              ),
            ),
          ],
        ),
    );
  }
}