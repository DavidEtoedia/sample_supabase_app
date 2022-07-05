import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_sample_app/auth/vm/auth_controller.dart';
import 'package:supabase_sample_app/auth/vm/auth_state.dart';
import 'package:supabase_sample_app/auth/widget/sign_up.dart';
import 'package:supabase_sample_app/auth/widget/text_field.dart';

class SignIn extends StatefulHookConsumerWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthenticationState>(authStateProvider, (T, state) {
      if (state.isSuccess) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
      }
      if (!state.isSuccess) {
        print(state.errorMessage);
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sign In ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Email",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormInput(
                  labelText: "Enter email",
                  controller: emailController,
                  validator: (value) => null,
                  obscureText: false,
                  capitalization: TextCapitalization.words),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Enter password",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormInput(
                  labelText: "Enter your password",
                  controller: passwordController,
                  validator: (value) => null,
                  obscureText: false,
                  capitalization: TextCapitalization.words),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: const Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              HookConsumer(builder: ((context, ref, child) {
                final controller = ref.watch(authStateProvider);
                return Center(
                  child: SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: (() async {
                            await ref.read(authStateProvider.notifier).signIn(
                                  emailController.text,
                                  passwordController.text,
                                );
                          }),
                          child: controller.isloading
                              ? const Center(
                                  child: SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      )))
                              : const Text("SignUp"))),
                );
              }))
            ],
          ),
        ),
      ),
    );
  }
}
