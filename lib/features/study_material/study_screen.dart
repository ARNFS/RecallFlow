
import 'package:flutter/material.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  final TextEditingController _materialController =
  TextEditingController();

  List<_Flashcard> _cards = [];
  String? _errorMessage;

  @override
  void dispose() {
    _materialController.dispose();
    super.dispose();
  }

  void _generateFlashcards() {
    final lines = _materialController.text.split('\n');
    final newCards = <_Flashcard>[];

    for (final line in lines) {
      final separatorIndex = line.indexOf('|');

      if (separatorIndex == -1) {
        continue;
      }

      final question = line.substring(0, separatorIndex).trim();
      final answer = line.substring(separatorIndex + 1).trim();

      if (question.isNotEmpty && answer.isNotEmpty) {
        newCards.add(
          _Flashcard(
            question: question,
            answer: answer,
          ),
        );
      }
    }

    setState(() {
      _cards = newCards;
      _errorMessage = newCards.isEmpty
          ? 'No valid cards found. Use Question | Answer on each line.'
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FC),
        title: const Text(
          'Study Materials',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF17213A),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            const Text(
              'Create your first flashcards',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Color(0xFF17213A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Write one question and answer per line. '
                  'Separate them with the | symbol.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF7C859B),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _materialController,
              minLines: 5,
              maxLines: 10,
              decoration: InputDecoration(
                hintText:
                'What is Flutter? | A framework for building apps.\n'
                    'What is Dart? | A programming language.',
                filled: true,
                fillColor: Colors.white,
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide:
                  const BorderSide(color: Color(0xFFEAECF3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide:
                  const BorderSide(color: Color(0xFFEAECF3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Color(0xFF3859E8),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _generateFlashcards,
                icon: const Icon(Icons.auto_awesome_rounded),
                label: const Text(
                  'Create flashcards',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF3859E8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 14),
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Color(0xFFB42318),
                  fontSize: 13,
                ),
              ),
            ],
            if (_cards.isNotEmpty) ...[
              const SizedBox(height: 28),
              Text(
                'Your flashcards (${_cards.length})',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF17213A),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Tap a card to reveal its answer.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF7C859B),
                ),
              ),
              const SizedBox(height: 14),
              for (int i = 0; i < _cards.length; i++)
                _FlashcardView(
                  key: ValueKey('${_cards[i].question}-$i'),
                  card: _cards[i],
                  number: i + 1,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Flashcard {
  const _Flashcard({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;
}

class _FlashcardView extends StatefulWidget {
  const _FlashcardView({
    super.key,
    required this.card,
    required this.number,
  });

  final _Flashcard card;
  final int number;

  @override
  State<_FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<_FlashcardView> {
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            setState(() {
              _showAnswer = !_showAnswer;
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFEAECF3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CARD ${widget.number} · '
                      '${_showAnswer ? 'ANSWER' : 'QUESTION'}',
                  style: const TextStyle(
                    fontSize: 11,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3859E8),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _showAnswer
                      ? widget.card.answer
                      : widget.card.question,
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF17213A),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _showAnswer ? 'Tap to see question' : 'Tap to reveal answer',
                  style: const TextStyle(
                    fontSize: 12,
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
