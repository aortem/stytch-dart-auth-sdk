/// Compatibility layer for Firebase Persistence functionality
library persistence;

/// Mock StytchPersistence enum for Firebase compatibility
///
/// Defines persistence options for authentication state storage,
/// mimicking Firebase Auth's persistence behavior.
enum StytchPersistence {
  /// Store data locally on the device
  LOCAL,

  /// Store data for the current session only
  SESSION,

  /// Do not persist data
  NONE,
}

/// Mock StytchAppException class for Firebase compatibility
///
/// Exception class that provides compatibility with Firebase app exceptions
/// while working with the stytch B2B SDK.
class StytchAppException implements Exception {
  /// The error code
  final String code;

  /// The error message
  final String message;

  /// Creates a StytchAppException instance
  ///
  /// [code] - The error code
  /// [message] - The error message
  const StytchAppException({required this.code, required this.message});

  @override
  String toString() => 'StytchAppException: $message';
}

/// Mock GoogleAuthProvider class for Firebase compatibility
///
/// Provides OAuth2 authentication with Google while using
/// stytch B2B SDK for authentication flow.
class GoogleAuthProvider {
  /// Google OAuth provider identifier
  static const String googleComProviderId = 'google.com';

  /// Creates a GoogleAuthProvider instance
  const GoogleAuthProvider();

  /// Add OAuth scopes to the authentication request
  ///
  /// [scope] - The OAuth scope to add
  void addScope(String scope) {
    // Mock implementation - no actual scope management
  }
}

/// Mock FacebookAuthProvider class for Firebase compatibility
///
/// Provides OAuth2 authentication with Facebook while using
/// stytch B2B SDK for authentication flow.
class FacebookAuthProvider {
  /// Facebook OAuth provider identifier
  static const String facebookComProviderId = 'facebook.com';

  /// Creates a FacebookAuthProvider instance
  const FacebookAuthProvider();

  /// Add OAuth scopes to the authentication request
  ///
  /// [scope] - The OAuth scope to add
  void addScope(String scope) {
    // Mock implementation - no actual scope management
  }
}

/// Mock AuthProvider class for Firebase compatibility
///
/// Abstract base class for authentication providers,
/// providing a common interface for different OAuth providers.
abstract class AuthProvider {
  /// The provider identifier
  final String providerId;

  /// Creates an AuthProvider instance
  ///
  /// [providerId] - The provider identifier
  const AuthProvider({required this.providerId});
}

/// Mock FirebaseUser class for Firebase compatibility
///
/// Represents a user in the authentication system,
/// providing compatibility with Firebase User objects.
class FirebaseUser {
  /// Unique user identifier
  final String uid;

  /// User's display name
  final String? displayName;

  /// User's profile picture URL
  final String? photoURL;

  /// User's email address
  final String? email;

  /// Whether the user's email is verified
  final bool emailVerified;

  /// Creates a FirebaseUser instance
  ///
  /// [uid] - User ID
  /// [displayName] - Optional display name
  /// [photoURL] - Optional profile picture URL
  /// [email] - Optional email address
  /// [emailVerified] - Email verification status
  const FirebaseUser({
    required this.uid,
    this.displayName,
    this.photoURL,
    this.email,
    this.emailVerified = false,
  });
}

/// Mock PhoneAuthProvider class for Firebase compatibility
///
/// Provides phone number authentication while using
/// stytch B2B SDK for the actual authentication.
class PhoneAuthProvider {
  /// Phone number provider identifier
  static const String phoneProviderId = 'phone';

  /// Creates a PhoneAuthProvider instance
  const PhoneAuthProvider();

  /// Mock verifyPhoneNumber method
  ///
  /// In a real implementation, this would handle phone verification
  /// [phoneNumber] - Phone number to verify
  /// [timeout] - Verification timeout
  /// [forceResendingToken] - Token for resending verification
  /// [phoneVerificationFailed] - Callback for verification failures
  /// [codeSent] - Callback for verification code sent
  /// [codeAutoRetrievalTimeout] - Callback for auto-retrieval timeout
  void verifyPhoneNumber({
    required String phoneNumber,
    Duration timeout = const Duration(seconds: 60),
    int? forceResendingToken,
    void Function(Exception)? phoneVerificationFailed,
    void Function(String, int?)? codeSent,
    void Function(String)? codeAutoRetrievalTimeout,
  }) {
    // Mock implementation - no actual phone verification
  }
}

/// Mock TwitterAuthProvider class for Firebase compatibility
///
/// Provides OAuth1 authentication with Twitter while using
/// stytch B2B SDK for authentication flow.
class TwitterAuthProvider {
  /// Twitter OAuth provider identifier
  static const String twitterComProviderId = 'twitter.com';

  /// Creates a TwitterAuthProvider instance
  const TwitterAuthProvider();
}

/// Mock GithubAuthProvider class for Firebase compatibility
///
/// Provides OAuth2 authentication with GitHub while using
/// stytch B2B SDK for authentication flow.
class GithubAuthProvider {
  /// GitHub OAuth provider identifier
  static const String githubComProviderId = 'github.com';

  /// Creates a GithubAuthProvider instance
  const GithubAuthProvider();
}

/// Mock EmailAuthProvider class for Firebase compatibility
///
/// Provides email/password authentication while using
/// stytch B2B SDK for the actual authentication.
class EmailAuthProvider {
  /// Email/password provider identifier
  static const String emailProviderId = 'password';

  /// Creates an EmailAuthProvider instance
  const EmailAuthProvider();
}
