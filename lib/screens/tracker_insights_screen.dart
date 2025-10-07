import 'package:flutter/material.dart';
import '../theme.dart';

class TrackerInsightsScreen extends StatelessWidget {
  const TrackerInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // mock data
    final nextPeriodDate = DateTime.now().add(const Duration(days: 27));
    final avgCycleLength = 28;
    final ovulationDay =
        DateTime.now().add(const Duration(days: 13)); // halfway estimate

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Cycle Insights'),
        centerTitle: true,
        backgroundColor: AppTheme.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Next Period Prediction
            _buildCard(
              title: 'Next Expected Period',
              value:
                  '${nextPeriodDate.day}/${nextPeriodDate.month}/${nextPeriodDate.year}',
              subtitle: 'Based on your recent logs',
              icon: Icons.calendar_today,
            ),

            const SizedBox(height: 16),

            // 💫 Average Cycle Length
            _buildCard(
              title: 'Average Cycle Length',
              value: '$avgCycleLength days',
              subtitle: 'Your typical cycle duration',
              icon: Icons.access_time,
            ),

            const SizedBox(height: 16),

            // 🌼 Ovulation Window
            _buildCard(
              title: 'Estimated Ovulation Day',
              value:
                  '${ovulationDay.day}/${ovulationDay.month}/${ovulationDay.year}',
              subtitle: 'Predicted fertility window',
              icon: Icons.favorite,
            ),

            const SizedBox(height: 30),

            // 🩷 Health Tips Section
            const Text(
              'Wellness Tips 🌸',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
            const SizedBox(height: 10),
            _tipCard('Stay hydrated — water helps reduce bloating.'),
            _tipCard('Eat iron-rich foods after your period.'),
            _tipCard('Practice light yoga during PMS for comfort.'),
            _tipCard('Track your mood and energy — notice your patterns.'),
          ],
        ),
      ),
    );
  }

  // Reusable info card widget
  Widget _buildCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.accent.withOpacity(0.15),
              child: Icon(icon, color: AppTheme.accent, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppTheme.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tip card widget
  Widget _tipCard(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.tips_and_updates, color: AppTheme.accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: AppTheme.darkText),
            ),
          ),
        ],
      ),
    );
  }
}
