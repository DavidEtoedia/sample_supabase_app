import 'package:riverpod/riverpod.dart';
import 'package:supabase_sample_app/Data/auth_service/auth_manager/auth_manager.dart';
import 'package:supabase_sample_app/Data/controller/generic_state_notifier.dart';

class EditStockVm extends RequestStateNotifier<void> {
  AuthManager authManager;
  EditStockVm(this.authManager);

  void editStock(String itemName, String id) =>
      makeRequest(() => authManager.editStock(itemName, id));
}

final editStockProvider =
    StateNotifierProvider<EditStockVm, RequestState<void>>((ref) {
  return EditStockVm(ref.watch(authManagerProvider));
});
