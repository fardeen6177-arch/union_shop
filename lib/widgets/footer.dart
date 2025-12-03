// lib/widgets/footer.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryColor,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Wrap(
            spacing: 32,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              TextButton(
                onPressed: () => context.push('/about'),
                child: const Text('About', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => context.push('/collections'),
                child: const Text('Collections', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => context.push('/personalise'),
                child: const Text('Personalise', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => context.push('/search'),
                child: const Text('Search', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '© 2025 Union Shop. All rights reserved.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
