import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_sample_app/Data/model/stocks.dart';

class AuthService {
  Supabase supabase;
  AuthService(this.supabase);

  Future<void> signUp(
      String email, String password, String firstname, String lastname) async {
    final res = await supabase.client.auth.signUp(email, password);
    if (res.error != null) {
      throw res.error?.message ?? "";
    } else {
      insertUser(firstname, lastname, res.user?.id ?? "");
      // print(res.data);
    }
  }

  Future<GotrueSessionResponse> signIn(String email, String password) async {
    try {
      final res =
          await supabase.client.auth.signIn(email: email, password: password);

      if (res.error != null) {
        throw res.error!.message;
      } else {
        return res;
        // print(res.data);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> insertUser(
      String firstname, String lastname, String userId) async {
    final user = {"firstname": firstname, "lastname": lastname, "id": userId};
    final res = await supabase.client.from("profile").insert(user).execute();
    if (res.error != null) {
      throw res.error?.message ?? "";
    } else {
      // print(res.data);
    }
  }

  Future<void> createStock(Stocks stocks) async {
    final res = await supabase.client.from("stocks").insert(stocks).execute();

    if (res.error != null) {
      throw res.error?.message ?? "";
    } else {}
  }

  Stream<List<Stocks>> getStocks() {
    final res = supabase.client.from('stocks').stream(['id']).execute().map(
        (event) => List<Stocks>.from(event.map((x) => Stocks.fromJson(x))));

    return res;
  }

  Subscription? authchange() {
    final subscription =
        supabase.client.auth.onAuthStateChange((event, session) {
      // print(session?.user?.email ?? "");
      // handle auth state change
    });

    return subscription.data;
  }
}
