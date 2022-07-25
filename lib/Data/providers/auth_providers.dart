import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'package:supabase_sample_app/Data/auth_service/auth_service.dart';

final authServiceProvider = Provider((ref) {
  return AuthService(supabase.Supabase.instance);
});

final streamData = StreamProvider((ref) {
  return ref.watch(authServiceProvider).getStocks();
});

final streamUserProfile = StreamProvider((ref) {
  return ref.watch(authServiceProvider).getProfile();
});
// final realTimeSubscriptionData = Provider((ref) {
//   return AuthService(supabase.Supabase.instance).realTime();
// });

// final realTimeSub = StateProvider((ref) {
//   final realtime = ref.watch(realTimeSubscriptionData);
//   return realtime;
// });
