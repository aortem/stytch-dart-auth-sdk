/// Firebase compatibility layer for stytch B2B SDK
library firebase_compatibility;

import 'dart:async';
import '../stytch_auth.dart';
import 'storage.dart';
import 'credential.dart';
import '../models/user.dart';
import 'get_multi_factor.dart';
import 'action_code.dart';

/// Type alias to make FirebaseAuth work as a type in Flutter apps
typedef FirebaseAuth = FirebaseCompatAuth;

/// Firebase-compatible auth wrapper class
///
/// Provides a Firebase-compatible interface while using the stytch B2B SDK
/// for authentication. This class wraps stytch functionality to mimic
/// Firebase Auth API patterns for seamless Flutter integration.
class FirebaseCompatAuth {
  final dynamic _stytchInstance;

  /// Creates a Firebase-compatible auth instance
  ///
  /// [stytchInstance] - Optional underlying stytch instance
  const FirebaseCompatAuth([dynamic stytchInstance])
    : _stytchInstance = stytchInstance;

  /// Get the underlying stytch instance (if available)
  ///
  /// Returns the stytch instance or null if not provided
  dynamic get stytchInstance => _stytchInstance;

  /// Mock currentUser property for Firebase compatibility
  ///
  /// Returns the currently authenticated user or null
  /// In a real implementation, this would return the current stytch user
  dynamic get currentUser => null;

  /// Mock signOut method for Firebase compatibility
  ///
  /// Signs out the current user and clears authentication state
  /// In a real implementation, this would clear the stytch session
  Future<void> signOut() async {
    // Stub implementation
  }

  /// Mock delete method for Firebase compatibility
  ///
  /// Deletes the current user's account
  /// In a real implementation, this would delete the stytch user
  Future<void> delete() async {
    // Stub implementation
  }

  /// Mock deleteStytchUser method for compatibility
  ///
  /// Deletes the current user's account using stytch-specific logic
  /// In a real implementation, this would call stytch user deletion
  Future<void> deleteStytchUser() async {
    // Stub implementation
  }

  /// Mock connectAuthEmulator method
  ///
  /// Connects to an authentication emulator for development
  /// [host] - The emulator host
  /// [port] - The emulator port
  void connectAuthEmulator(String host, int port) {
    // Stub implementation
  }

  /// Mock onAuthStateChanged method
  ///
  /// Returns a stream of auth state changes for Firebase compatibility
  /// In a real implementation, this would stream stytch auth state changes
  Stream<dynamic> onAuthStateChanged() {
    // Return empty stream
    return Stream.value(null);
  }

  /// Mock onIdTokenChanged method
  ///
  /// Returns a stream of ID token changes for Firebase compatibility
  /// In a real implementation, this would stream stytch token changes
  Stream<dynamic> onIdTokenChanged() {
    // Return empty stream
    return Stream.value(null);
  }

  /// Mock getCurrentUser method
  ///
  /// Returns the currently authenticated user for Firebase compatibility
  /// In a real implementation, this would return the current stytch user
  Future<dynamic> getCurrentUser() async {
    return null;
  }

  /// Mock various Firebase-like methods
  ///
  /// Get the ID token for the current user
  /// [forceRefresh] - Whether to force refresh the token
  /// Returns the ID token string
  Future<String> getIdToken([bool forceRefresh = false]) async {
    return 'mock_token_$forceRefresh';
  }

  /// Get the ID token result for Firebase compatibility
  ///
  /// Returns ID token information including claims and expiration
  Future<dynamic> getIdTokenResult() async {
    return 'mock_token_result';
  }

  /// Set the language code for the app
  ///
  /// Sets the default language code for user interface and operations
  /// [languageCode] - The language code (e.g., 'en', 'es')
  /// [appName] - Optional app name
  Future<void> setLanguageCode(String languageCode, [String? appName]) async {
    // Stub implementation
  }

  /// Get the current language code
  ///
  /// Returns the current language code for the app
  /// [appName] - Optional app name
  Future<String?> getLanguageCode([String? appName]) async {
    return 'en';
  }

  /// Set the language code with method parameter
  ///
  /// Sets the language code using method-style parameters
  /// [languageCode] - The language code
  /// [appName] - The app name
  Future<void> setLanguageCodeMethod(
    String languageCode,
    String appName,
  ) async {
    // Stub implementation
  }

  /// Get the language code with method parameter
  ///
  /// Gets the language code using method-style parameters
  /// [appName] - The app name
  Future<String?> getLanguageCodeMethod(String appName) async {
    return 'en';
  }

  /// Set the persistence level for Firebase compatibility
  ///
  /// [persistence] - The persistence level to set
  Future<void> setPersistence(Persistence persistence) async {
    // Stub implementation
  }

  /// Update user information for Firebase compatibility
  ///
  /// Updates user profile information with the given details
  /// [uid] - User identifier
  /// [idToken] - Valid ID token for authentication
  /// [info] - Map of user information to update
  Future<void> updateUserInformation(
    String uid,
    String idToken,
    Map<String, dynamic> info,
  ) async {
    // Stub implementation
  }

  /// Update user profile for Firebase compatibility
  ///
  /// Updates the user's display name and profile image
  /// [displayName] - New display name
  /// [displayImage] - Optional profile image URL
  Future<void> updateProfile(String displayName, String? displayImage) async {
    // Stub implementation
  }

  /// Update user password for Firebase compatibility
  ///
  /// Updates the current user's password
  /// [newPassword] - The new password
  Future<void> updatePassword(String newPassword) async {
    // Stub implementation
  }

  /// Send email verification code for Firebase compatibility
  ///
  /// Sends a verification code to the user's email
  /// [action] - Callback to perform the action
  Future<void> sendEmailVerificationCode(Function() action) async {
    // Stub implementation
  }

  /// Link authentication provider for Firebase compatibility
  ///
  /// Links an additional authentication provider to the current user
  Future<void> linkProvider() async {
    // Stub implementation
  }

  /// Unlink authentication provider for Firebase compatibility
  ///
  /// Unlinks an authentication provider from the current user
  /// [providerId] - The provider to unlink
  Future<void> unlinkProvider(String providerId) async {
    // Stub implementation
  }

  /// Apply action code for Firebase compatibility
  ///
  /// Applies an action code (email verification, password reset, etc.)
  /// [actionCode] - The action code to apply
  Future<void> applyActionCode(String actionCode) async {
    // Stub implementation
  }

  /// Parse action code URL for Firebase compatibility
  ///
  /// Parses and processes an action code from a URL
  /// [url] - The URL containing the action code
  Future<void> parseActionCodeUrl(String url) async {
    // Stub implementation
  }

  /// Sign in with email and password for Firebase compatibility
  ///
  /// Authenticates user with email and password credentials
  /// [email] - User's email address
  /// [password] - User's password
  Future<dynamic> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return 'mock_signin_result';
  }

  /// Sign in with custom token for Firebase compatibility
  ///
  /// Authenticates user with a custom token
  /// [uid] - Custom token or user identifier
  Future<dynamic> signInWithCustomToken(String uid) async {
    return 'mock_signin_result';
  }

  /// Link account with credentials for Firebase compatibility
  ///
  /// Links additional credentials to the current user account
  /// [credential] - The credentials to link
  Future<dynamic> linkAccountWithCredentials(dynamic credential) async {
    return 'mock_link_result';
  }

  /// Get redirect result for Firebase compatibility
  ///
  /// Returns the result of a redirect-based authentication flow
  Future<dynamic> getRedirectResult() async {
    return 'mock_redirect_result';
  }

  /// Sign in with popup for Firebase compatibility
  ///
  /// Initiates popup-based authentication with a provider
  /// [provider] - The authentication provider
  Future<dynamic> signInWithPopup(dynamic provider) async {
    return 'mock_popup_result';
  }

  /// Sign in with credential for Firebase compatibility
  ///
  /// Authenticates user with provided credentials
  /// [credential] - The authentication credentials
  Future<dynamic> signInWithCredential(dynamic credential) async {
    return 'mock_credential_signin';
  }

  /// Sign in with redirect for Firebase compatibility
  ///
  /// Initiates redirect-based authentication with a provider
  /// [provider] - The authentication provider
  Future<dynamic> signInWithRedirect(dynamic provider) async {
    return 'mock_redirect_signin';
  }

  /// Get auth before change for Firebase compatibility
  ///
  /// Retrieves authentication state before changes occur
  Future<void> getAuthBeforeChange() async {
    // Stub implementation
  }

  /// Stylch phone number link method for compatibility
  ///
  /// Links phone number using stytch-specific logic
  Future<void> stytchPhoneNumberLinkMethod() async {
    // Stub implementation
  }

  /// Reload user for Firebase compatibility
  ///
  /// Reloads user data from the authentication service
  Future<void> reloadUser() async {
    // Stub implementation
  }

  /// Get additional user information for Firebase compatibility
  ///
  /// Returns additional information about the authenticated user
  Future<Map<String, dynamic>?> getAdditionalUserInfo() async {
    return null;
  }

  /// Get additional information for Firebase compatibility
  ///
  /// Retrieves additional user information from the provider
  Future<void> getAdditionalInfo() async {
    // Stub implementation
  }

  /// Additional methods that the Flutter app expects
  ///
  /// Sign in with Google Cloud Platform for Firebase compatibility
  Future<dynamic> signInWithGCP() async {
    return 'mock_gcp_signin';
  }

  /// Link account with credentials (typo version) for compatibility
  ///
  /// Links additional credentials to the current user account
  /// [credential] - The credentials to link
  Future<dynamic> linkAccountWithCredientials(dynamic credential) async {
    return 'mock_link_credentials';
  }

  /// Get auth for comparison for Firebase compatibility
  ///
  /// Returns the auth instance for comparison purposes
  Future<dynamic> getAuthForComparison() async {
    return this;
  }

  /// Set language code with method for Firebase compatibility
  ///
  /// Sets the language code using method-style parameter
  /// [languageCode] - The language code to set
  void setLanguageCodeWithMethod(String languageCode) async {
    // Stub implementation
  }

  /// Get auth language code for Firebase compatibility
  ///
  /// Returns the current authentication language code
  String getAuthLanguageCode() {
    return 'en';
  }
}

/// Mock FirebaseCompatStytchApp class for Firebase compatibility
///
/// Provides Firebase app-like functionality while using stytch B2B SDK
/// for the underlying authentication and user management.
class FirebaseCompatStytchApp {
  static FirebaseCompatAuth? _instance;

  /// Singleton pattern for Firebase compatibility
  ///
  /// Returns the shared FirebaseCompatAuth instance
  static FirebaseCompatAuth get instance => _instance ??= FirebaseCompatAuth();

  /// Get the stytchAuth instance for compatibility
  ///
  /// Returns the Firebase-compatible auth instance
  FirebaseCompatAuth get stytchAuth => instance;

  /// Initialize the compatibility wrapper
  ///
  /// [apiKey] - The stytch API key
  /// [projectId] - The stytch project ID
  /// [environment] - The environment (sandbox, production, etc.)
  static void initialize({
    required String apiKey,
    required String projectId,
    String environment = 'sandbox',
  }) {
    _instance = FirebaseCompatAuth();
  }

  /// Mock initializeAppWithEnvironmentVariables method
  ///
  /// Initializes the app using environment variables for Firebase compatibility
  /// [apiKey] - API key
  /// [authDomain] - Auth domain
  /// [projectId] - Project ID
  /// [messagingSenderId] - Messaging sender ID
  /// [bucketName] - Storage bucket name
  /// [appId] - App ID
  static Future<void> initializeAppWithEnvironmentVariables({
    required String apiKey,
    required String authDomain,
    required String projectId,
    required String messagingSenderId,
    required String bucketName,
    required String appId,
  }) async {
    initialize(apiKey: apiKey, projectId: projectId);
  }

  /// Mock initializeAppWithServiceAccount method
  ///
  /// Initializes the app using service account for Firebase compatibility
  /// [serviceAccountContent] - Service account JSON content
  static Future<void> initializeAppWithServiceAccount({
    required String serviceAccountContent,
  }) async {
    // For now, use mock values
    initialize(
      apiKey: 'mock_api_key',
      projectId: 'mock_project_id',
      environment: 'sandbox',
    );
  }

  /// Mock initializeAppWithServiceAccountImpersonation method
  ///
  /// Initializes the app using service account with impersonation
  /// [impersonatedEmail] - Email to impersonate
  /// [serviceAccountContent] - Service account JSON content
  static Future<void> initializeAppWithServiceAccountImpersonation({
    required String impersonatedEmail,
    required String serviceAccountContent,
  }) async {
    initialize(
      apiKey: 'mock_api_key',
      projectId: 'mock_project_id',
      environment: 'sandbox',
    );
  }

  /// Get the Firebase-compatible auth instance
  ///
  /// Returns the FirebaseCompatAuth instance for Firebase compatibility
  FirebaseCompatAuth getAuth() {
    return instance;
  }

  /// Mock getStorage method
  ///
  /// Returns a storage instance for Firebase compatibility
  StytchStorage getStorage() {
    return StytchStorage();
  }

  /// Mock getCurrentUser method
  ///
  /// Returns the current user for Firebase compatibility
  dynamic getCurrentUser() {
    return null;
  }

  /// Mock getUser method
  ///
  /// Returns user information for Firebase compatibility
  dynamic getUser() {
    return null;
  }
}

/// Mock Persistence enum for Firebase compatibility
///
/// Defines persistence options for authentication state storage
enum Persistence {
  /// Store data locally on the device
  LOCAL,

  /// Store data for the current session only
  SESSION,

  /// Do not persist data
  NONE,
}

/// Global compatibility instance for Firebase compatibility
///
/// Provides global access to FirebaseCompatStytchApp instance
FirebaseCompatStytchApp stytchApp = FirebaseCompatStytchApp();

/// Global compatibility auth instance for Firebase compatibility
///
/// Returns the shared FirebaseCompatAuth instance
FirebaseCompatAuth get stytchAuthInstance => FirebaseCompatStytchApp.instance;
