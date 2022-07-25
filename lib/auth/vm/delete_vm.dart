import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_sample_app/Data/auth_service/auth_manager/auth_manager.dart';
import 'package:supabase_sample_app/Data/controller/generic_state_notifier.dart';

class DeleteStockVM extends RequestStateNotifier<PostgrestResponse> {
  AuthManager authManager;
  DeleteStockVM(this.authManager);

  void deleteStock(String id) => makeRequest(() => authManager.delete(id));
}

final deleteStockProvider =
    StateNotifierProvider<DeleteStockVM, RequestState<PostgrestResponse>>(
        (ref) {
  return DeleteStockVM(ref.watch(authManagerProvider));
});
