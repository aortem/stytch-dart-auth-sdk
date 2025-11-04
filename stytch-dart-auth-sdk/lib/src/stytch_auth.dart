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
    final environment = _getEnvVar('STYTCH_ENVIRONMENT').isEmpty ? 'production' : _getEnvVar('STYTCH_ENVIRONMENT');
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
}

/// Create a StytchAuth instance with lowercase function name
StytchAuth stytchAuth({
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
  return _globalInstance ?? (throw const StytchConfigurationException(
    'StytchAuth has not been initialized. Call initializeStytch() first.',
  ));
}
