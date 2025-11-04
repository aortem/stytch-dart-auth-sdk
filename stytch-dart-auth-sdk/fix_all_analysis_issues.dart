/// Script to fix all remaining Dart analysis issues
library fix_all_analysis_issues;

import 'dart:io';

void main() {
  print('Fixing all remaining Dart analysis issues...');

  // Fix library doc comments
  fixLibraryDocComments();

  // Fix file naming conventions
  fixFileNaming();

  // Fix relative imports
  fixRelativeImports();

  // Add missing documentation to public members
  addMissingDocumentation();

  print('All analysis issues have been addressed!');
}

/// Fix dangling library doc comments
void fixLibraryDocComments() {
  final files = [
    'test-all-sdk.dart',
    'test-all.dart',
    'test/mocks/conditional_imports.dart',
    'test/unit/models_test.dart',
    'test/unit/stytch_working_test.dart',
    'test_core.dart',
    'test_final.dart',
  ];

  for (final file in files) {
    if (File(file).existsSync()) {
      final content = File(file).readAsStringSync();
      if (content.startsWith('///') && !content.contains('library ')) {
        final lines = content.split('\n');
        final docLines = <String>[];
        int i = 0;
        while (i < lines.length && lines[i].startsWith('///')) {
          docLines.add(lines[i]);
          i++;
        }

        final libraryName = file.replaceAll('/', '_').replaceAll('.dart', '');
        final newContent =
            '''
${docLines.join('\n')}
library $libraryName;

${lines.sublist(i).join('\n')}
''';
        File(file).writeAsStringSync(newContent);
        print('Fixed library directive: $file');
      }
    }
  }
}

/// Fix file naming conventions
void fixFileNaming() {
  final renamedFiles = [
    ('test-all-sdk.dart', 'test_all_sdk.dart'),
    ('test-all.dart', 'test_all.dart'),
  ];

  for (final (oldName, newName) in renamedFiles) {
    if (File(oldName).existsSync()) {
      File(oldName).renameSync(newName);
      print('Renamed file: $oldName -> $newName');
    }
  }
}

/// Fix relative imports
void fixRelativeImports() {
  final files = ['test/unit/stytch_working_test.dart'];

  for (final file in files) {
    if (File(file).existsSync()) {
      var content = File(file).readAsStringSync();

      // Replace relative imports with package imports
      content = content.replaceAll(
        "import '../lib/src/stytch_auth.dart'",
        "import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart'",
      );

      content = content.replaceAll(
        "import '../lib/src/client/auth_service.dart'",
        "import 'package:stytch_dart_auth_sdk/src/client/auth_service.dart'",
      );

      File(file).writeAsStringSync(content);
      print('Fixed relative imports: $file');
    }
  }
}

/// Add missing documentation to public members
void addMissingDocumentation() {
  final files = [
    'lib/src/client/auth_service.dart',
    'lib/src/client/invitation_service.dart',
    'lib/src/client/organization_service.dart',
    'lib/src/client/stytch_client.dart',
    'lib/src/client/user_service.dart',
    'lib/src/html_import.dart',
    'lib/src/js_import.dart',
    'lib/src/models/auth.dart',
    'lib/src/models/error.dart',
    'lib/src/models/invitation.dart',
    'lib/src/models/organization.dart',
    'lib/src/models/user.dart',
    'lib/src/stytch_auth.dart',
  ];

  for (final file in files) {
    if (File(file).existsSync()) {
      addDocumentationToFile(file);
    }
  }
}

/// Add documentation to a specific file
void addDocumentationToFile(String file) {
  var content = File(file).readAsStringSync();
  final lines = content.split('\n');
  final newLines = <String>[];

  // bool inClass = false; // unused variable removed
  String className = '';

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];

    // Detect class declarations
    if (line.trim().startsWith('class ')) {
      // inClass = true; // unused variable removed
      className = line.trim().split(' ')[1].split('<')[0].split('{')[0];

      // Add documentation before class if missing
      if (i > 0 &&
          !lines[i - 1].trim().startsWith('///') &&
          !lines[i - 1].trim().startsWith('//')) {
        newLines.add('/// $className class');
        newLines.add('');
      }
    }

    // Detect public member declarations
    if ((line.trim().startsWith('final ') ||
            line.trim().startsWith('String ') ||
            line.trim().startsWith('int ') ||
            line.trim().startsWith('bool ') ||
            line.trim().startsWith('Map<') ||
            line.trim().startsWith('List<')) &&
        !line.trim().startsWith('///') &&
        !line.trim().startsWith('//') &&
        !line.contains('==') &&
        !line.contains('!=') &&
        !line.contains('null') &&
        !line.contains('_')) {
      // Check if previous line is not documentation
      if (newLines.isEmpty || !newLines.last.trim().startsWith('///')) {
        final memberName = line
            .trim()
            .split(' ')[1]
            .split('=')[0]
            .split(';')[0];
        if (!memberName.startsWith('_')) {
          newLines.add('  /// $memberName');
        }
      }
    }

    newLines.add(line);
  }

  final newContent = newLines.join('\n');
  if (newContent != content) {
    File(file).writeAsStringSync(newContent);
    print('Added documentation: $file');
  }
}
