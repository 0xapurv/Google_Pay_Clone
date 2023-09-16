import 'package:curie_task/bloc/bank_bloc.dart';
import 'package:curie_task/models/bank.dart';
import 'package:curie_task/views/upi_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class BankCard extends StatefulWidget {
  final String amount;
  final AnimationController animationController;
  final TextEditingController textEditingController;
  const BankCard(
      {super.key,
      required this.amount,
      required this.animationController,
      required this.textEditingController});

  @override
  State<BankCard> createState() => _BankCardState();
}

class _BankCardState extends State<BankCard> {
  bool isExpanded = false;
  bool isLoading = true;
  List<Banks>? banks;
  Banks? selectedBank;

  String cardTitle(String cardNumber) {
    return "Your Bank **** $cardNumber";
  }

  void onPressTap() {
    if (widget.amount.isEmpty) {
      widget.animationController.reset();
      widget.animationController.forward();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("please enter amount")));
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => UpiScreen(
              selectedBank: selectedBank!,
              amount: widget.amount,
              textEditingController: widget.textEditingController,
            )));
  }

  Widget shimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: cardDesign("Loading..."),
    );
  }

  Widget buildCard(String title, {bool showIcon = true}) {
    return cardDesign(title, showIcon: showIcon);
  }

  Widget cardDesign(String title, {bool showIcon = true}) {
    return Row(
      children: [
        const Icon(Icons.payment, color: Colors.grey),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        if (showIcon == true)
          RotatedBox(
            quarterTurns: isExpanded ? 1 : -1,
            child: const Icon(
              Icons.chevron_left,
              size: 24,
              color: Colors.black,
            ),
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BankBloc>().add(LoadBank());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          BlocListener<BankBloc, BankState>(
            listener: (context, state) {
              if (state is BankLoaded) {
                setState(() {
                  banks = state.bankList;
                  if (banks != null && banks!.isNotEmpty) {
                    selectedBank = banks![0];
                  }
                  isLoading = false;
                });
              }
              if (state is BankEventFailed) {
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Container(),
          ),
          GestureDetector(
            onTap: () {
              if (banks != null && banks!.isNotEmpty) {
                setState(() {
                  isExpanded = !isExpanded;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: isLoading
                  ? shimmerCard()
                  : buildCard(cardTitle(selectedBank?.cardNumber ?? "")),
            ),
          ),
          const SizedBox(height: 10),
          if (banks != null && banks!.isNotEmpty) ...[
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              child: isExpanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "select bank",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        ...banks!
                            .map((bnk) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedBank = bnk;
                                      isExpanded = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      cardDesign(cardTitle(bnk.cardNumber),
                                          showIcon: false),
                                      const SizedBox(height: 10)
                                    ],
                                  ),
                                ))
                            .toList(),
                      ],
                    )
                  : Container(),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onPressTap();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(25),
                          right: Radius.circular(25)),
                    ),
                    child: const Text(
                      "Proceed to Pay",
                      style: TextStyle(color: Colors.white,
                      fontSize: 20),
                      textAlign: TextAlign.center,
                    
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: "IN PARTNERSHIP WITH ",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.grey),
              children: const [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.payment_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                TextSpan(text: " YOUR BANK")
              ],
            ),
          ),
        ],
      ),
    );
  }
}