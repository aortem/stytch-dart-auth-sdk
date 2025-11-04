/// Compatibility layer for Firebase AuthCredential functionality
library credential;

import 'dart:async';

/// Mock AuthCredential class for Firebase compatibility
/// 
/// This class provides compatibility with Firebase Auth credentials
/// while using the stytch B2B SDK backend.
class AuthCredential {
  /// The authentication provider identifier
  final String provider;
  
  /// The sign-in method used
  final String? signInMethod;
  
  /// Additional provider-specific parameters
  final Map<String, dynamic>? parameters;

  /// Creates an AuthCredential instance
  /// 
  /// [provider] - The provider identifier
  /// [signInMethod] - Optional sign-in method
  /// [parameters] - Optional provider parameters
  const AuthCredential({
    required this.provider,
    this.signInMethod,
    this.parameters,
  });
}

/// Mock OAuthCredential class for Firebase compatibility
/// 
/// Extends AuthCredential with OAuth-specific properties like access tokens
/// and provider IDs for OAuth-based authentication flows.
class OAuthCredential extends AuthCredential {
  /// OAuth access token
  final String? accessToken;
  
  /// OAuth ID token
  final String? idToken;
  
  /// OAuth secret (for some providers)
  final String? secret;
  
  /// OAuth provider identifier
  final String? providerId;

  /// Creates an OAuthCredential instance
  /// 
  /// [providerId] - The OAuth provider ID
  /// [accessToken] - Optional access token
  /// [idToken] - Optional ID token
  /// [secret] - Optional secret
  /// [parameters] - Optional provider parameters
  const OAuthCredential({
    this.providerId,
    this.accessToken,
    this.idToken,
    this.secret,
    Map<String, dynamic>? parameters,
  }) : super(
          provider: providerId ?? 'oauth',
          parameters: parameters,
        );

  /// Provider getter for Firebase compatibility
  /// 
  /// Returns the provider ID or fallback to 'oauth'
  String get provider => providerId ?? 'oauth';
}

/// Mock UserCredential class for Firebase compatibility
/// 
/// Represents the result of a sign-in operation, containing the credential,
/// user information, and additional details about the authentication.
class UserCredential {
  /// The credential used for authentication
  final AuthCredential? credential;
  
  /// The authenticated user
  final dynamic user;
  
  /// Additional information about the user from the provider
  final Map<String, dynamic>? additionalUserInfo;

  /// Creates a UserCredential instance
  /// 
  /// [credential] - The authentication credential
  /// [user] - The authenticated user
  /// [additionalUserInfo] - Additional provider-specific user info
  const UserCredential({
    this.credential,
    this.user,
    this.additionalUserInfo,
  });
}

/// Mock AdditionalUserInfo class for Firebase compatibility
/// 
/// Contains additional information about the user obtained during authentication,
/// such as provider profile data and whether this is a new user.
class AdditionalUserInfo {
  /// Provider-specific profile data
  final Map<String, dynamic>? profile;
  
  /// The provider identifier
  final String? providerId;
  
  /// Whether this is a new user registration
  final bool isNewUser;

  /// Creates an AdditionalUserInfo instance
  /// 
  /// [profile] - Provider profile data
  /// [providerId] - Provider identifier
  /// [isNewUser] - Whether this is a new user (defaults to false)
  const AdditionalUserInfo({
    this.profile,
    this.providerId,
    this.isNewUser = false,
  });

  /// Creates an AdditionalUserInfo instance from JSON
  factory AdditionalUserInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalUserInfo(
      profile: json['profile'] as Map<String, dynamic>?,
      providerId: json['providerId'] as String?,
      isNewUser: json['isNewUser'] as bool? ?? false,
    );
  }

  /// Converts this instance to JSON
  Map<String, dynamic> toJson() {
    return {
      if (profile != null) 'profile': profile,
      if (providerId != null) 'providerId': providerId,
      'isNewUser': isNewUser,
    };
  }
}

/// Mock StytchAuthException class for compatibility
/// 
/// Exception class that mimics Firebase Auth exceptions while providing
/// compatibility with stytch authentication errors.
class StytchAuthException implements Exception {
  /// The error code
  final String code;
  
  /// The error message
  final String message;

  /// Creates a StytchAuthException instance
  /// 
  /// [code] - The error code
  /// [message] - The error message
  const StytchAuthException({
    required this.code,
    required this.message,
  });

  @override
  String toString() => 'StytchAuthException: $message';
}