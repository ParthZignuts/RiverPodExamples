import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/provider/provider.dart';

//Define Provider
final conuterProviderValue= StateNotifierProvider<CounterDemo,int>((ref) => CounterDemo());
class CounterAppStateNotifier extends ConsumerWidget {
  const CounterAppStateNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(conuterProviderValue, (previous, next) {
      if(next == 3){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The Value is $next')));
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiverPod'),
        actions: [
          IconButton(
              onPressed: () => ref.refresh(conuterProviderValue),
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final counterValue = ref.watch(conuterProviderValue);
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
          ref.read(conuterProviderValue.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
