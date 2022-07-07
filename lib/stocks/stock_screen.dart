import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_sample_app/Data/model/stocks.dart';
import 'package:supabase_sample_app/auth/vm/auth_controller.dart';
import 'package:supabase_sample_app/auth/widget/text_field.dart';
import 'package:supabase_sample_app/stocks/available_stocks.dart';
import 'package:uuid/uuid.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  TextEditingController itemName = TextEditingController();
  TextEditingController itemAmount = TextEditingController();
  TextEditingController itemQuantity = TextEditingController();

  @override
  void dispose() {
    itemAmount.dispose();
    itemName.dispose();
    itemQuantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HookConsumer(
      builder: (context, ref, child) {
        final controller = ref.watch(controllerProvider);
        ref.listen<ControllerState>(controllerProvider, (prev, state) {
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
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create Stock",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
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

                              ref
                                  .read(controllerProvider.notifier)
                                  .creatStock(stocks);
                            }),
                            child: controller.stockLoading
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
    ));
  }
}
