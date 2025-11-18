import 'package:flutter/material.dart';
import '../theme.dart';

class LessonMenstrualCycle extends StatefulWidget {
  const LessonMenstrualCycle({super.key});

  @override
  State<LessonMenstrualCycle> createState() => _LessonMenstrualCycleState();
}

class _LessonMenstrualCycleState extends State<LessonMenstrualCycle> {
  final List<bool> _expanded = [false, false, false, false];

  final List<Map<String, dynamic>> phases = [
    {
      "name": "Menstrual Phase",
      "short": "Shedding of the uterine lining.",
      "details": "This phase usually lasts 3–7 days. The uterine lining is shed, resulting in bleeding. Energy levels may be lower during this phase.",
      "color": Colors.pink[100],
      "icon": Icons.water_drop_outlined,
    },
    {
      "name": "Follicular Phase",
      "short": "Body prepares an egg.",
      "details": "Follicle Stimulating Hormone (FSH) stimulates the growth of ovarian follicles. Estrogen rises, preparing the body for ovulation.",
      "color": Colors.orange[100],
      "icon": Icons.light_mode_outlined,
    },
    {
      "name": "Ovulation",
      "short": "Fertile window, egg is released.",
      "details": "Around mid-cycle, Luteinizing Hormone (LH) surges and an egg is released from the ovary. Fertility is highest during this phase.",
      "color": Colors.green[100],
      "icon": Icons.egg_outlined,
    },
    {
      "name": "Luteal Phase",
      "short": "Hormone changes before the next period.",
      "details": "Progesterone rises to maintain the uterine lining for pregnancy. PMS symptoms may occur if pregnancy does not happen.",
      "color": Colors.blue[100],
      "icon": Icons.autorenew_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text("Menstrual Cycle Basics"),
        backgroundColor: AppTheme.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Understanding Your Cycle",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary),
            ),
            const SizedBox(height: 10),
            const Text(
              "The menstrual cycle is a natural monthly process that prepares the body for pregnancy. Most cycles range between 21–35 days.",
              style: TextStyle(fontSize: 16, color: AppTheme.darkText),
            ),
            const SizedBox(height: 20),
            const Text(
              "Main Phases:",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkText),
            ),
            const SizedBox(height: 10),
            ...List.generate(phases.length, (index) {
              final phase = phases[index];
              return _buildPhaseCard(index, phase);
            }),
            const SizedBox(height: 20),
            const Text(
              "Tracking your cycle helps you understand: symptoms, fertility, mood changes, and health patterns.",
              style: TextStyle(fontSize: 16, color: AppTheme.darkText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseCard(int index, Map<String, dynamic> phase) {
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
          color: phase["color"],
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
                Icon(phase["icon"], size: 28, color: AppTheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    phase["name"],
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
            Text(phase["short"], style: const TextStyle(fontSize: 16)),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  phase["details"],
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
