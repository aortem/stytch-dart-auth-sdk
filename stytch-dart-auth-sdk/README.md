# stytch Dart B2B Auth SDK

## Overview

The stytch Dart B2B Auth SDK provides a comprehensive and robust set of tools for implementing enterprise-grade authentication and authorization in Dart and Flutter applications. This SDK offers a complete implementation of the stytch B2B API with strong typing, async support, and comprehensive error handling.

## Features

- **🔐 Enterprise Authentication**: Email/password, SSO, and MFA authentication flows
- **👥 User Management**: Create, update, search, and manage user accounts
- **🏢 Organization Management**: Multi-tenant organization support with member management
- **✉️ Invitation System**: Send and manage user invitations to organizations
- **🎫 Session Management**: Secure session creation, validation, and revocation
- **⚡ Async/Await Support**: Full asynchronous programming with Dart Futures
- **🛡️ Type Safety**: Strongly typed request and response models
- **📊 Comprehensive Error Handling**: Detailed error types and handling
- **🌍 Multi-Environment**: Support for sandbox, development, and production environments

## Quick Start

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  stytch_dart_auth_sdk: ^0.1.0

dev_dependencies:
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
```

Run:

```bash
dart pub get
# or
flutter pub get
```

### Basic Usage

```dart
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() async {
  // Initialize the SDK
  final auth = stytchAuth(
    apiKey: 'YOUR_STYTCH_API_KEY',
    projectId: 'YOUR_PROJECT_ID',
    environment: 'sandbox', // or 'production'
  );

  try {
    // Create a user
    final userRequest = CreateUserRequest(
      email: 'user@example.com',
      name: 'John Doe',
      organizationId: 'org_123',
    );
    
    final user = await auth.user.createUser(userRequest);
    print('User created: ${user.email}');

    // Login with email and password
    final loginRequest = EmailPasswordLoginRequest(
      email: 'user@example.com',
      password: 'password123',
      organizationId: 'org_123',
    );

    final session = await auth.auth.loginWithEmailPassword(loginRequest);
    print('Logged in as: ${session.email}');

    // Validate session
    final sessionRequest = ValidateSessionRequest(
      sessionToken: session.sessionToken,
    );

    final isValid = await auth.auth.validateSession(sessionRequest);
    print('Session is valid: ${isValid.valid}');

  } catch (e) {
    print('Authentication error: $e');
  }
}
```

## Documentation

For detailed API documentation, examples, and guides, visit:
- **Documentation**: [GitBook](https://aortem.gitbook.io/stytch-dart-auth-admin-sdk/)
- **stytch B2B API**: [Official Documentation](https://stytch.com/docs/b2b)
