import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_sample_app/Data/model/stocks.dart';
import 'package:supabase_sample_app/Data/model/user_profile.dart';

class AuthService {
  Supabase supabase;
  AuthService(this.supabase);

  Future<void> signUp(
      String email, String password, String firstname, String lastname) async {
    final res = await supabase.client.auth.signUp(email, password);
    if (res.error != null) {
      throw res.error?.message ?? "";
    } else {
      var userProfile = UserProfile(
          created: DateTime.now(),
          firstName: firstname,
          lastName: lastname,
          id: res.data?.user?.id,
          address: "",
          imageUrl: "");
      insertUser(userProfile);
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

  Future<void> insertUser(UserProfile userProfile) async {
    // final user = {"firstname": firstname, "lastname": lastname, "id": userId};
    final res = await supabase.client
        .from("profile")
        .insert(userProfile.toJson())
        .execute();
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

  Future<PostgrestResponse> delete(String id) async {
    final res = await supabase.client
        .from("stocks")
        .delete()
        .match({"id": id}).execute();

    if (res.error != null) {
      throw res.error?.message ?? "";
    } else {
      return res;
    }
  }

  Stream<List<UserProfile>> getProfile() {
    final user = supabase.client.auth.user();

    final res = supabase.client
        .from('profile')
        .stream([user!.id])
        .execute()
        .map((event) =>
            List<UserProfile>.from(event.map((x) => UserProfile.fromJson(x))));

    return res;
  }

  Future<void> editProfile(UserProfile userProfile) async {
    final user = supabase.client.auth.user();
    final res = await supabase.client
        .from("profile")
        .update(userProfile.toJson())
        .eq("id", user!.id)
        .execute();

    if (res.error != null) {
      throw res.error?.message ?? "";
    } else {}
  }

  Future<void> editStock(String itemName, String id) async {
    final res = await supabase.client
        .from("stocks")
        .update({"itemName": itemName})
        .eq("id", id)
        .execute();

    if (res.error != null) {
      throw res.error?.message ?? "";
    } else {}
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
