import 'package:flutter/material.dart';
import 'profile_screen.dart'; // ✅ import your profile screen

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  int _cycleLength = 28;
  int _periodLength = 5;
  DateTime? _lastPeriodDate;

  String _flowType = 'Moderate';
  String _symptomPattern = 'Occasional cramps';
  bool _usesBirthControl = false;
  String _moodPattern = 'Stable';

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _lastPeriodDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _lastPeriodDate = picked);
    }
  }

  Future<void> _submitProfile() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_lastPeriodDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select last period date'),
          backgroundColor: Colors.pink,
        ),
      );
      return;
    }

    // ⭐ Navigate directly to the Profile Screen with the provided data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          cycleLength: _cycleLength,
          periodLength: _periodLength,
          lastPeriodDate: _lastPeriodDate!,
          flowType: _flowType,
          symptomPattern: _symptomPattern,
          moodPattern: _moodPattern,
          usesBirthControl: _usesBirthControl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Set Up Your Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Let’s personalize your experience 💕',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Average Cycle Length (days)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timer),
                    ),
                    initialValue: _cycleLength.toString(),
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || int.tryParse(value) == null
                        ? 'Enter a valid number'
                        : null,
                    onSaved: (value) => _cycleLength = int.parse(value!),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Average Period Length (days)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.water_drop),
                    ),
                    initialValue: _periodLength.toString(),
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || int.tryParse(value) == null
                        ? 'Enter a valid number'
                        : null,
                    onSaved: (value) => _periodLength = int.parse(value!),
                  ),
                  const SizedBox(height: 15),

                  ListTile(
                    title: Text(
                      _lastPeriodDate == null
                          ? 'Select Last Period Start Date'
                          : 'Last Period: ${_lastPeriodDate!.toLocal().toString().split(' ')[0]}',
                    ),
                    trailing: ElevatedButton(
                      onPressed: _pickDate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      child: const Text('Pick Date'),
                    ),
                  ),
                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Typical Flow Intensity',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.favorite),
                    ),
                    value: _flowType,
                    items: const [
                      DropdownMenuItem(value: 'Light', child: Text('Light')),
                      DropdownMenuItem(value: 'Moderate', child: Text('Moderate')),
                      DropdownMenuItem(value: 'Heavy', child: Text('Heavy')),
                    ],
                    onChanged: (value) => setState(() => _flowType = value!),
                    onSaved: (value) => _flowType = value!,
                  ),
                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Common Symptoms',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.medical_services),
                    ),
                    value: _symptomPattern,
                    items: const [
                      DropdownMenuItem(
                          value: 'No major symptoms',
                          child: Text('No major symptoms')),
                      DropdownMenuItem(
                          value: 'Occasional cramps',
                          child: Text('Occasional cramps')),
                      DropdownMenuItem(
                          value: 'Severe cramps', child: Text('Severe cramps')),
                      DropdownMenuItem(
                          value: 'Mood swings', child: Text('Mood swings')),
                    ],
                    onChanged: (value) => setState(() => _symptomPattern = value!),
                    onSaved: (value) => _symptomPattern = value!,
                  ),
                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Mood Pattern',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.sentiment_satisfied),
                    ),
                    value: _moodPattern,
                    items: const [
                      DropdownMenuItem(value: 'Stable', child: Text('Stable')),
                      DropdownMenuItem(
                          value: 'Mild mood swings',
                          child: Text('Mild mood swings')),
                      DropdownMenuItem(
                          value: 'Frequent mood swings',
                          child: Text('Frequent mood swings')),
                    ],
                    onChanged: (value) => setState(() => _moodPattern = value!),
                    onSaved: (value) => _moodPattern = value!,
                  ),
                  const SizedBox(height: 15),

                  SwitchListTile(
                    title: const Text('Using Birth Control'),
                    activeColor: Colors.pink,
                    value: _usesBirthControl,
                    onChanged: (value) => setState(() => _usesBirthControl = value),
                  ),
                  const SizedBox(height: 25),

                  ElevatedButton(
                    onPressed: _submitProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Save Profile',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
