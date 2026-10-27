import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:recallflow/core/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('RecallFlow database', () {
    test('creates a deck and reads it back', () async {
      await database.into(database.decks).insert(
        DecksCompanion.insert(
          id: 'deck-1',
          title: 'Biology',
          description: const Value('Biology revision'),
        ),
      );

      final decks = await database.select(database.decks).get();

      expect(decks, hasLength(1));
      expect(decks.first.id, 'deck-1');
      expect(decks.first.title, 'Biology');
      expect(decks.first.description, 'Biology revision');
    });

    test('creates a flashcard linked to a deck', () async {
      await database.into(database.decks).insert(
        DecksCompanion.insert(
          id: 'deck-1',
          title: 'Biology',
        ),
      );

      await database.into(database.flashcards).insert(
        FlashcardsCompanion.insert(
          id: 'card-1',
          deckId: 'deck-1',
          question: 'What is a cell?',
          answer: 'The basic unit of life.',
        ),
      );

      final cards = await database.select(database.flashcards).get();

      expect(cards, hasLength(1));
      expect(cards.first.deckId, 'deck-1');
      expect(cards.first.question, 'What is a cell?');
    });

    test('creates a review schedule for a flashcard', () async {
      await database.into(database.decks).insert(
        DecksCompanion.insert(
          id: 'deck-1',
          title: 'Biology',
        ),
      );

      await database.into(database.flashcards).insert(
        FlashcardsCompanion.insert(
          id: 'card-1',
          deckId: 'deck-1',
          question: 'What is a cell?',
          answer: 'The basic unit of life.',
        ),
      );

      await database.into(database.cardSchedules).insert(
        CardSchedulesCompanion.insert(
          flashcardId: 'card-1',
        ),
      );

      final schedules =
      await database.select(database.cardSchedules).get();

      expect(schedules, hasLength(1));
      expect(schedules.first.flashcardId, 'card-1');
      expect(schedules.first.intervalDays, 0);
      expect(schedules.first.repetitions, 0);
    });

    test('records a review attempt', () async {
      await database.into(database.decks).insert(
        DecksCompanion.insert(
          id: 'deck-1',
          title: 'Biology',
        ),
      );

      await database.into(database.flashcards).insert(
        FlashcardsCompanion.insert(
          id: 'card-1',
          deckId: 'deck-1',
          question: 'What is a cell?',
          answer: 'The basic unit of life.',
        ),
      );

      await database.into(database.reviewLogs).insert(
        ReviewLogsCompanion.insert(
          id: 'review-1',
          flashcardId: 'card-1',
          rating: 2,
        ),
      );

      final logs = await database.select(database.reviewLogs).get();

      expect(logs, hasLength(1));
      expect(logs.first.rating, 2);
      expect(logs.first.flashcardId, 'card-1');
    });
  });
}
