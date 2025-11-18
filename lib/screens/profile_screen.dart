import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final int cycleLength;
  final int periodLength;
  final DateTime lastPeriodDate;
  final String flowType;
  final String symptomPattern;
  final String moodPattern;
  final bool usesBirthControl;

  const ProfileScreen({
    super.key,
    required this.cycleLength,
    required this.periodLength,
    required this.lastPeriodDate,
    required this.flowType,
    required this.symptomPattern,
    required this.moodPattern,
    required this.usesBirthControl,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<bool> _visibleItems = [];

  @override
  void initState() {
    super.initState();
    _visibleItems = List.filled(7, false); // 7 items
    _animateItems();
  }

  void _animateItems() {
    for (int i = 0; i < _visibleItems.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          setState(() {
            _visibleItems[i] = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text("Your Profile"),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _headerCard(),
            const SizedBox(height: 20),
            _profileSection(),
          ],
        ),
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.pink[300],
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.pink, size: 40),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              "Cycle Overview",
              style: TextStyle(
                color: Colors.grey[50],
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileSection() {
    final items = [
      _animatedItem(Icons.timeline, "Average Cycle Length", "${widget.cycleLength} days"),
      _animatedItem(Icons.date_range, "Period Length", "${widget.periodLength} days"),
      _animatedItem(Icons.calendar_today, "Last Period Date",
          widget.lastPeriodDate.toLocal().toString().split(' ')[0]),
      _animatedItem(Icons.opacity, "Flow Intensity", widget.flowType),
      _animatedItem(Icons.favorite, "Common Symptoms", widget.symptomPattern),
      _animatedItem(Icons.mood, "Mood Pattern", widget.moodPattern),
      _animatedItem(Icons.shield, "Using Birth Control",
          widget.usesBirthControl ? "Yes" : "No"),
    ];

    return Column(
      children: items
          .asMap()
          .entries
          .map((e) => _fadeSlideAnimation(child: e.value, visible: _visibleItems[e.key]))
          .toList(),
    );
  }

  Widget _animatedItem(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.pink, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          Text(value,
              style: TextStyle(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _fadeSlideAnimation({required Widget child, required bool visible}) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: visible ? 1 : 0,
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0, 0.2),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        child: child,
      ),
    );
  }
}
