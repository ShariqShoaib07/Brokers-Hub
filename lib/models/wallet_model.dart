import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';

class WalletTransaction {
  final String id;
  final double amount;
  final String type; // "commission" or "withdrawal"
  final String description;
  final DateTime date;

  WalletTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.date,
  });

  // Factory constructor for creating from JSON
  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  // Dummy transaction list
  static List<WalletTransaction> dummyTransactions = [
    WalletTransaction(
      id: "1",
      amount: 15000,
      type: "commission",
      description: "Solar setup referral",
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    WalletTransaction(
      id: "2",
      amount: -5000,
      type: "withdrawal",
      description: "Withdraw to JazzCash",
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    WalletTransaction(
      id: "3",
      amount: 8000,
      type: "commission",
      description: "Construction lead bonus",
      date: DateTime.now(),
    ),
    WalletTransaction(
      id: "4",
      amount: -3000,
      type: "withdrawal",
      description: "Withdraw to Bank",
      date: DateTime.now(),
    ),
  ];

  // Copy with method for immutability
  WalletTransaction copyWith({
    String? id,
    double? amount,
    String? type,
    String? description,
    DateTime? date,
  }) {
    return WalletTransaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  // Helper to get formatted amount with sign
  String get formattedAmount {
    return '${amount >= 0 ? '+' : ''}${amount.toStringAsFixed(2)} PKR';
  }

  // Helper to get color based on transaction type
  Color get amountColor {
    return amount >= 0 ? AppColors.successGreen : AppColors.errorRed;
  }
}