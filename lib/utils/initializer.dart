import 'package:curie_task/utils/size_config.dart';
import 'package:curie_task/views/home_screen.dart';
import 'package:flutter/material.dart';


class Initializer extends StatelessWidget {
  const Initializer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(builder: (context, orientation) {
            SizeConfig.init(context);
            return  const HomeScreen();
          });
        },
      ),
    );
  }
}
