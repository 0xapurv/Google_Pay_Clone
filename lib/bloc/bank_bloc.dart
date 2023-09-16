import 'dart:math';

import 'package:curie_task/models/bank.dart';
import 'package:curie_task/repository/bank_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  BankRepo bankRepo = BankRepo();
  BankBloc() : super(BankUninitialized()) {
    on<LoadBank>((event, emit) async {
      emit(BankLoading());
      await Future.delayed(const Duration(milliseconds: 700));
      try {
        List<Banks> banks = await _fetchBanks();
        emit(BankLoaded(bankList: banks));
      } catch (e) {
        BankEventFailed(errorMessage: "Failed to load");
      }
    });
    on<InitiatePayment>((event, emit) async {
      emit(BankLoading());
      Random random = Random();
      double randomValue = random.nextDouble();
      bool isSuccess = false;

      if (randomValue < 0.66) {
        isSuccess = true;
      } else {
        isSuccess = false;
      }
      await Future.delayed(const Duration(milliseconds: 2000));
      emit(PaymentComplete(isSuccess: isSuccess));
    });
  }

  Future<List<Banks>> _fetchBanks() async {
    try {
      final List<Banks> animeQuotes = await bankRepo.loadBanks();
      return animeQuotes;
    } catch (e) {
      throw Exception('error fetching quotes');
    }
  }
}