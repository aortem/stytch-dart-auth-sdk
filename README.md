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

## **Comprehensive Feature Comparison**

| Method | Supported |
|--------|-----------|
| **Core Authentication Methods** |
| FirebaseAuth.signInWithEmailAndPassword | ✅ |
| FirebaseAuth.createUserWithEmailAndPassword | ✅ |
| FirebaseAuth.signOut | ❌ |
| FirebaseAuth.setPersistence | ❌ |
| FirebaseAuth.sendPasswordResetEmail | ✅ |
| FirebaseAuth.connectAuthEmulator | ❌ |
| **User Management** |
| FirebaseUser.updateEmail | ✅ |
| FirebaseUser.updatePassword | ✅ |
| FirebaseUser.deleteUser | ✅ |
| FirebaseUser.updateProfile | ✅ |
| FirebaseUser.sendEmailVerification | ❌ |
| FirebaseUser.reload | ✅ |
| FirebaseAuth.updateCurrentUser | ✅ |
| **Token Management** |
| FirebaseAuth.getIdToken | ✅ |
| FirebaseAuth.revokeAccessToken | ✅ |
| FirebaseAuth.signInWithCustomToken | ❌ |
| **Multi-Factor Authentication (MFA)** |
| FirebaseAuth.getMultiFactorResolver | ✅ |
| FirebaseUser.multiFactor | ✅ |
| FirebaseUser.reauthenticateWithCredential | ✅ |
| **Sign-In Methods** |
| FirebaseAuth.signInWithPopup | ❌ |
| FirebaseAuth.signInWithRedirect | ✅ |
| FirebaseAuth.signInWithPhoneNumber | ✅ |
| **Action Code Handling** |
| FirebaseAuth.applyActionCode | ❌ |
| FirebaseAuth.checkActionCode | ❌ |
| FirebaseAuth.verifyPasswordResetCode | ✅ |
| **Enterprise Features** |
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

## Available Versions

Stytch Dart Admin Auth SDK is available in two versions to cater to different needs:

1. **Main - Stable Version**: Usually one release a month. This version attempts to keep stability without introducing breaking changes.
2. **Pre-Release - Edge Version**: Provided as an early indication of a release when breaking changes are expected. This release is inconsistent. Use only if you are looking to test new features.

## Documentation

For detailed guides, API references, and example projects, visit our [Stytch Dart Admin Auth SDK Documentation](https://aortem.gitbook.io/stytch-dart-auth-admin-sdk). Start building with Stytch Dart Admin Auth SDK today and take advantage of its robust features and elegant syntax.

## Examples

Explore the `/example` directory in this repository to find sample applications demonstrating Stytch Dart Admin Auth SDK's capabilities in real-world scenarios.

## Contributing

We welcome contributions of all forms from the community! If you're interested in helping improve Stytch Dart Admin Auth SDK, please fork the repository and submit your pull requests. For more details, check out our [CONTRIBUTING.md](CONTRIBUTING.md) guide. Our team will review your pull request. Once approved, we will integrate your changes into our primary repository and push the mirrored changes on the main github branch.

## Support Tiers

Stytch Dart Admin Auth SDK offers various support tiers for our open-source products with an Initial Response Service Level Agreement (IRSLA):

### Community Support
- **Cost**: Free
- **Features**: Access to community forums, basic documentation.
- **Ideal for**: Individual developers or small startups.
- **SLA**: NA

### Standard Support
- **Cost**: $10/month - Billed Annually.
- **Features**: Extended documentation, email support, 10 business days response SLA.
- **Ideal for**: Growing startups and small businesses.
- **SLA**: 10 business days (Monday-Friday) IRSLA
- [Subscribe-Coming Soon]()

### Enhanced Support
- **Cost**: $100/month - Billed Annually
- **Features**: Access to roadmap, 72-hour response SLA, feature request prioritization.
- **Ideal for**: Medium-sized enterprises requiring frequent support.
- **SLA**: 5 business days IRSLA
- [Subscribe-Coming Soon]()

### Enterprise Support
- **Cost**: $450/month
- **Features**: 
  - 48-hour response SLA
  - Access to beta features
  - Comprehensive support for all Aortem Open Source products
  - Premium access to our exclusive enterprise customer forum
  - Early access to cutting-edge features
  - Exclusive access to Partner/Reseller/Channel Program
- **Ideal for**: Large organizations and enterprises with complex needs.
- **SLA**: 48-hour IRSLA
- [Subscribe-Coming Soon]()

*Enterprise Support is designed for businesses, agencies, and partners seeking top-tier support across a wide range of Dart backend and server-side projects. All Open Source projects that are part of the Aortem Collective are included in the Enterprise subscription, with more projects being added soon.

## Licensing

All Stytch Dart Admin Auth SDK packages are licensed under BSD-3, except for the *services packages*, which uses the ELv2 license, which are licensed from third party software Inc. In short, this means that you can, without limitation, use any of the client packages in your app as long as you do not offer the SDK's or services as a cloud service to 3rd parties (this is typically only relevant for cloud service providers). See the [LICENSE](LICENSE.md) file for more details.

## Enhance with Stytch Dart Admin Auth SDK

We hope the Stytch Dart Admin Auth SDK helps you to efficiently build and scale your server-side applications. Join our growing community and start contributing to the ecosystem today!