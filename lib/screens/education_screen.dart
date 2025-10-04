import 'package:flutter/material.dart';
import '../theme.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  final List<Map<String, dynamic>> topics = const [
    {'icon': Icons.water_drop, 'title': 'Menstrual Cycle Basics'},
    {'icon': Icons.lightbulb, 'title': 'Hormonal Changes'},
    {'icon': Icons.clean_hands, 'title': 'Hygiene Practices'},
    {'icon': Icons.chat, 'title': 'Myths vs Facts'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Education Hub'),
        backgroundColor: AppTheme.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: topics
              .map((topic) => Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(topic['icon'], color: AppTheme.primary),
                        const SizedBox(width: 16),
                        Text(
                          topic['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppTheme.darkText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
