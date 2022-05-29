class CreditCardEntity {
  final int closedDay;
  final int dueDay;
  final String iconPath;
  final double limit;
  final String name;

  CreditCardEntity({
    required this.closedDay,
    required this.dueDay,
    required this.iconPath,
    required this.limit,
    required this.name,
  });
}
