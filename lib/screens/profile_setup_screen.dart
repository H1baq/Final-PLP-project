import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Basic user menstrual data
  int _cycleLength = 28;
  int _periodLength = 5;
  DateTime? _lastPeriodDate;

  // Extra details
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

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // (Later we’ll connect this to Firestore)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile saved successfully! 💕'),
        backgroundColor: Colors.pink,
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
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

                  // Cycle length
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Average Cycle Length (days)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timer),
                    ),
                    initialValue: _cycleLength.toString(),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || int.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                    onSaved: (value) => _cycleLength = int.tryParse(value!) ?? 28,
                  ),
                  const SizedBox(height: 15),

                  // Period length
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Average Period Length (days)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.water_drop),
                    ),
                    initialValue: _periodLength.toString(),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || int.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                    onSaved: (value) => _periodLength = int.tryParse(value!) ?? 5,
                  ),
                  const SizedBox(height: 15),

                  // Last period date
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

                  // Flow intensity dropdown
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

                  // Symptom pattern dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Common Symptoms',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.medical_services),
                    ),
                    value: _symptomPattern,
                    items: const [
                      DropdownMenuItem(value: 'No major symptoms', child: Text('No major symptoms')),
                      DropdownMenuItem(value: 'Occasional cramps', child: Text('Occasional cramps')),
                      DropdownMenuItem(value: 'Severe cramps', child: Text('Severe cramps')),
                      DropdownMenuItem(value: 'Mood swings', child: Text('Mood swings')),
                    ],
                    onChanged: (value) => setState(() => _symptomPattern = value!),
                    onSaved: (value) => _symptomPattern = value!,
                  ),
                  const SizedBox(height: 15),

                  // Mood pattern dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Mood Pattern',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.sentiment_satisfied),
                    ),
                    value: _moodPattern,
                    items: const [
                      DropdownMenuItem(value: 'Stable', child: Text('Stable')),
                      DropdownMenuItem(value: 'Mild mood swings', child: Text('Mild mood swings')),
                      DropdownMenuItem(value: 'Frequent mood swings', child: Text('Frequent mood swings')),
                    ],
                    onChanged: (value) => setState(() => _moodPattern = value!),
                    onSaved: (value) => _moodPattern = value!,
                  ),
                  const SizedBox(height: 15),

                  // Birth control toggle
                  SwitchListTile(
                    title: const Text('Using Birth Control'),
                    activeColor: Colors.pink,
                    value: _usesBirthControl,
                    onChanged: (value) => setState(() => _usesBirthControl = value),
                  ),
                  const SizedBox(height: 25),

                  // Save button
                  ElevatedButton(
                    onPressed: _submitProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
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
