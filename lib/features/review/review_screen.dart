
import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

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
                  Icons.replay_rounded,
                  size: 64,
                  color: Color(0xFF168663),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Review Session',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF17213A),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Review your flashcards and strengthen your memory.',
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
