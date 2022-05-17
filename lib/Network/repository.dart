import 'dart:convert';

import 'package:ren_task/model/transaction_response.dart';
import 'package:http/http.dart' as http;
import 'package:ren_task/values/app_strings.dart';

class TransactionRepository {
  Future<TransactionResponse> getTransactionResponse(
      {required String bearerToken, required String sourceAppid}) async {
    final response = await http.get(Uri.parse(AppStrings.transactionUrl),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'sourceAppID': sourceAppid
        });

    final decoded = jsonDecode(response.body);
    return transactionResponseFromJson(decoded);
  }
}
