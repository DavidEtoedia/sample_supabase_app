import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_sample_app/Data/model/stocks.dart';
import 'package:supabase_sample_app/Data/model/user_profile.dart';

abstract class AuthManagerImpl {
  Future<void> signUp(
      String email, String password, String firstname, String lastname);
  Future<GotrueSessionResponse> signIn(String email, String password);
  Future<PostgrestResponse> createStock(Stocks stocks);
  Future<void> editStock(String itemName, String id);
  Future<void> editProfile(UserProfile userProfile);
  Future<PostgrestResponse> delete(String id);
}
