import 'package:curie_task/utils/size_config.dart';
import 'package:curie_task/widgets/tick_animation.dart';
import 'package:curie_task/widgets/fadeInHelper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SuccessScreen extends StatefulHookConsumerWidget {
  final String amount;
  const SuccessScreen({super.key, required this.amount});
  static const routeName = "/succes-screen";

  @override
  ConsumerState<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends ConsumerState<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 123, 227),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else {
              return SizedBox(
                width: SizeConfig.screenWidth,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const TickConfettiAnimation(),
                      const SizedBox(
                        height: 40,
                      ),
                      FadeInHelper(amount: widget.amount),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
