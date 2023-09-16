part of 'bank_bloc.dart';

class BankEvent {
  const BankEvent();
}

class LoadBank extends BankEvent {}

class InitiatePayment extends BankEvent {}