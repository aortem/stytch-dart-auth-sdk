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
class stytchAuth {
  final StytchConfig _config;
  late final StytchHttpClient _httpClient;

  late final AuthService _authService;
  late final UserService _userService;
  late final OrganizationService _organizationService;
  late final InvitationService _invitationService;

  stytchAuth({
    required String apiKey,
    required String projectId,
    String environment = 'production',
    String baseUrlOverride = '',
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

  /// Create a stytchAuth instance from environment variables
  factory stytchAuth.fromEnvironmentVariables() {
    final apiKey = _getEnvVar('STYTCH_API_KEY');
    final projectId = _getEnvVar('STYTCH_PROJECT_ID');
    final environment = _getEnvVar('STYTCH_ENVIRONMENT') ?? 'production';
    final baseUrlOverride = _getEnvVar('STYTCH_BASE_URL') ?? '';
    final timeoutSeconds = int.tryParse(_getEnvVar('STYTCH_TIMEOUT') ?? '30');

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

    return stytchAuth(
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

  static String _getProdEnvVar(String name) {
    return Platform.environment[name] ?? '';
  }

  static String _getDevEnvVar(String name) {
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

/// Global stytch auth instance
stytchAuth? _globalInstance;

/// Initialize the global stytch auth instance
void initializeStytch({
  required String apiKey,
  required String projectId,
  String environment = 'production',
  String baseUrlOverride = '',
  Duration timeout = const Duration(seconds: 30),
}) {
  _globalInstance = stytchAuth(
    apiKey: apiKey,
    projectId: projectId,
    environment: environment,
    baseUrlOverride: baseUrlOverride,
    timeout: timeout,
  );
}

/// Initialize stytch from environment variables
void initializeStytchFromEnv() {
  _globalInstance = stytchAuth.fromEnvironmentVariables();
}

/// Get the global stytch auth instance
stytchAuth get stytchApp {
  return _globalInstance ?? (throw const StytchConfigurationException(
    'stytchAuth has not been initialized. Call initializeStytch() first.',
  ));
}
