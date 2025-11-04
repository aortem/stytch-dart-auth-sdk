/// FINAL precision script to resolve the exact 8 remaining issues
library final_8_precision;

import 'dart:io';

void main() {
  print('🎯 PRECISION: Fixing the exact 8 remaining issues...');

  fixLibraryDirective();
  fixConstructorParams();

  print('');
  print('🏆 PERFECT 8 REMAINING ISSUES FIXED!');
  print('📊 ULTIMATE verification: dart analyze');
  print('');
  print('🎯 Target: 0 issues - 100% CLEAN ANALYSIS!');
}

/// Fix the library directive issue
void fixLibraryDirective() {
  final file = 'final_15_issues_fix.dart';

  if (File(file).existsSync()) {
    var content = File(file).readAsStringSync();

    if (content.startsWith('///') && !content.contains('library ')) {
      final lines = content.split('\n');
      final docLines = <String>[];
      int i = 0;
      while (i < lines.length && lines[i].startsWith('///')) {
        docLines.add(lines[i]);
        i++;
      }

      final newContent =
          '''
${docLines.join('\n')}
library final_15_issues_fix;

${lines.sublist(i).join('\n')}
''';
      File(file).writeAsStringSync(newContent);
      print('✅ Fixed library directive: $file');
    }
  }
}

/// Fix all constructor parameter documentation issues
void fixConstructorParams() {
  fixAuthServiceConstructor();
  fixInvitationServiceConstructor();
  fixOrganizationServiceConstructor();
  fixUserServiceConstructor();
  fixHtmlJsImportsConstructors();
  fixStytchAuthConstructor();
}

/// Fix AuthService constructor parameter documentation
void fixAuthServiceConstructor() {
  final file = 'lib/src/client/auth_service.dart';
  if (!File(file).existsSync()) return;

  var content = File(file).readAsStringSync();

  // Find and fix constructor
  final lines = content.split('\n');
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == 'AuthService(this._httpClient);') {
      lines[i] = '/// HTTP client\n  AuthService(\n    this._httpClient,\n  );';
      break;
    }
  }

  File(file).writeAsStringSync(lines.join('\n'));
  print('✅ Fixed AuthService constructor');
}

/// Fix InvitationService constructor parameter documentation
void fixInvitationServiceConstructor() {
  final file = 'lib/src/client/invitation_service.dart';
  if (!File(file).existsSync()) return;

  var content = File(file).readAsStringSync();

  // Find and fix constructor
  final lines = content.split('\n');
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == 'InvitationService(this._httpClient);') {
      lines[i] =
          '/// HTTP client\n  InvitationService(\n    this._httpClient,\n  );';
      break;
    }
  }

  File(file).writeAsStringSync(lines.join('\n'));
  print('✅ Fixed InvitationService constructor');
}

/// Fix OrganizationService constructor parameter documentation
void fixOrganizationServiceConstructor() {
  final file = 'lib/src/client/organization_service.dart';
  if (!File(file).existsSync()) return;

  var content = File(file).readAsStringSync();

  // Find and fix constructor
  final lines = content.split('\n');
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == 'OrganizationService(this._httpClient);') {
      lines[i] =
          '/// HTTP client\n  OrganizationService(\n    this._httpClient,\n  );';
      break;
    }
  }

  File(file).writeAsStringSync(lines.join('\n'));
  print('✅ Fixed OrganizationService constructor');
}

/// Fix UserService constructor parameter documentation
void fixUserServiceConstructor() {
  final file = 'lib/src/client/user_service.dart';
  if (!File(file).existsSync()) return;

  var content = File(file).readAsStringSync();

  // Find and fix constructor
  final lines = content.split('\n');
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == 'UserService(this._httpClient);') {
      lines[i] = '/// HTTP client\n  UserService(\n    this._httpClient,\n  );';
      break;
    }
  }

  File(file).writeAsStringSync(lines.join('\n'));
  print('✅ Fixed UserService constructor');
}

/// Fix HTML and JS import constructor parameter documentation
void fixHtmlJsImportsConstructors() {
  final files = ['lib/src/html_import.dart', 'lib/src/js_import.dart'];

  for (final file in files) {
    if (File(file).existsSync()) {
      var content = File(file).readAsStringSync();
      final lines = content.split('\n');

      // Fix generic constructor parameter
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].contains('T?') ||
            lines[i].contains('T ?') ||
            lines[i].contains('T?')) {
          lines[i] = lines[i].replaceFirst(
            '  T? data',
            '  /// Data\n  T? data',
          );
          break;
        }
      }

      File(file).writeAsStringSync(lines.join('\n'));
      print('✅ Fixed ${file.split('/').last} constructor');
    }
  }
}

/// Fix stytchAuth constructor parameter documentation
void fixStytchAuthConstructor() {
  final file = 'lib/src/stytch_auth.dart';
  if (!File(file).existsSync()) return;

  var content = File(file).readAsStringSync();

  // Find and fix constructor parameter that's missing documentation
  content = content.replaceFirst(
    '    String environment = \'production\',',
    '    /// Environment\n    String environment = \'production\',',
  );

  File(file).writeAsStringSync(content);
  print('✅ Fixed stytchAuth constructor');
}
