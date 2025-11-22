## 0.0.1

### **Added**
* Added new example project scaffolding under the `stytch-dart-auth-sdk/example/` directory for multiple platforms (Flutter Web, Flutter Desktop, Flutter Games, Compose, Dart Web, and more).
* Added initial Firebase configuration files (`.firebaserc`, `firebase.json`, etc.) for the example applications.

### **Changed**
* Migrated all example app directories from the previous `cognito-dart-auth-sdk-*` naming to the new `stytch-dart-auth-sdk-*` naming convention for consistent Stytch branding.
* Updated internal imports and file paths inside example apps to reflect the new Stytch-based folder structure.
* Updated `.gitignore` to remove unused patterns and improve handling of generated files.
* Updated placeholder files and project metadata within the example applications for better clarity and accuracy.

### **Fixed**
* Fixed broken example app paths caused by outdated “cognito-” prefixes.
* Fixed references to the correct SDK entrypoints (e.g., `stytch_auth.dart`) across example apps.
* Fixed missing or misconfigured Firebase project references inside sample apps.

## 0.0.1-pre

- Initial pre-release version of the stytch Dart Auth SDK.

### **Changed**

* Updated internal project structure and file organization for better consistency across the SDK.
* Improved example app layout and artifact organization.

### **Fixed**

* Fixed several path inconsistencies that caused example project references to break.

## 0.0.1-pre

- Initial pre-release version of the stytch Dart Auth SDK.
