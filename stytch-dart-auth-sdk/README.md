# stytch Dart Admin Auth SDK

## Overview

The stytch Dart Admin Auth SDK offers a robust and flexible set of tools to perform authentication procedures within Dart or Flutter projects. This is a Dart implementation of stytch Authentication.

## Features:

- **User Management:** Manage user accounts seamlessly with a suite of comprehensive user management functionalities.
- **Custom Token Minting:** Integrate stytch authentication with your backend services by generating custom tokens.
- **Generating Email Action Links:** Perform authentication by creating and sending email action links to users emails for email verification, password reset, etc.
- **ID Token verification:** Verify ID tokens securely to ensure that application users are authenticated and authorised to use app.
- **Managing SAML/OIDC Provider Configuration**: Manage and configure SAML and ODIC providers to support authentication and simple sign-on solutions.

## Getting Started

If you want to use the stytch Dart Admin Auth SDK for implementing a stytch authentication in your Flutter projects follow the instructions on how to set up the auth SDK.

- Ensure you have a Flutter or Dart (3.4.x) SDK installed in your system.
- Set up a stytch project and service account.
- Set up a Flutter project.

## Installation

For Flutter use:

```javascript
flutter pub add stytch_dart_auth_sdk
```

You can manually edit your `pubspec.yaml `file this:

```yaml
dependencies:
  stytch_dart_auth_sdk: ^0.0.3
```

You can run a `flutter pub get` for Flutter respectively to complete installation.

**NB:** SDK version might vary.

## Usage

**Example:**

```
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:stytch/screens/splash_screen/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      // Initialize for web
      debugPrint('Initializing stytch for Web...');
      stytchApp.initializeAppWithEnvironmentVariables(
        apiKey: 'YOUR-API-KEY',
        projectId: 'YOUR-PROJECT-ID',
        bucketName: 'Your Bucket Name',
      );
      debugPrint('stytch initialized for Web.');
    } else {
      if (Platform.isAndroid || Platform.isIOS) {
        debugPrint('Initializing stytch for Mobile...');

        // Load the service account JSON
        String serviceAccountContent = await rootBundle.loadString(
          'assets/service_account.json',
        );
        debugPrint('Service account loaded.');

        // Initialize stytch with the service account content
        await stytchApp.initializeAppWithServiceAccount(
          serviceAccountContent: serviceAccountContent,
        );
        debugPrint('stytch initialized for Mobile.');
      }
    }

    // Access stytch Auth instance
    final auth = stytchApp.instance.getAuth();
    debugPrint('stytch Auth instance obtained.');

    runApp(const MyApp());
  } catch (e, stackTrace) {
    debugPrint('Error initializing stytch: $e');
    debugPrint('StackTrace: $stackTrace');
  }
}

```

- Import the package into your Dart or Flutter project:
  ```
  import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';
  ```
  For Flutter web initialize stytch app as follows:
  ```
  stytchApp.initializeAppWithEnvironmentVariables(
    apiKey: 'YOUR-API-KEY',
    projectId: 'YOUR-PROJECT-ID',
    bucketName: 'Your Bucket Name',
  );
  ```

- For Flutter mobile:
    - Load the service account JSON
    ```
       String serviceAccountContent = await rootBundle.loadString(
         'assets/service_account.json',
       );
    ```
    - Initialize Flutter mobile with service account content
    ```
      await stytchApp.initializeAppWithServiceAccount(
        serviceAccountContent: serviceAccountContent,
      );
    ```

- Access stytch Auth instance.
  ```
     final auth = stytchApp.instance.getAuth();
  ```
## Documentation

For more refer to Gitbook for prelease [documentation here](https://aortem.gitbook.io/stytch-dart-auth-admin-sdk/).
