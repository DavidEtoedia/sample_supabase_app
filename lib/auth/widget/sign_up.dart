import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_sample_app/auth/vm/auth_controller.dart';
import 'package:supabase_sample_app/auth/widget/sign_in.dart';
import 'package:supabase_sample_app/auth/widget/text_field.dart';

class SignUp extends StatefulHookConsumerWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ControllerState>(controllerProvider, (prev, state) {
      if (state.success) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign Up ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "First Name",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormInput(
                    labelText: "Enter first name",
                    controller: firstnameController,
                    validator: (value) => null,
                    obscureText: false,
                    capitalization: TextCapitalization.words),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Last Name",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormInput(
                    labelText: "Enter last name",
                    controller: lastnameController,
                    validator: (value) => null,
                    obscureText: false,
                    capitalization: TextCapitalization.words),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Enter email",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormInput(
                    labelText: "Enter your email",
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
                              builder: (context) => const SignIn()));
                    },
                    child: const Text(
                      "Already have an account? Sign in",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                HookConsumer(builder: ((context, ref, child) {
                  final controller = ref.watch(controllerProvider);
                  return Center(
                    child: SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: (() {
                              ref.read(controllerProvider.notifier).signUp(
                                  emailController.text,
                                  passwordController.text,
                                  firstnameController.text,
                                  lastnameController.text);
                            }),
                            child: controller.isLoading
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
      ),
    );
  }
}
