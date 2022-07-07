import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_sample_app/auth/auth_state/auth_state_flow.dart';
import 'package:supabase_sample_app/auth/vm/auth_controller.dart';
import 'package:supabase_sample_app/auth/widget/sign_up.dart';
import 'package:supabase_sample_app/auth/widget/text_field.dart';
import 'package:supabase_sample_app/stocks/stock_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends AuthState<SignIn> {
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
    return Scaffold(body: HookConsumer(builder: ((context, ref, child) {
      ref.listen<ControllerState>(controllerProvider, (prev, state) {
        if (state.success) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const StockScreen()));
        }
        if (state.error) {
          ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
            content: Text(state.errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                },
                child: const Text('DISMISS'),
              ),
            ],
          ));
        }
      });
      final controller = ref.watch(controllerProvider);
      return SafeArea(
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
              Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: (() async {
                          ref.read(controllerProvider.notifier).signIn(
                                emailController.text,
                                passwordController.text,
                              );
                        }),
                        child: controller.isLoading
                            ? const Center(
                                child: SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )))
                            : const Text("Sign In"))),
              )
            ],
          ),
        ),
      );
    })));
  }
}
