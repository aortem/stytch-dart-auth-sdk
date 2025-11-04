/// Compatibility layer for Firebase ActionCode functionality
library action_code;

import 'dart:async';

/// Mock ActionCodeInfo class for Firebase compatibility
///
/// Represents information about an action code, providing type and data
/// details for Firebase action code verification compatibility.
class ActionCodeInfo {
  /// The type of action code (email sign-in, password reset, etc.)
  final String type;

  /// Additional data associated with the action code
  final Map<String, dynamic>? data;

  /// Creates an ActionCodeInfo instance
  ///
  /// [type] - The action code type
  /// [data] - Optional action code data
  const ActionCodeInfo({required this.type, this.data});
}

/// Mock ActionCodeSettings class for Firebase compatibility
///
/// Configuration settings for action code handling, providing URL
/// and platform-specific options for Firebase action code behavior.
class ActionCodeSettings {
  /// Optional URL to redirect to after action completion
  final String? url;

  /// Whether to handle the code within the app
  final String? handleCodeInApp;

  /// Dynamic link domain for cross-platform handling
  final String? dynamicLinkDomain;

  /// Android package name for mobile app handling
  final String? androidPackageName;

  /// iOS bundle identifier for mobile app handling
  final String? iOSBundleId;

  /// Whether to install the app if not present
  final int? installApp;

  /// Creates an ActionCodeSettings instance
  ///
  /// [url] - Optional redirect URL
  /// [handleCodeInApp] - Whether to handle code in app
  /// [dynamicLinkDomain] - Dynamic link domain
  /// [androidPackageName] - Android package name
  /// [iOSBundleId] - iOS bundle identifier
  /// [installApp] - Whether to install app
  const ActionCodeSettings({
    this.url,
    this.handleCodeInApp,
    this.dynamicLinkDomain,
    this.androidPackageName,
    this.iOSBundleId,
    this.installApp,
  });
}

/// Check action code for Firebase compatibility
///
/// Provides Firebase-style action code verification while using
/// stytch B2B SDK for the underlying authentication logic.
///
/// [code] - The action code to check
/// Returns action code information
Future<ActionCodeInfo> checkActionCode(String code) async {
  // Mock implementation
  return ActionCodeInfo(
    type: 'emailSignIn',
    data: {'email': 'user@example.com'},
  );
}
