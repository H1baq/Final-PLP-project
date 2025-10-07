import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../theme.dart';

class PeriodTrackerScreen extends StatefulWidget {
  const PeriodTrackerScreen({super.key});

  @override
  State<PeriodTrackerScreen> createState() => _PeriodTrackerScreenState();
}

class _PeriodTrackerScreenState extends State<PeriodTrackerScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  String? _flowLevel;
  final TextEditingController _symptomsController = TextEditingController();

  final List<String> flowLevels = ['Light', 'Medium', 'Heavy'];

  void _showLogPeriodForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 25,
          left: 25,
          right: 25,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Log Your Period',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),
              const SizedBox(height: 20),

              // Start date picker
              ListTile(
                leading: const Icon(Icons.calendar_today, color: AppTheme.accent),
                title: Text(
                  _selectedStartDate == null
                      ? 'Select Start Date'
                      : 'Start Date: ${_selectedStartDate!.toLocal().toString().split(' ')[0]}',
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _focusedDay,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() => _selectedStartDate = picked);
                  }
                },
              ),

              // End date picker
              ListTile(
                leading: const Icon(Icons.calendar_month, color: AppTheme.accent),
                title: Text(
                  _selectedEndDate == null
                      ? 'Select End Date'
                      : 'End Date: ${_selectedEndDate!.toLocal().toString().split(' ')[0]}',
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedStartDate ?? _focusedDay,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() => _selectedEndDate = picked);
                  }
                },
              ),

              const SizedBox(height: 10),

              // Flow level dropdown
              DropdownButtonFormField<String>(
                value: _flowLevel,
                decoration: InputDecoration(
                  labelText: 'Flow Level',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: flowLevels.map((level) {
                  return DropdownMenuItem(value: level, child: Text(level));
                }).toList(),
                onChanged: (value) => setState(() => _flowLevel = value),
              ),

              const SizedBox(height: 15),

              // Symptoms input
              TextField(
                controller: _symptomsController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Symptoms (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Save button
              ElevatedButton(
                onPressed: () {
                  if (_selectedStartDate == null || _selectedEndDate == null || _flowLevel == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all required fields')),
                    );
                    return;
                  }

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Period logged successfully!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Save Entry',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Cycle Tracker'),
        backgroundColor: AppTheme.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppTheme.accent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your next cycle is expected in 3 days',
              style: TextStyle(fontSize: 16, color: AppTheme.darkText),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: () => _showLogPeriodForm(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              ),
              label: const Text(
                'Log Period',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
