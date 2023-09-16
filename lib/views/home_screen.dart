import 'package:curie_task/widgets/bank_card.dart';
import 'package:curie_task/widgets/vibrate_animation.dart';
import 'package:flutter/material.dart';

 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "/homescreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _amountController = TextEditingController();
  late AnimationController vibratingController;

  @override
  void initState() {
    _amountController.addListener(() {
      setState(() {});
    });
    vibratingController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 67, 123, 227),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Spacer(flex: 1),
                  const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/images/me.jpeg"),
                          radius: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.navigate_next_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/redbus.png"),
                          radius: 40,
                        )
                      ],
                    ),
                  const SizedBox(height: 15),
                  Text(
                    "payment to red Bus",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "(redbus@axis)",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  VibrateAnimation(
                    animation: vibratingController,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "₹",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 5),
                        Center(
                          child: IntrinsicWidth(
                            child: TextFormField(
                              controller: _amountController,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headlineLarge!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "0",
                                hintStyle: Theme.of(context)
                                    .primaryTextTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.white38),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Payment via Billdesk",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Spacer(flex: 2),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        BankCard(
                          amount: _amountController.text,
                          animationController: vibratingController,
                          textEditingController: _amountController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    vibratingController.dispose();
    super.dispose();
  }
}
