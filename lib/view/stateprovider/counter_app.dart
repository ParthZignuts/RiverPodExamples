import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/provider/provider.dart';

class CounterApp extends ConsumerWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(counterProvider, (previous, next) {
      if (next == 3) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('The Value is $next')));
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiverPod'),
        actions: [
          IconButton(
              onPressed: () => ref.refresh(counterProvider),
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final counterValue = ref.watch(counterProvider);
            return Text(
              counterValue.toString(),
              style: const TextStyle(
                  color: Colors.indigo,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ref.read(counterProvider.notifier).state++;
          ref.read(counterProvider.notifier).update((state) => state + 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
