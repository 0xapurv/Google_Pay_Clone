import 'package:curie_task/models/bank.dart';

class BankRepo {
  Future<List<Banks>> loadBanks() async {
    List<Banks> banks;
    var res = [
      {"bank": "Axis Bank", "pinLength": 6, "cardNumber": "5969"},
      {"bank": "Kotak Bank", "pinLength": 4, "cardNumber": "1234"}
    ];
    banks = (res).map((e) => Banks.fromJson(e)).toList();
    return banks;
  }
}