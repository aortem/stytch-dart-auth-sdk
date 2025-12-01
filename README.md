<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/aortem/logos/main/Aortem-logo-small.png" />
    <img align="center" alt="Aortem Logo" src="https://raw.githubusercontent.com/aortem/logos/main/Aortem-logo-small.png" />
  </picture>
</p>

<!-- x-hide-in-docs-end -->
<p align="center" class="github-badges">
  <!-- Release Badge -->
  <a href="https://github.com/aortem/firebase-dart-admin-auth-sdk/tags">
    <img alt="GitHub Tag" src="https://img.shields.io/github/v/tag/aortem/firebase-dart-admin-auth-sdk?style=for-the-badge" />
  </a>
  <!-- Dart-Specific Badges -->
  <a href="https://pub.dev/packages/firebase_dart_admin_auth_sdk">
    <img alt="Pub Version" src="https://img.shields.io/pub/v/firebase_dart_admin_auth_sdk.svg?style=for-the-badge" />
  </a>
  <a href="https://dart.dev/">
    <img alt="Built with Dart" src="https://img.shields.io/badge/Built%20with-Dart-blue.svg?style=for-the-badge" />
  </a>
<!-- x-hide-in-docs-start -->

# Firebase vs Amazon Stytch for Server-Side Dart SDK

This document provides a high-level comparison of Firebase Authentication and Amazon Stytch features tailored for building a server-side Dart SDK. The goal is to evaluate how a server-side Dart SDK could integrate Amazon Stytch and compare its capabilities to Firebase Authentication.

## **Features**

| Method | Supported |
|--------|-----------|
| FirebaseAuth.signInWithEmailAndPassword | ✅ |
| FirebaseAuth.createUserWithEmailAndPassword | ✅ |
| FirebaseAuth.signOut | ❌ |
| FirebaseAuth.setPersistence | ❌ |
| FirebaseAuth.sendPasswordResetEmail | ✅ |
| FirebaseAuth.connectAuthEmulator | ❌ |
| FirebaseUser.updateEmail | ✅ |
| FirebaseUser.updatePassword | ✅ |
| FirebaseUser.deleteUser | ✅ |
| FirebaseUser.updateProfile | ✅ |
| FirebaseUser.sendEmailVerification | ❌ |
| FirebaseUser.reload | ✅ |
| FirebaseAuth.updateCurrentUser | ✅ |
| FirebaseAuth.getIdToken | ✅ |
| FirebaseAuth.revokeAccessToken | ✅ |
| FirebaseAuth.signInWithCustomToken | ❌ |
| FirebaseAuth.getMultiFactorResolver | ✅ |
| FirebaseUser.multiFactor | ✅ |
| FirebaseUser.reauthenticateWithCredential | ✅ |
| FirebaseAuth.signInWithPopup | ❌ |
| FirebaseAuth.signInWithRedirect | ✅ |
| FirebaseAuth.signInWithPhoneNumber | ✅ |
| FirebaseAuth.applyActionCode | ❌ |
| FirebaseAuth.checkActionCode | ❌ |
| FirebaseAuth.verifyPasswordResetCode | ✅ |
| User Pool Groups | ✅ |
| Lambda Triggers | ✅ |
| Hosted UI | ✅ |
| Advanced Security | ✅ |
| Identity Federation | ✅ |

## **Key Differences Between Firebase and Amazon Stytch**

1. **Server-Side Capabilities:** Amazon Stytch provides robust server-side APIs (e.g., Admin APIs), while Firebase is primarily client-focused.
2. **Enterprise Features:** Stytch supports advanced features like Lambda triggers and adaptive authentication, which are absent in Firebase.
3. **Custom Token Support:** Firebase enables custom token generation for integration with external systems, while Stytch lacks this feature.

## **Next Steps**

1. Design the Dart SDK for server-side integration with Amazon Stytch Admin APIs.
2. Implement key features such as user management, MFA, and token management.
3. Provide documentation and examples to facilitate adoption for both mobile and web developers.

Let me know if you'd like to explore specific areas further!

## Available Versions / Sample Apps
Stytch Dart Admin Auth SDK is available in a single version with sample apps:

1. **Main - Stable Version**: Usually one release a month. This version attempts to keep stability without introducing breaking changes.

2. **Sample Apps - FrontEnd Version**: The sample apps are provided in various frontend languages in order to allow maximum flexibility with your frontend implementation with the Dart backend. Note that new features are first tested in the sample apps before being released in the mainline branch. Use only as a guide for your frontend/backend implementation of Dart.

## Documentation
For detailed guides, API references, and example projects, visit our [Stytch Dart Auth SDK Documentation](https://sdks.aortem.io/stytch-dart-auth-sdk/). Start building with Stytch Dart Admin Auth SDK today and take advantage of its robust features and elegant syntax.

## Examples
Explore the `/example` directory in this repository to find sample applications demonstrating Stytch Dart Admin Auth SDK's capabilities in real-world scenarios.

## Contributing
We welcome contributions of all forms from the community! If you're interested in helping improve Stytch Dart Admin Auth SDK, please fork the repository and submit your pull requests. For more details, check out our [CONTRIBUTING.md](CONTRIBUTING.md) guide. Our team will review your pull request. Once approved, we will integrate your changes into our primary repository and push the mirrored changes on the main github branch.

## Support
For support across all Aortem open-source products, including this SDK, visit our [Support Page](https://www.aortem.io/support).

## Licensing
The **Stytch Dart Auth SDK** is licensed under a dual-license approach:

1. **BSD-3 License**:
   * Applies to all packages and libraries in the SDK.
   * Allows use, modification, and redistribution, provided that credit is given and compliance with the BSD-3 terms is maintained.
   * Permits usage in open-source projects, applications, and private deployments.

2. **Enhanced License Version 2 (ELv2)**:
   * Applies to all use cases where the SDK or its derivatives are offered as part of a cloud service.
   * This ensures that the SDK cannot be directly used by cloud providers to offer competing services without explicit permission.
   * Example restricted use cases:
      * Including the SDK in a hosted SaaS authentication platform.
      * Offering the SDK as a component of a managed cloud service.

## Summary
* You are free to use the SDK in your applications, including open-source and commercial projects, as long as the SDK is not directly offered as part of a third-party cloud service.
* For details, refer to the [LICENSE](LICENSE) file.

## Enhance with Stytch Dart Auth SDK
We hope the Stytch Dart Admin Auth SDK helps you to efficiently build and scale your server-side applications. Join our growing community and start contributing to the ecosystem today!