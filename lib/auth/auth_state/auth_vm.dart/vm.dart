// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_sample_app/Data/auth_service/auth_manager/auth_manager.dart';
import 'package:supabase_sample_app/Data/controller/generic_state_notifier.dart';

class AuthenticationVm extends RequestStateNotifier<GotrueSessionResponse> {
  AuthManager authManager;
  AuthenticationVm({
    required this.authManager,
  });

  void signIn(String email, String password) =>
      makeRequest(() => authManager.signIn(email, password));
}

final signInProvider = StateNotifierProvider<AuthenticationVm,
    RequestState<GotrueSessionResponse>>((ref) {
  return AuthenticationVm(authManager: ref.watch(authManagerProvider));
});
