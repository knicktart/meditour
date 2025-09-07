import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/auth_repository.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
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
      body: FutureBuilder(
        future: const FlutterSecureStorage().read(key: 'user'),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final j = jsonDecode(snap.data ?? '{}');
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${j['name'] ?? '-'}'),
                Text('Email: ${j['email'] ?? '-'}'),
                Text('Mobile: ${j['mobile'] ?? '-'}'),
                Text('Country: ${j['country'] ?? '-'}'),
                Text('Gender: ${j['gender'] ?? '-'}'),
                Text('Language: ${j['language'] ?? '-'}'),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () async {
                    await ref.read(authRepositoryProvider).logout();
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
