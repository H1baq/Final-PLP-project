import 'package:flutter/material.dart';
import '../theme.dart';

class LessonHygiene extends StatefulWidget {
  const LessonHygiene({super.key});

  @override
  State<LessonHygiene> createState() => _LessonHygieneState();
}

class _LessonHygieneState extends State<LessonHygiene> {
  final List<bool> _expanded = [false, false, false, false];

  final List<Map<String, dynamic>> tips = [
    {
      "title": "Change Pads",
      "short": "Change pads every 4–6 hours.",
      "details": "Changing pads frequently prevents odor, discomfort, and bacterial growth.",
      "color": Colors.pink[100],
      "icon": Icons.timer_outlined
    },
    {
      "title": "Avoid Scented Products",
      "short": "Avoid scented products; they irritate.",
      "details": "Scented wipes or soaps can disrupt natural vaginal pH and cause irritation.",
      "color": Colors.orange[100],
      "icon": Icons.no_food_outlined
    },
    {
      "title": "Wash Regularly",
      "short": "Wash regularly with warm water.",
      "details": "Gentle washing with warm water keeps you clean without harming natural flora.",
      "color": Colors.green[100],
      "icon": Icons.shower_outlined
    },
    {
      "title": "Dispose Properly",
      "short": "Dispose of pads properly.",
      "details": "Wrap used pads in tissue and throw them in a trash bin to maintain hygiene.",
      "color": Colors.blue[100],
      "icon": Icons.delete_outline
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text("Hygiene Practices"),
        backgroundColor: AppTheme.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Staying Clean & Healthy",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary),
            ),
            const SizedBox(height: 20),
            ...List.generate(tips.length, (index) {
              final tip = tips[index];
              return _buildTipCard(index, tip);
            }),
            const SizedBox(height: 20),
            const Text(
              "Good hygiene prevents infections and helps you stay comfortable throughout your cycle.",
              style: TextStyle(fontSize: 16, color: AppTheme.darkText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(int index, Map<String, dynamic> tip) {
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
          color: tip["color"],
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
                Icon(tip["icon"], size: 28, color: AppTheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tip["title"],
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
            Text(tip["short"], style: const TextStyle(fontSize: 16)),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  tip["details"],
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
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
