import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_sample_app/Data/auth_service/auth_manager/auth_manager.dart';
import 'package:supabase_sample_app/Data/model/stocks.dart';

class ControllerState extends Equatable {
  final bool isLoading;
  final bool stockLoading;
  final bool success;
  final bool error;
  final bool stockSuccess;
  final String errorMessage;

  const ControllerState(
      {required this.errorMessage,
      required this.isLoading,
      required this.error,
      required this.success,
      required this.stockLoading,
      required this.stockSuccess});

  factory ControllerState.initial() {
    return const ControllerState(
        isLoading: false,
        errorMessage: '',
        error: false,
        success: false,
        stockLoading: false,
        stockSuccess: false);
  }

  ControllerState copyWith(
      {bool? isLoading,
      bool? success,
      bool? error,
      bool? stockSuccess,
      bool? stockLoading,
      String? errorMessage,
      num? liked}) {
    return ControllerState(
      success: success ?? this.success,
      error: error ?? this.error,
      stockLoading: stockLoading ?? this.stockLoading,
      stockSuccess: stockSuccess ?? this.stockSuccess,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, success, error, stockSuccess, stockLoading];

  @override
  String toString() => 'ControllerState( isLoading: $isLoading)';
}

final controllerProvider =
    StateNotifierProvider.autoDispose<InvoiceController, ControllerState>(
  (ref) => InvoiceController(ref.watch(authManagerProvider)
      // ref.watch(customerProvider),
      ),
);

class InvoiceController extends StateNotifier<ControllerState> {
  final AuthManager _authManager;
  InvoiceController(this._authManager) : super(ControllerState.initial());

  void signUp(
      String email, String password, String firstname, String lastname) async {
    try {
      state = state.copyWith(isLoading: true);
      await _authManager.signUp(email, password, firstname, lastname);
      state = state.copyWith(isLoading: false, success: true);
      Future.delayed(const Duration(seconds: 5), () {
        state = state.copyWith(isLoading: false, success: false);
      });
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          success: false,
          error: true,
          errorMessage: e.toString());
    }
  }

  void creatStock(Stocks stocks) async {
    try {
      state = state.copyWith(stockLoading: true);
      await _authManager.createStock(stocks);
      state = state.copyWith(stockLoading: false, stockSuccess: true);
      Future.delayed(const Duration(milliseconds: 500), () {
        state = state.copyWith(isLoading: false, stockSuccess: false);
      });
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          stockSuccess: false,
          error: true,
          errorMessage: e.toString());
    }
  }

  void editStock(String itemName, String id, BuildContext context) async {
    try {
      state = state.copyWith(stockLoading: true);
      await _authManager.editStock(itemName, id);
      state = state.copyWith(stockLoading: false, stockSuccess: true);
      Navigator.pop(context);
      Future.delayed(const Duration(seconds: 5), () {
        state = state.copyWith(stockLoading: false, stockSuccess: false);
      });
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          stockSuccess: false,
          error: true,
          errorMessage: e.toString());
    }
  }
}
