import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_sample_app/auth/widget/sign_in.dart';
import 'package:supabase_sample_app/config/config.dart';
import 'package:supabase_sample_app/data_base/items.dart';
import 'package:supabase_sample_app/data_base/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ItemsAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<Items>("items");
  await Hive.openBox<User>("user");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignIn(),
    );
  }
}
