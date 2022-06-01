class EntryEntity {
  final double amount;
  final String category;
  final String description;
  final String entryType;
  final String status;
  final String accountType;
  final DateTime date;

  EntryEntity({
    required this.date,
    required this.amount,
    required this.category,
    required this.description,
    required this.entryType,
    required this.status,
    required this.accountType,
  });
}
