import 'package:flutter/material.dart';
import '../theme.dart';
import 'lesson_menstrual_cycle.dart';
import 'lesson_hormones.dart';
import 'lesson_hygiene.dart';
import 'lesson_myths.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> topics = [
      {
        'icon': Icons.water_drop,
        'title': 'Menstrual Cycle Basics',
        'screen': const LessonMenstrualCycle()
      },
      {
        'icon': Icons.lightbulb,
        'title': 'Hormonal Changes',
        'screen': const LessonHormones()
      },
      {
        'icon': Icons.clean_hands,
        'title': 'Hygiene Practices',
        'screen': const LessonHygiene()
      },
      {
        'icon': Icons.chat,
        'title': 'Myths vs Facts',
        'screen': const LessonMyths()
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Education Hub'),
        backgroundColor: AppTheme.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => topic['screen']),
              );
            },
            child: Container(
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
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.darkText),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
