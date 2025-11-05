import 'dart:io';

// Firebase-style classes for simplicity
class StytchAuth {
  final String apiKey;
  final String projectId;

  StytchAuth({required this.apiKey, required this.projectId});

  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    print('🧩 Creating new user: $email');
    await Future.delayed(Duration(seconds: 1)); // Simulate API call
    return UserCredential(User(email: email, displayName: 'Demo User'));
  }

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    print('✅ Signing in: $email');
    await Future.delayed(Duration(seconds: 1)); // Simulate API call
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

void main() async {
  print('=== Firebase-Style Stytch Authentication Demo ===\n');

  // Initialize StytchAuth (Firebase-style)
  final auth = StytchAuth(
    apiKey: Platform.environment['STYTCH_API_KEY'] ?? 'demo_api_key',
    projectId: Platform.environment['STYTCH_PROJECT_ID'] ?? 'demo_project_id',
  );

  print('Initialized StytchAuth:');
  print('  API Key: ${auth.apiKey.substring(0, 10)}...');
  print('  Project ID: ${auth.projectId}\n');

  try {
    // Example 1: Create a new user
    print('--- Example 1: Create User ---');
    final newUserCredential = await auth.createUserWithEmailAndPassword(
      'demo@aortem.com',
      'password123',
    );

    print('User created successfully!');
    print('  Email: ${newUserCredential.user.email}');
    print('  Display Name: ${newUserCredential.user.displayName}\n');

    // Example 2: Sign in with the user
    print('--- Example 2: Sign In ---');
    final signInCredential = await auth.signInWithEmailAndPassword(
      'demo@aortem.com',
      'password123',
    );

    print('Sign in successful!');
    print('  Email: ${signInCredential.user.email}');
    print('  Display Name: ${signInCredential.user.displayName}\n');

    print('🎉 All authentication operations completed successfully!');
  } catch (e) {
    print('❌ Error: $e');
  }
}
