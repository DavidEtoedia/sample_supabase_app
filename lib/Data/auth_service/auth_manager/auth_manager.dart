// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:supabase_sample_app/Data/auth_service/auth_repo/auth_impl.dart';
import 'package:supabase_sample_app/Data/auth_service/auth_service.dart';
import 'package:supabase_sample_app/Data/model/stocks.dart';
import 'package:supabase_sample_app/Data/model/user_profile.dart';
import 'package:supabase_sample_app/Data/providers/auth_providers.dart';

class AuthManager extends AuthManagerImpl {
  final AuthService authService;
  AuthManager({
    required this.authService,
  });
  @override
  Future<supabase.GotrueSessionResponse> signIn(
          String email, String password) async =>
      await authService.signIn(email, password);

  @override
  Future<void> signUp(String email, String password, String firstname,
          String lastname) async =>
      await authService.signUp(email, password, firstname, lastname);

  @override
  Future<void> createStock(Stocks stocks) async =>
      await authService.createStock(stocks);

  @override
  Future<void> editStock(String itemName, String id) async =>
      authService.editStock(itemName, id);

  @override
  Future<void> editProfile(UserProfile userProfile) async =>
      authService.editProfile(userProfile);

  @override
  Future<supabase.PostgrestResponse> delete(String id) async =>
      await authService.delete(id);
}

final authManagerProvider = Provider((ref) {
  final authManager = ref.watch(authServiceProvider);
  return AuthManager(authService: authManager);
});
