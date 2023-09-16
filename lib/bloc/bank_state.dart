part of 'bank_bloc.dart';

class BankState extends Equatable {
  const BankState({
    this.banks = const <Banks>[],
  });

  final List<Banks> banks;

  BankState copyWith({
    List<Banks>? banks,
  }) {
    return BankState(banks: banks ?? this.banks);
  }

  @override
  List<Object> get props => [banks];
}

class BankUninitialized extends BankState {}

class BankLoading extends BankState {}

class BankLoaded extends BankState {
  final List<Banks> bankList;
  BankLoaded({required this.bankList});
}

class BankEventFailed extends BankState {
  final String? errorMessage;

  BankEventFailed({this.errorMessage});
}

class PaymentComplete extends BankState {
  final bool isSuccess;
  PaymentComplete({required this.isSuccess});
}