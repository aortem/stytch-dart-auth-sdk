import 'dart:io';

void main() async {
  final testDir = Directory('test/unit/auth');
  final files = await testDir.list().toList();

  for (final file in files) {
    if (file is File && file.path.endsWith('_test.dart')) {
      print('Processing: ${file.path}');
      String content = await file.readAsString();

      // Replace ds_tools_testing with test
      content = content.replaceAll(
        "import 'package:ds_tools_testing/ds_tools_testing.dart';",
        "import 'package:test/test.dart';",
      );

      // Add library directive if not present
      if (!content.startsWith('library ')) {
        final fileName = file.uri.pathSegments.last.replaceAll('.dart', '');
        content = 'library $fileName;\n\n$content';
      }

      await file.writeAsString(content);
      print('Fixed: ${file.path}');
    }
  }

  print('All test files have been updated!');
}
