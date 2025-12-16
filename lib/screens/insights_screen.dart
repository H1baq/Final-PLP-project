import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WellnessInsightsScreen extends StatelessWidget {
  const WellnessInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Not logged in")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text("Wellness Insights"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.data!.exists) {
            return const Center(
              child: Text("No profile data found. Please set up your profile."),
            );
          }

          final data = snapshot.data!;
          final cycleLength = data["cycleLength"];
          final moodPattern = data["moodPattern"];
          final symptomPattern = data["symptomPattern"];
          final flowType = data["flowType"];
          final periodLength = data["periodLength"];
          final usesBirthControl = data["usesBirthControl"];
          final lastPeriodDate =
              DateTime.parse(data["lastPeriodDate"] ?? DateTime.now().toString());

          return _buildInsights(
            cycleLength: cycleLength,
            periodLength: periodLength,
            lastPeriodDate: lastPeriodDate,
            flowType: flowType,
            symptomPattern: symptomPattern,
            moodPattern: moodPattern,
            usesBirthControl: usesBirthControl,
          );
        },
      ),
    );
  }

  Widget _buildInsights({
    required int cycleLength,
    required int periodLength,
    required DateTime lastPeriodDate,
    required String flowType,
    required String symptomPattern,
    required String moodPattern,
    required bool usesBirthControl,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          _insightCard(
              "Your Cycle Length",
              "Your average cycle is $cycleLength days. This helps predict fertility windows and symptoms."),
          _insightCard(
              "Flow Type",
              "You reported $flowType flow. Hydration and rest can help during heavier days."),
          _insightCard(
              "Symptoms",
              "You usually experience $symptomPattern — consider light stretching or heat therapy."),
          _insightCard(
              "Mood Pattern",
              "Your mood pattern is $moodPattern. Journaling helps track emotional patterns."),
          _insightCard(
              "Birth Control",
              usesBirthControl
                  ? "Birth control may affect your hormone cycle."
                  : "No hormonal birth control reported."),
        ],
      ),
    );
  }

  Widget _insightCard(String title, String desc) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.pink)),
            const SizedBox(height: 8),
            Text(desc, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
