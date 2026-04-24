class Session {
  final String sessionId;
  final String userId;
  final bool isGuest;

  const Session({
    required this.sessionId,
    required this.userId,
    required this.isGuest,
  });
}
