import 'package:flutter/material.dart';
import '../../services/mock_api.dart';

class QuotationPage extends StatefulWidget {
  const QuotationPage({super.key});
  @override
  State<QuotationPage> createState() => _QuotationPageState();
}

class _QuotationPageState extends State<QuotationPage> {
  final _pre = TextEditingController();
  final _notes = TextEditingController();
  String _type = 'Dental';
  String _city = 'Istanbul';
  bool _visa = false, _transport = false, _hotel = false;
  bool _loading = false;

  Future<void> _submit() async {
    setState(() => _loading = true);
    try {
      final payload = {
        'treatment': _type,
        'city': _city,
        'visa': _visa,
        'transportation': _transport,
        'hotel': _hotel,
        'preconditions': _pre.text,
        'notes': _notes.text,
        'email_to': 'crm@aregongroup.com',
      };
      await MockApi.quotation(payload);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request sent. We will contact you soon.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quotation Request')),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _type,
              decoration: const InputDecoration(labelText: 'Treatment type'),
              items: const [
                DropdownMenuItem(value: 'Dental', child: Text('Dental')),
                DropdownMenuItem(value: 'Hair', child: Text('Hair')),
                DropdownMenuItem(value: 'Cosmetic', child: Text('Cosmetic')),
                DropdownMenuItem(value: 'Orthopedic', child: Text('Orthopedic')),
              ],
              onChanged: (v) => setState(() => _type = v ?? 'Dental'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _city,
              decoration: const InputDecoration(labelText: 'Preferred city'),
              items: const [
                DropdownMenuItem(value: 'Istanbul', child: Text('Istanbul')),
                DropdownMenuItem(value: 'Ankara', child: Text('Ankara')),
                DropdownMenuItem(value: 'Antalya', child: Text('Antalya')),
              ],
              onChanged: (v) => setState(() => _city = v ?? 'Istanbul'),
            ),
            const SizedBox(height: 12),
            const Text('Options'),
            CheckboxListTile(
              value: _visa,
              onChanged: (v) => setState(() => _visa = v ?? false),
              title: const Text('Visa invitation letter'),
            ),
            CheckboxListTile(
              value: _transport,
              onChanged: (v) => setState(() => _transport = v ?? false),
              title: const Text('Transportation'),
            ),
            CheckboxListTile(
              value: _hotel,
              onChanged: (v) => setState(() => _hotel = v ?? false),
              title: const Text('Hotel booking'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _pre,
              decoration: const InputDecoration(labelText: 'Any medical preconditions'),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notes,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _loading ? null : _submit,
                child: Text(_loading ? '...' : 'Send request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
