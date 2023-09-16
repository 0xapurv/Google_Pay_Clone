import 'package:flutter/material.dart';


class FadeInHelper extends StatefulWidget {
  final String amount;
  const FadeInHelper({super.key, required this.amount});

  @override
  State<FadeInHelper> createState() => _FadeInHelperState();
}

class _FadeInHelperState extends State<FadeInHelper>
    with TickerProviderStateMixin {
  bool _visible = false;
  bool init = true;
  @override
  Widget build(BuildContext context) {
    if (init) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _visible = true;
          init = false;
        });
      });
    }
    return AnimatedOpacity(
      // If the widget is visible, animate to 0.0 (invisible).
      // If the widget is hidden, animate to 1.0 (fully visible).
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      // The green box must be a child of the AnimatedOpacity widget.
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "₹ ${widget.amount} paid",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Red Bus",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(
              "redbus@axis",
              style: TextStyle(color: Color(0xff7da4f0)),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
