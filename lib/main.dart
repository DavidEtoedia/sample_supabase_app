import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_sample_app/auth/widget/sign_in.dart';
import 'package:supabase_sample_app/config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureApp();
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
