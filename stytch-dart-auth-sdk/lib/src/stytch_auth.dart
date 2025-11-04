library stytch_auth;

/// Main stytch authentication class for B2B
import 'dart:convert';
import 'dart:io';

import 'client/stytch_client.dart';
import 'client/auth_service.dart';
import 'client/user_service.dart';
import 'client/organization_service.dart';
import 'client/invitation_service.dart';
import 'models/error.dart';

/// Main stytch authentication instance
class StytchAuth {
  /// StytchConfig
  final StytchConfig _config;
  late final StytchHttpClient _httpClient;

  late final AuthService _authService;
  late final UserService _userService;
  late final OrganizationService _organizationService;
  late final InvitationService _invitationService;

  /// Constructor for StytchAuth authentication
  StytchAuth({
    required String apiKey,
    required String projectId,

    /// Environment for the SDK Environment
    /// Environment for the SDK
    /// Environment for the SDK
    /// Environment (sandbox, development, production)
    String environment = 'production',

    /// baseUrlOverride
    String baseUrlOverride = '',

    /// timeout
    Duration timeout = const Duration(seconds: 30),
  }) : _config = StytchConfig(
         apiKey: apiKey,
         projectId: projectId,
         environment: environment,
         baseUrlOverride: baseUrlOverride,
         timeout: timeout,
       ) {
    _initializeClient();
  }

  /// Create a StytchAuth instance from environment variables
  factory StytchAuth.fromEnvironmentVariables() {
    /// apiKey
    final apiKey = _getEnvVar('STYTCH_API_KEY');

    /// projectId
    final projectId = _getEnvVar('STYTCH_PROJECT_ID');

    /// environment
    final environment = _getEnvVar('STYTCH_ENVIRONMENT').isEmpty
        ? 'production'
        : _getEnvVar('STYTCH_ENVIRONMENT');

    /// baseUrlOverride
    final baseUrlOverride = _getEnvVar('STYTCH_BASE_URL');

    /// timeoutSeconds
    final timeoutSeconds = int.tryParse(_getEnvVar('STYTCH_TIMEOUT'));

    if (apiKey.isEmpty) {
      throw const StytchConfigurationException(
        'STYTCH_API_KEY environment variable is required',
      );
    }

    if (projectId.isEmpty) {
      throw const StytchConfigurationException(
        'STYTCH_PROJECT_ID environment variable is required',
      );
    }

    return StytchAuth(
      apiKey: apiKey,
      projectId: projectId,
      environment: environment,
      baseUrlOverride: baseUrlOverride,
      timeout: Duration(seconds: timeoutSeconds ?? 30),
    );
  }

  /// Get environment variable
  static String _getEnvVar(String name) {
    return Platform.environment[name] ?? '';
  }

  /// Initialize the HTTP client and services
  void _initializeClient() {
    _httpClient = StytchHttpClient(_config);
    _authService = AuthService(_httpClient);
    _userService = UserService(_httpClient);
    _organizationService = OrganizationService(_httpClient);
    _invitationService = InvitationService(_httpClient);
  }
/// Get the authentication service
AuthService get auth => _authService;

/// Get the user service
UserService get user => _userService;

/// Get the organization service
OrganizationService get organization => _organizationService;

/// Get the invitation service
InvitationService get invitation => _invitationService;

/// Check if the client is configured correctly
bool isConfigured() {
  try {
    _config.validate();
    return true;
  } catch (e) {
    return false;
  }
}

/// Get configuration details (without sensitive data)
Map<String, dynamic> getConfiguration() {
  return {
    'projectId': _config.projectId,
    'environment': _config.environment,
    'baseUrl': _config.environmentBaseUrl,
    'timeout': _config.timeout.inSeconds,
    'isConfigured': isConfigured(),
  };
}

/// Get current user (for Firebase compatibility)
dynamic get currentUser => null;

/// Sign out method (for Firebase compatibility)
Future<void> signOut() async {
  // Stub implementation for compatibility
  return;
}

/// Get auth instance (for Firebase compatibility)
stytchAuth getAuth() {
  return this;
}

/// Get storage instance (for Firebase compatibility)
dynamic getStorage() {
  return null;
}

/// Get current user (for Firebase compatibility)
dynamic getCurrentUser() {
  return null;
}

/// On auth state changed (for Firebase compatibility)
Stream<dynamic> get onAuthStateChanged => const Stream.empty();

/// On ID token changed (for Firebase compatibility)
Stream<dynamic> get onIdTokenChanged => const Stream.empty();

/// Firebase compatibility methods (simplified return types)
dynamic sendPasswordResetEmail(String email, {dynamic actionCodeSettings}) async {
  return null;
}

dynamic checkActionCode(String code) async {
  return null;
}

void confirmPasswordReset(String code, String newPassword) async {
  return;
}

void connectAuthEmulator(String host, int port, {bool? useSsl}) async {
  return;
}

dynamic createUserWithEmailAndPassword(String email, String password) async {
  throw StytchAuthException('Not implemented in stytch SDK');
}

dynamic createUserWithEmailAndPasswordUser(String email, String password) async {
  throw StytchAuthException('Not implemented in stytch SDK');
}

void reloadUser() async {
  return;
}

void sendEmailVerificationCode({dynamic actionCodeSettings}) async {
  return;
}

dynamic getAdditionalUserInfo(dynamic result) async {
  throw StytchAuthException('Not implemented in stytch SDK');
}

void linkProviderToUser(dynamic user, dynamic provider) async {
  return;
}

void initializeRecaptchaConfig(String recaptchaKey, {Map<String, dynamic>? config}) async {
  return;
}

bool isSignInWithEmailLink(String emailLink) {
  return false;
}

dynamic getMultiFactorResolver(dynamic exception) {
  return null;
}

bool sendSignInLinkToEmail(String email, dynamic actionCodeSettings) {
  return true;
}

bool signInWithEmailLink(String email, String emailLink) {
  return true;
}

dynamic signInWithPopup(dynamic provider) async {
  throw StytchAuthException('Not implemented in stytch SDK');
}

dynamic signUp(String email, String password) {
  throw StytchAuthException('Not implemented in stytch SDK');
}

void revokeToken(dynamic token) async {
  return;
}

void sendEmailVerificationCodeUser(dynamic user) async {
  return;
}

void verifyBeforeEmailUpdate(String email, {dynamic actionCodeSettings}) async {
  return;
}

/// Get stytch exception method (for compatibility)
dynamic stytchAuthException(dynamic exception) {
  if (exception is StytchException) return exception;
  return StytchAuthException(exception.toString());
}

/// Connect auth emulator method
Future<void> connectEmulator(String host, int port) async {
  return connectAuthEmulator(host, port);
}
}

/// Create a StytchAuth instance with lowercase function name
StytchAuth createStytchAuthInstance({
  required String apiKey,
  required String projectId,

  /// environment
  String environment = 'production',

  /// baseUrlOverride
  String baseUrlOverride = '',

  /// timeout
  Duration timeout = const Duration(seconds: 30),
}) {
  return StytchAuth(
    apiKey: apiKey,
    projectId: projectId,
    environment: environment,
    baseUrlOverride: baseUrlOverride,
    timeout: timeout,
  );
}

/// Type alias for Firebase compatibility
typedef stytchAuth = StytchAuth;

StytchAuth? _globalInstance;

/// Initialize the global stytch auth instance
void initializeStytch({
  required String apiKey,
  required String projectId,

  /// environment
  String environment = 'production',

  /// baseUrlOverride
  String baseUrlOverride = '',

  /// timeout
  Duration timeout = const Duration(seconds: 30),
}) {
  _globalInstance = StytchAuth(
    apiKey: apiKey,
    projectId: projectId,
    environment: environment,
    baseUrlOverride: baseUrlOverride,
    timeout: timeout,
  );
}

/// Initialize stytch from environment variables
void initializeStytchFromEnv() {
  _globalInstance = StytchAuth.fromEnvironmentVariables();
}

/// Get the global stytch auth instance
StytchAuth get stytchApp {
  return _globalInstance ??
      (throw const StytchConfigurationException(
        'StytchAuth has not been initialized. Call initializeStytch() first.',
      ));
}

/// Firebase-style stytch app wrapper with instance property
class _FirebaseStytchApp {
  static StytchAuth? _instance;

  /// Get the stytch auth instance (Firebase-style)
  static StytchAuth get instance => _instance ??
      (throw const StytchConfigurationException(
        'StytchAuth has not been initialized. Call initializeStytch() first.',
      ));

  /// Initialize the stytch auth instance (Firebase-style)
  static void initialize({
    required String apiKey,
    required String projectId,
    String environment = 'sandbox',
  }) {
    _instance = StytchAuth(
      apiKey: apiKey,
      projectId: projectId,
      environment: environment,
    );
  }
}

/// Global Firebase stytch app instance
_FirebaseStytchApp firebaseStytchApp = _FirebaseStytchApp();

/// Get the global stytch auth instance (for Flutter compatibility)
StytchAuth get stytchAuthInstance {
  return _FirebaseStytchApp.instance;
}

/// Initialize app with environment variables (Firebase-style)
Future<void> initializeAppWithEnvironmentVariables({
  required String apiKey,
  required String authDomain,
  required String projectId,
  required String messagingSenderId,
  required String bucketName,
  required String appId,
}) async {
  _FirebaseStytchApp.initialize(
    apiKey: apiKey,
    projectId: projectId,
    environment: 'sandbox',
  );
}

/// Initialize app with service account (Firebase-style)
Future<void> initializeAppWithServiceAccount({
  required String serviceAccountContent,
}) async {
  // For now, use mock values since we're not using real service accounts
  _FirebaseStytchApp.initialize(
    apiKey: 'mock_api_key',
    projectId: 'mock_project_id',
    environment: 'sandbox',
  );
}

/// Initialize app with service account impersonation (Firebase-style)
Future<void> initializeAppWithServiceAccountImpersonation({
  required String impersonatedEmail,
  required String serviceAccountContent,
}) async {
  _FirebaseStytchApp.initialize(
    apiKey: 'mock_api_key',
    projectId: 'mock_project_id',
    environment: 'sandbox',
  );
}

