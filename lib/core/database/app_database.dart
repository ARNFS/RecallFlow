
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Decks extends Table {
  TextColumn get id => text()();

  TextColumn get title => text().withLength(min: 1, max: 120)();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  BoolColumn get isArchived =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Flashcards extends Table {
  TextColumn get id => text()();

  TextColumn get deckId => text().references(
    Decks,
    #id,
    onDelete: KeyAction.cascade,
  )();

  TextColumn get question => text().withLength(min: 1, max: 2000)();

  TextColumn get answer => text().withLength(min: 1, max: 4000)();

  IntColumn get position => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  BoolColumn get isArchived =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CardSchedules extends Table {
  TextColumn get flashcardId => text().references(
    Flashcards,
    #id,
    onDelete: KeyAction.cascade,
  )();

  DateTimeColumn get dueAt =>
      dateTime().withDefault(currentDateAndTime)();

  IntColumn get intervalDays =>
      integer().withDefault(const Constant(0))();

  RealColumn get easeFactor =>
      real().withDefault(const Constant(2.5))();

  IntColumn get repetitions =>
      integer().withDefault(const Constant(0))();

  IntColumn get lapses => integer().withDefault(const Constant(0))();

  DateTimeColumn get lastReviewedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {flashcardId};
}

class ReviewLogs extends Table {
  TextColumn get id => text()();

  TextColumn get flashcardId => text().references(
    Flashcards,
    #id,
    onDelete: KeyAction.cascade,
  )();

  DateTimeColumn get reviewedAt =>
      dateTime().withDefault(currentDateAndTime)();

  IntColumn get rating => integer()();

  IntColumn get responseTimeMs => integer().nullable()();

  IntColumn get scheduledIntervalDays => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Decks,
    Flashcards,
    CardSchedules,
    ReviewLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'recallflow'));

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}
