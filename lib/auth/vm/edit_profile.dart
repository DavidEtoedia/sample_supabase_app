import 'package:riverpod/riverpod.dart';
import 'package:supabase_sample_app/Data/auth_service/auth_manager/auth_manager.dart';
import 'package:supabase_sample_app/Data/controller/generic_state_notifier.dart';
import 'package:supabase_sample_app/Data/model/user_profile.dart';

class EditProfile extends RequestStateNotifier<void> {
  AuthManager authManager;
  EditProfile(this.authManager);

  void editProfile(UserProfile userProfile) =>
      makeRequest(() => authManager.editProfile(userProfile));
}

final editProfileProvider =
    StateNotifierProvider<EditProfile, RequestState<void>>((ref) {
  return EditProfile(ref.watch(authManagerProvider));
});
