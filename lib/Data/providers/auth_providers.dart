import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'package:supabase_sample_app/Data/auth_service/auth_service.dart';

final authServiceProvider = Provider((ref) {
  return AuthService(supabase.Supabase.instance);
});

final streamData = StreamProvider((ref) {
  return ref.watch(authServiceProvider).getStocks();
});
