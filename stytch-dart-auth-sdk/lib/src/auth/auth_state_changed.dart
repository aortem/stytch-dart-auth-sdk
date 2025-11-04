/// Compatibility layer for Firebase AuthStateChanged functionality
library auth_state_changed;

import 'dart:async';
import '../models/user.dart';

/// Mock Unsubscribe type for compatibility
typedef Unsubscribe = void Function();

/// Extension to provide Firebase-like functionality to our User model
extension UserCompatibility on User {
  /// Get ID token (mock implementation)
  Future<String> getIdToken([bool forceRefresh = false]) async {
    // Mock implementation - in real usage this would get an actual token
    return 'mock_id_token_${userId}_${forceRefresh ? 'refreshed' : 'cached'}';
  }

  /// Mock uid property
  String get uid => userId;

  /// Mock emailVerified property
  bool get emailVerified => true; // Assume verified for mock

  /// Mock displayName property
  String? get displayName => name;

  /// Mock photoURL property
  String? get photoURL => null; // No photo in our model

  /// Mock idToken property
  String? get idToken => null; // No direct token in our model
}

/// Provide Firebase-like onAuthStateChanged functionality
/// This creates a compatibility layer between stytch and Firebase patterns
Stream<User?> onAuthStateChanged() {
  // Return an empty stream as a placeholder
  // In a real implementation, this would listen to stytch auth state changes
  return Stream.value(null);
}
