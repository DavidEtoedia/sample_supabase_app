// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_sample_app/Data/auth_service/auth_manager/auth_manager.dart';
import 'package:supabase_sample_app/Data/controller/generic_state_notifier.dart';
import 'package:supabase_sample_app/Data/model/stocks.dart';

class CreateStockVM extends RequestStateNotifier<PostgrestResponse> {
  final AuthManager authManager;
  CreateStockVM(
    Ref ref,
  ) : authManager = ref.read(authManagerProvider);
  void createStock(Stocks stocks) =>
      makeRequest(() => authManager.createStock(stocks));
}

final createStockProvider =
    StateNotifierProvider<CreateStockVM, RequestState<PostgrestResponse>>(
        (ref) {
  return CreateStockVM(ref);
});
