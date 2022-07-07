import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_sample_app/Data/model/stocks.dart';

abstract class AuthManagerImpl {
  Future<void> signUp(
      String email, String password, String firstname, String lastname);
  Future<GotrueSessionResponse> signIn(String email, String password);
  Future<void> createStock(Stocks stocks);
}
