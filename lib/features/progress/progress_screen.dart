
import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.insights_rounded,
                  size: 64,
                  color: Color(0xFF3859E8),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your Progress',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF17213A),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Track your learning progress and discover weak topics.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF7C859B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
