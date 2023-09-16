import 'dart:io';
import 'package:curie_task/models/bank.dart';
import 'package:curie_task/views/success_screen.dart';
import 'package:curie_task/widgets/vibrate_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:pinput/pinput.dart';

class UpiScreen extends StatefulWidget {
  static const routeName = "/upi_screen";
  final Banks selectedBank;
  final String amount;
  final TextEditingController textEditingController;
  const UpiScreen(
      {super.key,
      required this.selectedBank,
      required this.amount,
      required this.textEditingController});

  @override
  State<UpiScreen> createState() => _UpiScreenState();
}

class _UpiScreenState extends State<UpiScreen>
    with SingleTickerProviderStateMixin {
  bool hasVibrator = false;
  bool isObscureText = true;
  final pinController = TextEditingController();
  late AnimationController ringingController;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
    ),
  );

  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  void vibrate() async {
    if (hasVibrator) {
      Platform.isAndroid
          ? Vibrate.feedback(FeedbackType.heavy)
          : Vibrate.feedback(FeedbackType.selection);
    }
  }

  double getheight() {
    var aspectRatio = 2 / 4;
    return (MediaQuery.of(context).size.width / 3) * aspectRatio * 4;
  }

  Widget keypadButton(int char, BuildContext context) {
    return TextButton(
      key: ValueKey(Keys.keyPadButtonKey(char)),
      child: SizedBox.expand(
        child: Center(
          child: Text(
            char.toString(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
      onPressed: () {
        vibrate();
        buttonPressed(char.toString());
      },
    );
  }

  void buttonPressed(String amount) {
    if (pinController.text.length < widget.selectedBank.pinLength) {
      pinController.text = pinController.text + amount;
      setState(() {});
    }
  }

  void backPress() {
    if (pinController.text.isNotEmpty) {
      int length = pinController.text.length;
      pinController.text = pinController.text.substring(0, length - 1);
    }
  }

  @override
  void initState() {
    Vibrate.canVibrate.then((value) => setState(() {
          hasVibrator = value;
        }));
    ringingController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    widget.selectedBank.name,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/upi.png",
                    height: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.blue[900],
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text("Verve Financial Services",
                        style: TextStyle(color: Colors.white)),
                    const Spacer(),
                    Text("₹ ${widget.amount}",
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 1),
            VibrateAnimation(
              animation: ringingController,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Enter UPI PIN",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(
                                  isObscureText ? Icons.lock_open : Icons.lock,
                                  color: Colors.blue[900],
                                ),
                              ),
                              TextSpan(
                                text: isObscureText ? " SHOW" : " HIDE",
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Pinput(
                    controller: pinController,
                    length: widget.selectedBank.pinLength,
                    defaultPinTheme: defaultPinTheme,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    cursor: cursor,
                    obscureText: isObscureText,
                    obscuringCharacter: "*",
                    preFilledWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 56,
                            height: 3,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ]),
                    onCompleted: (pin) => print(pin),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: null,
                  height: getheight(),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) => GridView.count(
                      shrinkWrap: true,
                      childAspectRatio: (constraints.maxWidth / 3) /
                          (constraints.maxHeight / 4),
                      crossAxisCount: 3,
                      children: [
                        ...List.generate(9,
                                (index) => keypadButton((index + 1), context))
                            .toList(),
                        TextButton(
                          key: const ValueKey(Keys.keyPadBackKey),
                          child: const SizedBox.expand(
                            child: Icon(
                              Icons.backspace,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            vibrate();
                            backPress();
                          },
                          onLongPress: () {
                            pinController.clear();
                          },
                        ),
                        keypadButton(0, context),
                        GestureDetector(
                          onTap: () {
                            vibrate();
                            if (pinController.text.isEmpty) {
                              ringingController.reset();
                              ringingController.forward();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Enter PIN")));
                              return;
                            }
                            widget.textEditingController.clear();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => SuccessScreen(
                                          amount: widget.amount,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue[900],
                            ),
                            child: const Icon(Icons.check,
                            color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Keys {
  static String keyPadButtonKey(int char) => "Key $char";
  static const String keyPadBackKey = "Key Back";
  static const String keyPadDoneKey = "Key Done";
}
