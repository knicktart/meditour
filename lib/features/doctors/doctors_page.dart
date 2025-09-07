import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/catalog_repository.dart';
import '../../models/doctor.dart';

final _doctorsProvider =
    FutureProvider.autoDispose<List<Doctor>>((ref) async {
  return ref.read(catalogRepositoryProvider).doctors();
});

class DoctorsPage extends ConsumerWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(_doctorsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Doctors')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('MediTour')),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
          ],
        ),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (items) => ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (ctx, i) {
            final d = items[i];
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(d.name.substring(0, 1))),
                title: Text(d.name),
                subtitle: Text(d.specialty),
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(d.name),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Specialty: ${d.specialty}"),
                        const SizedBox(height: 6),
                        Text("Qualification: ${d.qualification ?? "-"}"),
                        const SizedBox(height: 6),
                        Text("CV: ${d.cv ?? "-"}"),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
