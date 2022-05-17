import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

// this method retrieves a map from jsonDecode function and passes it to
//the factory fromJson for this data class
TransactionResponse transactionResponseFromJson(Map<String, dynamic> str) =>
    TransactionResponse.fromJson(str);

String transactionResponseToJson(TransactionResponse data) =>
    json.encode(data.toJson());

class TransactionResponse {
  TransactionResponse({
    required this.code,
    this.data,
    required this.message,
    required this.status,
  });
  String message;
  String status;
  String code;
  Data? data;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toJson(),
        "message": message,
        "status": status,
      };
}

class Data {
  Data({
    required this.clientTransactions,
  });

  List<ClientTransaction> clientTransactions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        clientTransactions: List<ClientTransaction>.from(
            json["clientTransactions"]
                .map((x) => ClientTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clientTransactions":
            List<dynamic>.from(clientTransactions.map((x) => x.toJson())),
      };
}

class ClientTransaction {
  ClientTransaction({
    required this.amount,
    required this.balance,
    required this.comment,
    required this.currencyCode,
    required this.entryDate,
    required this.transactionId,
    required this.type,
  });

  double amount;
  String balance;
  String comment;
  String currencyCode;
  String entryDate;
  int transactionId;
  String type;

  factory ClientTransaction.fromJson(Map<String, dynamic> json) =>
      ClientTransaction(
        amount: json["amount"],
        balance: json["balance"],
        comment: json["comment"] ?? '',
        currencyCode: json["currencyCode"],
        entryDate: json["entryDate"],
        transactionId: json["transactionId"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "balance": balance,
        "comment": comment,
        "currencyCode": currencyCode,
        "entryDate": entryDate,
        "transactionId": transactionId,
        "type": type,
      };
}
