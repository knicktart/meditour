import 'package:flutter/material.dart';
import '../../services/mock_api.dart';

class CompliancePage extends StatefulWidget {
  const CompliancePage({super.key});

  @override
  State<CompliancePage> createState() => _CompliancePageState();
}

class _CompliancePageState extends State<CompliancePage> {
  bool _accepted = false;
  DateTime? _at;

  Future<void> _save() async {
    final now = DateTime.now();
    await MockApi.saveCompliance(true, now);
    setState(() {
      _accepted = true;
      _at = now;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compliance accepted.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = _accepted;
    return Scaffold(
      appBar: AppBar(title: const Text('Compliance')),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Please review and accept the compliance checklist:'),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: disabled ? true : _accepted,
              onChanged: disabled
                  ? null
                  : (v) => setState(() => _accepted = v ?? false),
              title: const Text(
                  'I acknowledge and accept the compliance checklist'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: disabled || !_accepted ? null : _save,
              child: Text(disabled ? 'Accepted' : 'Save'),
            ),
            if (_at != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Accepted at: $_at'),
              ),
          ],
        ),
      ),
    );
  }
}
