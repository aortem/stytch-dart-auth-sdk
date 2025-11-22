/// Compatibility layer for Firebase IdTokenChanged functionality
library id_token_changed;

import 'dart:async';
import '../models/user.dart';

/// Mock Unsubscribe type for compatibility
typedef Unsubscribe = void Function();

/// Provide Firebase-like onIdTokenChanged functionality
/// This creates a compatibility layer between stytch and Firebase patterns
Stream<User?> onIdTokenChanged() {
  // Return an empty stream as a placeholder
  // In a real implementation, this would listen to stytch token changes
  return Stream.value(null);
}
