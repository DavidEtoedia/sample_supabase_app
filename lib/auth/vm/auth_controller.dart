import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_sample_app/Data/auth_service/auth_manager/auth_manager.dart';
import 'package:supabase_sample_app/auth/vm/auth_state.dart';

final authStateProvider =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
  return AuthenticationNotifier(ref);
});

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  final Ref ref;
  AuthenticationNotifier(this.ref) : super(AuthenticationState.initial());

  void signUp(
      String email, String password, String firstname, String lastname) async {
    state = state.copyWith(isloading: true);

    try {
      // await ref
      //     .read(authManagerProvider)
      //     .signUp(email, password, firstname, lastname);
      // state = state.copyWith(isloading: false, isSuccess: true);
    } catch (e) {
      print(e.toString());
      state.copyWith(
          isSuccess: false, isloading: false, errorMessage: e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isloading: true);
    try {
      await ref.read(authManagerProvider).signIn(email, password);
      print("TEST");

      // state = state.copyWith(isloading: false, isSuccess: true);
      print(state.isloading);
    } catch (e) {
      print(e.toString());

      state.copyWith(
          isSuccess: false, isloading: false, errorMessage: e.toString());
    }
  }

  // void insertUser(String firstname, String lastname, String userId) async {
  //   state = state.copyWith(isloading: true);

  //   await ref.read(authProvider).insertUser(firstname, lastname, userId);
  // }
}
