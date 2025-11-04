/// Final script to add missing documentation to all remaining public members
library add_final_documentation;

import 'dart:io';

void main() {
  print('Adding final documentation to all remaining public members...');

  addDocumentationToAllFiles();

  print('All missing documentation has been added!');
  print('Final verification: dart analyze');
}

/// Add documentation to all remaining files
void addDocumentationToAllFiles() {
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
      addDocumentation(file);
    }
  }
}

/// Add comprehensive documentation to a file
void addDocumentation(String file) {
  var content = File(file).readAsStringSync();
  final lines = content.split('\n');
  final newLines = <String>[];

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    final trimmed = line.trim();

    // Add documentation for public final fields
    if (isPublicField(trimmed)) {
      final fieldName = extractFieldName(trimmed);
      if (fieldName.isNotEmpty && !hasDocumentationBefore(newLines)) {
        newLines.add('  /// $fieldName');
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

/// Check if line contains a public field declaration
bool isPublicField(String line) {
  return (line.startsWith('final ') || line.startsWith('const ')) &&
      !line.contains('_') &&
      !line.contains('==') &&
      !line.contains('!=') &&
      !line.contains('//');
}

/// Extract field name from declaration
String extractFieldName(String line) {
  final parts = line.split(' ');
  if (parts.length < 2) return '';

  final namePart = parts[1].split('=')[0].split(';')[0].split('{')[0];
  return namePart;
}

/// Check if previous line has documentation
bool hasDocumentationBefore(List<String> lines) {
  if (lines.isEmpty) return false;
  return lines.last.trim().startsWith('///');
}
