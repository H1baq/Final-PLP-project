import 'package:flutter/material.dart';
import '../theme.dart';

class LessonMyths extends StatefulWidget {
  const LessonMyths({super.key});

  @override
  State<LessonMyths> createState() => _LessonMythsState();
}

class _LessonMythsState extends State<LessonMyths> {
  final List<bool> _expanded = [false, false, false, false];

  final List<Map<String, dynamic>> myths = [
    {
      "myth": "You should not exercise on your period",
      "fact": "Exercise can actually reduce cramps and improve mood during your period.",
      "color": Colors.pink[100],
      "icon": Icons.fitness_center_outlined
    },
    {
      "myth": "Periods must be 28 days",
      "fact": "A normal cycle ranges between 21–35 days, depending on the individual.",
      "color": Colors.orange[100],
      "icon": Icons.calendar_today_outlined
    },
    {
      "myth": "Tampons break virginity",
      "fact": "Virginity is not a physical condition and using a tampon does not affect it.",
      "color": Colors.green[100],
      "icon": Icons.health_and_safety_outlined
    },
    {
      "myth": "You can’t get pregnant on your period",
      "fact": "It is rare, but pregnancy during menstruation is possible.",
      "color": Colors.blue[100],
      "icon": Icons.child_care_outlined
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text("Myths vs Facts"),
        backgroundColor: AppTheme.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Common Myths Debunked",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary),
            ),
            const SizedBox(height: 20),
            ...List.generate(myths.length, (index) {
              final item = myths[index];
              return _buildMythCard(index, item);
            }),
            const SizedBox(height: 20),
            const Text(
              "Understanding the truth empowers healthier decisions.",
              style: TextStyle(fontSize: 16, color: AppTheme.darkText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMythCard(int index, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded[index] = !_expanded[index];
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: item["color"],
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(item["icon"], size: 28, color: AppTheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item["myth"],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  _expanded[index]
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
            const SizedBox(height: 8),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  item["fact"],
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              crossFadeState: _expanded[index]
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
