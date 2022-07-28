import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_sample_app/Data/controller/generic_state_notifier.dart';
import 'package:supabase_sample_app/Data/model/stocks.dart';
import 'package:supabase_sample_app/Data/providers/auth_providers.dart';
import 'package:supabase_sample_app/auth/vm/delete_vm.dart';
import 'package:supabase_sample_app/auth/widget/profile_screen.dart';
import 'package:supabase_sample_app/auth/widget/text_field.dart';
import 'package:supabase_sample_app/data_base/items.dart';
import 'package:supabase_sample_app/stocks/available_stocks.dart';
import 'package:supabase_sample_app/stocks/vm/create_stock_vm.dart';
import 'package:uuid/uuid.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(
        () => print('focusNode updated: hasFocus: ${focusNode.hasFocus}'));

    super.initState();
  }

  TextEditingController itemName = TextEditingController();
  TextEditingController itemAmount = TextEditingController();
  TextEditingController itemQuantity = TextEditingController();

  @override
  void dispose() {
    itemAmount.dispose();
    itemName.dispose();
    itemQuantity.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(body: HookConsumer(
        builder: (context, ref, child) {
          final userProfile = ref.watch(streamUserProfile);
          // final controller = ref.watch(controllerProvider);
          final createStock = ref.watch(createStockProvider);
          final itemsDb = Hive.box<Items>("items");
          ref.listen<RequestState>(createStockProvider, (prev, state) {
            if (state is Success<PostgrestResponse>) {
              // print(state.value!.data);
              var items = Items()
                ..itemName = state.value!.data[0]["itemName"].toString()
                ..itmeAmount = state.value!.data[0]["itemAmount"].toString()
                ..itemId = state.value!.data[0]["id"].toString()
                ..itemQuantity =
                    state.value!.data[0]["itemQuantity"].toString();

              itemsDb.add(items);
            } else if (state is Error) {
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
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Create Stock",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        userProfile.when(
                            data: (data) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfileScreen(
                                                address: data[0].address,
                                                firstName: data[0].firstName,
                                                lastName: data[0].lastName,
                                                urlImage: data[0].imageUrl,
                                              )));
                                },
                                child: const Icon(
                                  Icons.account_circle_rounded,
                                  size: 30,
                                ),
                              );
                            },
                            loading: () => const CircularProgressIndicator(),
                            error: (e, s) {
                              return Text(e.toString());
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder<Box>(
                        valueListenable: Hive.box<Items>("items").listenable(),
                        builder: (context, box, _) {
                          final savedItem = box.values.toList().cast<Items>();

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
                              savedItem.isEmpty
                                  ? const SizedBox.shrink()
                                  : SizedBox(
                                      height: 50,
                                      child: ListView.separated(
                                        itemCount: savedItem.length,
                                        itemBuilder: (context, index) {
                                          final item = savedItem[index];
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(item.itemName.toString()),
                                              const Spacer(),
                                              InkWell(
                                                  onTap: () {
                                                    box.deleteAt(index);
                                                    ref
                                                        .read(
                                                            deleteStockProvider
                                                                .notifier)
                                                        .deleteStock(item.itemId
                                                            .toString());
                                                  },
                                                  child: const Icon(
                                                    Icons.cancel_outlined,
                                                    size: 15,
                                                    color: Colors.grey,
                                                  )),
                                            ],
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            height: 10,
                                          );
                                        },
                                      ),
                                    )
                            ],
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Item Name",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormInput(
                        labelText: "Enter item name",
                        controller: itemName,
                        validator: (value) => null,
                        obscureText: false,
                        capitalization: TextCapitalization.words),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Item Amount",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormInput(
                        labelText: "Enter item amount",
                        controller: itemAmount,
                        validator: (value) => null,
                        obscureText: false,
                        capitalization: TextCapitalization.words),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Enter Quantity",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormInput(
                        focusNode: focusNode,
                        labelText: "Enter your email",
                        controller: itemQuantity,
                        validator: (value) => null,
                        obscureText: false,
                        capitalization: TextCapitalization.words),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: (() {
                                var id = const Uuid();
                                var stocks = Stocks(
                                    itemName: itemName.text,
                                    itemQuantity: int.parse(itemQuantity.text),
                                    id: id.v4(),
                                    itemAmount: int.parse(itemAmount.text),
                                    created: DateTime.now());

                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }

                                ref
                                    .read(createStockProvider.notifier)
                                    .createStock(stocks);
                              }),
                              child: createStock is Loading
                                  ? const Center(
                                      child: SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          )))
                                  : const Text("Send"))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AvailableStock()));
                              }),
                              child: const Text("Available Stock"))),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
