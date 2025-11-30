<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/aortem/logos/main/Aortem-logo-small.png" />
    <img align="center" alt="Aortem Logo" src="https://raw.githubusercontent.com/aortem/logos/main/Aortem-logo-small.png" />
  </picture>
</p>

<!-- x-hide-in-docs-end -->
<p align="center" class="github-badges">
  <!-- Release Badge -->
  <a href="https://github.com/aortem/stytch_dart_auth_sdk/tags">
    <img alt="GitHub Tag" src="https://img.shields.io/static/v1?label=release&message=v0.0.1-pre+10&color=blue&style=for-the-badge" />
  </a>
  <!-- Dart-Specific Badges -->
  <a href="https://pub.dev/packages/stytch_dart_auth_sdk">
    <img alt="Pub Version" src="https://img.shields.io/pub/v/stytch_dart_auth_sdk.svg?style=for-the-badge" />
  </a>
  <a href="https://dart.dev/">
    <img alt="Built with Dart" src="https://img.shields.io/badge/Built%20with-Dart-blue.svg?style=for-the-badge" />
  </a>
<!-- x-hide-in-docs-start -->

# stytch Dart Admin Auth SDK

stytch Dart Admin Auth SDK is designed to provide select out of the box features of Amazon Stytch APIs in Dart. Both low level and high level abstractions are provided.

## Features
This implementation does not yet support all functionalities of the Stytch authentication service. Here is a list of functionalities with the current support status:

| Firebase Method                                                        | Amazon stytch Equivalent                       | Notes                                                                                  | Supported |
|--------------------------------------------------|------------------------------------------------|--------------------------------------------------------------------------------------- |-------------|
| `FirebaseAuth.signInWithEmailAndPassword()`      | stytch Admin: `AdminInitiateAuth`             | Authenticate user with email and password. Server-side API supports admin privileges.  | ✅         |
| `FirebaseAuth.createUserWithEmailAndPassword()`  | stytch Admin: `AdminCreateUser`               | Server-side method to create a new user in the user pool.                              | ✅         |
| `FirebaseAuth.signOut()`                         | Not Applicable                                 | stytch does not provide server-side logout; tokens must be invalidated by the client. | ❌         |
| `FirebaseAuth.setPersistence()`                  | Not Applicable                                 | Token persistence is a client-side feature.                                            | ❌         |
| `FirebaseAuth.sendPasswordResetEmail()`          | stytch Admin: `AdminResetUserPassword`        | Sends a reset password request to the user.                                            | ✅         |
| `FirebaseAuth.connectAuthEmulator`               | Not Applicable                                 | stytch does not support emulated authentication environments.                         | ❌         |

## Available Versions / Sample Apps

stytch Dart Admin Auth SDK is available in two versions to cater to different needs:

1. **Main - Stable Version**: Usually one release a month.  This version attempts to keep stability without introducing breaking changes.

2. **Pre-Release - Edge Version**: Provided as an early indication of a release when breaking changes are expect.  This release is inconsistent. Use only if you are looking to test new features.

## Documentation

For detailed guides, API references, and example projects, visit our [stytch Dart Admin Auth SDK Documentation](https://aortem.gitbook.io/stytch-dart-auth-admin-sdk). Start building with  stytch Dart Admin Auth SDK today and take advantage of its robust features and elegant syntax.

## Examples

Explore the `/example` directory in this repository to find sample applications demonstrating  stytch Dart Admin Auth SDK's capabilities in real-world scenarios.

## Contributing

We welcome contributions of all forms from the community! If you're interested in helping improve  stytch Dart Admin Auth SDK, please fork the repository and submit your pull requests. For more details, check out our [CONTRIBUTING.md](CONTRIBUTING.md) guide.  Our team will review your pull request. Once approved, we will integrate your changes into our primary repository and push the mirrored changes on the main github branch.

## Support

stytch Dart Admin Auth SDK offers various support tiers for our open-source products with an Initial Response Service Level Agreement (IRSLA):

### Community Support
- **Cost**: Free
- **Features**: Access to community forums, basic documentation.
- **Ideal for**: Individual developers or small startups.
- **SLA**: NA

### Standard Support
- **Cost**: $10/month - Billed Annually.
- **Features**: Extended documentation, email support, 10 business days response SLA.
- **Ideal for**: Growing startups and small businesses.
- **SLA**: 10 business days (Monday-Friday) IRSLANA
- [Subscribe-Coming Soon]()

### Enhanced Support
- **Cost**: $100/month - Billed Annually
- **Features**: Access to roadmap, 72-hour response SLA, feature request prioritization.
- **Ideal for**: Medium-sized enterprises requiring frequent support.
- **SLA**: 5 business days IRSLA
- [Subscribe-Coming Soon]()

### Enterprise Support
- **Cost**: 450/month
- **Features**: 
  - 48-hour response SLA, 
  - Access to beta features:
  - Comprehensive support for all Aortem Open Source products.
  - Premium access to our exclusive enterprise customer forum.
  - Early access to cutting-edge features.
  - Exclusive access to Partner/Reseller/Channel Program..
- **Ideal for**: Large organizations and enterprises with complex needs.
- **SLA**: 48-hour IRSLA
- [Subscribe-Coming Soon]()

*Enterprise Support is designed for businesses, agencies, and partners seeking top-tier support across a wide range of Dart backend and server-side projects.  All Open Source projects that are part of the Aortem Collective are included in the Enterprise subscription, with more projects being added soon.

## Licensing

All  stytch Dart Admin Auth SDK packages are licensed under BSD-3, except for the *services packages*, which uses the ELv2 license, which are licensed from third party software  Inc. In short, this means that you can, without limitation, use any of the client packages in your app as long as you do not offer the SDK's or services as a cloud service to 3rd parties (this is typically only relevant for cloud service providers).  See the [LICENSE](LICENSE.md) file for more details.

## Enhance with stytch Dart Admin Auth SDK

We hope the stytch Dart Admin Auth SDK helps you to efficiently build and scale your server-side applications. Join our growing community and start contributing to the ecosystem today!
