// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_sample_app/Data/controller/generic_state_notifier.dart';
import 'package:supabase_sample_app/Data/model/user_profile.dart';
import 'package:supabase_sample_app/auth/vm/edit_profile.dart';
import 'package:supabase_sample_app/auth/widget/text_field.dart';
import 'package:supabase_sample_app/data_base/user.dart' as user;

class ProfileScreen extends StatefulHookConsumerWidget {
  final String firstName;
  final String lastName;
  final String address;
  final String urlImage;

  const ProfileScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.urlImage,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool editState = false;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(
        () => print('focusNode updated: hasFocus: ${focusNode.hasFocus}'));

    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editProfile = ref.watch(editProfileProvider);
    final userDb = Hive.box<user.User>("user");
    final nameController = useTextEditingController(text: widget.firstName);
    final lastNameController = useTextEditingController(text: widget.lastName);
    final addressController = useTextEditingController(text: widget.address);

    ref.listen<RequestState>(editProfileProvider, (prev, state) async {
      if (state is Loading) {
        setState(() {
          editState = false;
        });
      }
      if (state is Success) {
        var users = user.User();
        users.firstname = nameController.text;
        users.lastName = lastNameController.text;
        users.address = addressController.text;

        users.save();

        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const StockScreen()));
      }
      if (state is Error) {
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          content: Text(state.error.toString()),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: InkWell(
              onTap: () {
                focusNode.requestFocus();

                setState(() {
                  editState = true;
                });
              },
              child: const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(children: [
            ValueListenableBuilder<Box>(
                valueListenable: Hive.box<user.User>("user").listenable(),
                builder: (context, box, _) {
                  final savedUser = box.values.toList().cast<user.User>();
                  // print(savedUser);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recently added",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: Text(""),
                      )
                    ],
                  );
                }),
            TextFormInput(
                enabled: editState,
                focusNode: focusNode,
                labelText: "Enter first name",
                controller: nameController,
                validator: (value) => null,
                obscureText: false,
                capitalization: TextCapitalization.words),
            const SizedBox(height: 25),
            TextFormInput(
                enabled: editState,
                labelText: "Enter last name",
                controller: lastNameController,
                validator: (value) => null,
                obscureText: false,
                capitalization: TextCapitalization.words),
            const SizedBox(height: 25),
            TextFormInput(
                enabled: editState,
                labelText: "Enter address",
                controller: addressController,
                validator: (value) => null,
                obscureText: false,
                capitalization: TextCapitalization.words),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (() async {
                        final supaBase = Supabase.instance;
                        final user = supaBase.client.auth.user();
                        var userProfile = UserProfile(
                            id: user!.id,
                            created: DateTime.now(),
                            firstName: nameController.text,
                            lastName: lastNameController.text,
                            address: addressController.text,
                            imageUrl: "");

                        ref
                            .read(editProfileProvider.notifier)
                            .editProfile(userProfile);
                      }),
                      child: editProfile is Loading
                          ? const Center(
                              child: SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )))
                          : const Text("Save"))),
            )
          ]),
        ),
      ),
    );
  }
}
