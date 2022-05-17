import 'package:flutter/cupertino.dart';
import 'package:ren_task/Network/repository.dart';
import 'package:ren_task/model/transaction_response.dart';
import 'package:ren_task/values/app_strings.dart';
import 'package:ren_task/viewModel/base_change_notifier.dart';

class TransactionViewModel extends BaseChangeNotifier {
  TransactionViewModel() {
    getTransaction();
  }
  final TransactionRepository _repository = TransactionRepository();
// instance of transactionResponse to hold response from api call and is accessed from the get below it
  TransactionResponse _transactionResponse =
      TransactionResponse(code: '', message: '', status: '');

  TransactionResponse get transactionResponse => _transactionResponse;

  Future<TransactionResponse> getTransaction() async {
    setState(state: TransactionState.loading);

    try {
      _transactionResponse = await _repository.getTransactionResponse(
          bearerToken: AppStrings.bearerToken,
          sourceAppid: AppStrings.sourceAppid);
      setState(state: TransactionState.completed);
    } catch (e) {
      setState(state: TransactionState.error);
    }
    return _transactionResponse;
  }
}
