import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TransactionState { loading, completed, error, noContent }

extension AppStateExtension on TransactionState {
  bool get isLoading => this == TransactionState.loading;

  bool get isComplete => this == TransactionState.completed;

  bool get isError => this == TransactionState.error;
  bool get isEmpty => this == TransactionState.noContent;
}

// This calls Directly handles calls to notifyListeners to avoid markNeedsBuild errors, and provides a function to be used for stateUpdates
class BaseChangeNotifier extends ChangeNotifier {
  TransactionState _state = TransactionState.noContent;

  TransactionState get state => _state;
  void setState({TransactionState? state}) {
    if (state == null) {
      notifyListeners();
      return;
    } else {
      _state = state;
      notifyListeners();
    }
  }
}
