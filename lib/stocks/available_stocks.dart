import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:supabase_sample_app/Data/providers/auth_providers.dart';

class AvailableStock extends StatefulWidget {
  const AvailableStock({Key? key}) : super(key: key);

  @override
  State<AvailableStock> createState() => _AvailableStockState();
}

class _AvailableStockState extends State<AvailableStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HookConsumer(builder: ((context, ref, child) {
        final stream = ref.watch(streamData);
        return stream.when(
            data: (data) {
              return SafeArea(
                  child: SizedBox(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final stocks = data[index];
                      return Text(stocks.itemName);
                    }),
              ));
            },
            error: (e, s) => Text(e.toString()),
            loading: () => const SizedBox(
                  child: CircularProgressIndicator(),
                ));
      })),
    );
  }
}
