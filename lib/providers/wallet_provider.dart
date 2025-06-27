import 'package:flutter/foundation.dart';
import '../models/wallet_model.dart';

class WalletProvider with ChangeNotifier {
  double _balance = 10000.0; // Mocked initial balance
  List<WalletTransaction> _transactions = [];

  WalletProvider() {
    // Initialize with mock data
    _transactions = List.from(WalletTransaction.dummyTransactions);

    // Calculate initial balance from transactions
    _balance += _transactions.fold(0, (sum, transaction) => sum + transaction.amount);
  }

  // Get current balance
  double get balance => _balance;

  // Get all transactions (sorted by date descending)
  List<WalletTransaction> get transactions => List.from(_transactions)
    ..sort((a, b) => b.date.compareTo(a.date));

  // Withdraw money from wallet
  Future<void> withdraw(double amount, String method) async {
    if (amount <= 0) {
      throw ArgumentError('Withdrawal amount must be positive');
    }

    if (amount > _balance) {
      throw StateError('Insufficient balance');
    }

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Create withdrawal transaction
    final transaction = WalletTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: -amount, // Negative for withdrawals
      type: 'withdrawal',
      description: 'Withdraw to $method',
      date: DateTime.now(),
    );

    // Update state
    _transactions.add(transaction);
    _balance -= amount;
    notifyListeners();
  }

  // Add commission (for testing/demo)
  Future<void> addCommission(double amount, String description) async {
    if (amount <= 0) {
      throw ArgumentError('Commission amount must be positive');
    }

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Create commission transaction
    final transaction = WalletTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      type: 'commission',
      description: description,
      date: DateTime.now(),
    );

    // Update state
    _transactions.add(transaction);
    _balance += amount;
    notifyListeners();
  }

  // Clear all transactions (for testing)
  void clearTransactions() {
    _transactions.clear();
    _balance = 10000.0; // Reset to initial balance
    notifyListeners();
  }
}