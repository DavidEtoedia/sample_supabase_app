import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_sample_app/Data/controller/generic_state_notifier.dart';
import 'package:supabase_sample_app/Data/providers/auth_providers.dart';
import 'package:supabase_sample_app/auth/vm/auth_controller.dart';
import 'package:supabase_sample_app/auth/vm/delete_vm.dart';
import 'package:supabase_sample_app/auth/widget/text_field.dart';

class AvailableStock extends StatefulWidget {
  const AvailableStock({Key? key}) : super(key: key);

  @override
  State<AvailableStock> createState() => _AvailableStockState();
}

class _AvailableStockState extends State<AvailableStock> {
  bool isTapped = false;
  String? _activeMeterIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Available Stocks",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: HookConsumer(
        builder: ((context, ref, child) {
          final stream = ref.watch(streamData);
          ref.listen<RequestState>(deleteStockProvider, (prev, state) {
            if (state is Error) {
              setState(() {
                _activeMeterIndex = "";
              });
              ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                content: Text(state.error.toString()),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                          .removeCurrentMaterialBanner();
                    },
                    child: const Text('DISMISS'),
                  ),
                ],
              ));
            }
          });

          return stream.when(
            data: (data) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 23, right: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 500,
                          child: ListView.separated(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final stocks = data[index];

                              return Container(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 15),
                                height: 70,
                                color: Colors.grey.shade200,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(stocks.itemName),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "NGN ${stocks.itemAmount.toString()}"),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        EditStockDialog(
                                          itemName: stocks.itemName,
                                          itemId: stocks.id.toString(),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    _activeMeterIndex == stocks.id
                                        ? const Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              Widget cancelButton = TextButton(
                                                child: const Text("Cancel"),
                                                onPressed: () {},
                                              );
                                              Widget continueButton =
                                                  TextButton(
                                                child: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    isTapped = true;
                                                    _activeMeterIndex =
                                                        _activeMeterIndex ==
                                                                stocks.id
                                                            ? null
                                                            : stocks.id;
                                                  });
                                                  ref
                                                      .read(deleteStockProvider
                                                          .notifier)
                                                      .deleteStock(
                                                          stocks.id.toString());
                                                  Navigator.pop(context);
                                                },
                                              );

                                              // set up the AlertDialog
                                              AlertDialog alert = AlertDialog(
                                                title: Text(stocks.itemName),
                                                content: const Text(
                                                    "Are you sure you want to delete this stock?"),
                                                actions: [
                                                  cancelButton,
                                                  continueButton,
                                                ],
                                              );
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );

                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500), () {
                                                setState(() {
                                                  isTapped = false;
                                                });
                                              });
                                            },
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red)),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            error: (e, s) => Text(e.toString()),
            loading: () => const Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class EditStockDialog extends HookConsumerWidget {
  final String itemName;
  final String itemId;
  const EditStockDialog(
      {Key? key, required this.itemName, required this.itemId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final editingController = useTextEditingController(text: itemName);
    final edit = ref.watch(controllerProvider);

    return InkWell(
      child: const Text(
        "Edit",
        style: TextStyle(fontSize: 10, color: Colors.blue),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormInput(
                        labelText: "Enter item name",
                        controller: editingController,
                        validator: (value) => null,
                        obscureText: false,
                        capitalization: TextCapitalization.words),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            ref.read(controllerProvider.notifier).editStock(
                                editingController.text, itemId, context);
                          },
                          child: edit is Loading
                              ? const Center(
                                  child: SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      )))
                              : const Text("Save")),
                    ))
                  ],
                ),
              );
            });
      },
    );
  }
}
