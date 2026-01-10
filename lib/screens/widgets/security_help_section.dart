import 'package:flutter/material.dart';

class SecurityHelpSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SecurityHelpSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 16),
        ...items,
      ],
    );
  }
}
