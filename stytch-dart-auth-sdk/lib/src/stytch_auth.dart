class StytchAuth {
  final String apiKey;
  final String projectId;

  StytchAuth({required this.apiKey, required this.projectId});

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    print('🧩 Creating new user: $email');
    return UserCredential(User(email: email, displayName: 'Demo User'));
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    print('✅ Signing in: $email');
    return UserCredential(User(email: email, displayName: 'Demo User'));
  }
}

class User {
  final String email;
  final String displayName;

  User({required this.email, required this.displayName});
}

class UserCredential {
  final User user;

  UserCredential(this.user);
}
