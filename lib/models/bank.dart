class Banks {
  final String name;
  final int pinLength;
  final String cardNumber;

  Banks({
    required this.name,
    required this.pinLength,
    required this.cardNumber,
  });

  Banks.fromJson(Map<String, dynamic> json)
      : name = json["bank"],
        pinLength = json["pinLength"],
        cardNumber = json["cardNumber"];
}