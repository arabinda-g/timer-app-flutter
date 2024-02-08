import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  String _timeString = "00:00";
  Color _backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _calculateTime();
    });
  }

  void _calculateTime() {
    final now = DateTime.now();
    final targetTime = DateTime(now.year, now.month, now.day, 22);
    final difference = now.isBefore(targetTime)
        ? targetTime.difference(now)
        : DateTime(now.year, now.month, now.day + 1, 22).difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    setState(() {
      _timeString = "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
      _backgroundColor = now.isAfter(targetTime) && now.isBefore(DateTime(now.year, now.month, now.day, 23, 59, 59)) ? Colors.red : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: Text(
          _timeString,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
