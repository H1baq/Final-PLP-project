import 'package:flutter/material.dart';
import '../theme.dart';

class LessonHormones extends StatefulWidget {
  const LessonHormones({super.key});

  @override
  State<LessonHormones> createState() => _LessonHormonesState();
}

class _LessonHormonesState extends State<LessonHormones> {
  final List<bool> _expanded = [false, false, false, false];

  final List<Map<String, dynamic>> hormones = [
    {
      "name": "Estrogen",
      "short": "Rises before ovulation; boosts energy & mood.",
      "details": "Estrogen is a key hormone that peaks before ovulation. It helps improve energy, enhances mood, supports bone health, and prepares your body for a possible pregnancy.",
      "color": Colors.pink[100],
      "icon": Icons.wb_sunny_outlined
    },
    {
      "name": "Progesterone",
      "short": "Increases after ovulation; supports pregnancy & causes PMS.",
      "details": "Progesterone rises after ovulation, helping maintain the uterine lining for pregnancy. It can also cause PMS symptoms like bloating, mood swings, and fatigue.",
      "color": Colors.orange[100],
      "icon": Icons.nights_stay_outlined
    },
    {
      "name": "FSH",
      "short": "Stimulates the ovaries.",
      "details": "Follicle Stimulating Hormone (FSH) triggers the growth of ovarian follicles, preparing eggs for ovulation.",
      "color": Colors.green[100],
      "icon": Icons.bolt_outlined
    },
    {
      "name": "LH",
      "short": "Triggers ovulation.",
      "details": "Luteinizing Hormone (LH) surges mid-cycle to trigger ovulation—the release of a mature egg from the ovary.",
      "color": Colors.blue[100],
      "icon": Icons.bubble_chart_outlined
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: const Text("Hormonal Changes"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hormones in Your Cycle",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary),
            ),
            const SizedBox(height: 20),
            ...List.generate(hormones.length, (index) {
              final hormone = hormones[index];
              return _buildHormoneCard(index, hormone);
            }),
            const SizedBox(height: 20),
            const Text(
              "Understanding hormones helps you explain cravings, mood changes, and symptoms.",
              style: TextStyle(fontSize: 16, color: AppTheme.darkText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHormoneCard(int index, Map<String, dynamic> hormone) {
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
          color: hormone["color"],
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
                Icon(hormone["icon"], size: 28, color: AppTheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    hormone["name"],
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
            Text(hormone["short"], style: const TextStyle(fontSize: 16)),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(hormone["details"],
                    style: const TextStyle(fontSize: 14, color: Colors.black87)),
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
