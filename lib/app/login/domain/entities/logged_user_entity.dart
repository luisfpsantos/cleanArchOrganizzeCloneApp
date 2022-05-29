class LoggedUserEntity {
  final String name;
  final String user;
  final bool authenticated;
  final String userId;

  LoggedUserEntity({
    required this.name,
    required this.user,
    required this.authenticated,
    required this.userId,
  });
}
