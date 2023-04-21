import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exampe/core/core.dart';

//define Provider
final apiProvider = Provider<ApiServices>((ref) => ApiServices());
final userDataProvider = FutureProvider<List<Data>>((ref) => ref.read(apiProvider).getUser());

class ApiScreen extends ConsumerWidget {
  const ApiScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: userData.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundImage: NetworkImage('${data[index].avatar}'),
                ),
                subtitle: Text('${data[index].lastName}'),
                title: Text('${data[index].firstName}'),
              );
            },
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
