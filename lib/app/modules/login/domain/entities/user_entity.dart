class UserEntity {
  final String name;
  final String user;
  final bool authenticated;
  final String userId;
  final String accessLevel;

  UserEntity({
    required this.name,
    required this.user,
    required this.authenticated,
    required this.userId,
    required this.accessLevel,
  });
}
