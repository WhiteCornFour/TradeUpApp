import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebugMenu extends StatelessWidget {
  const DebugMenu({super.key});

  Future<void> _resetSeenOnBoarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('seenOnBoarding');

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã reset trạng thái OnBoarding!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Menu')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Reset OnBoarding'),
            onPressed: () => _resetSeenOnBoarding(context),
          ),
        ],
      ),
    );
  }
}
