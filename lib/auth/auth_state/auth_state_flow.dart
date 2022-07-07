import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_sample_app/auth/widget/sign_up.dart';
import 'package:supabase_sample_app/stocks/stock_screen.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onAuthenticated(Session session) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const StockScreen()));
  }

  @override
  void onErrorAuthenticating(String message) {
    // TODO: implement onErrorAuthenticating
  }

  @override
  void onPasswordRecovery(Session session) {
    // TODO: implement onPasswordRecovery
  }

  @override
  void onUnauthenticated() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUp()));
  }
}
