/// Compatibility layer for Firebase Storage functionality
library storage;

import 'dart:async';
import 'dart:typed_data';

/// Mock StytchStorage class for Firebase compatibility
///
/// This class provides compatibility with Firebase Storage while using
/// stytch B2B SDK for authentication and user management.
class StytchStorage {
  /// Creates a StytchStorage instance
  const StytchStorage();

  /// Mock getData method
  ///
  /// Returns placeholder data for Firebase compatibility
  /// [path] - The storage path
  /// Returns mock data as bytes
  Future<Uint8List> getData(String path) async {
    return Uint8List.fromList([
      0x66,
      0x69,
      0x72,
      0x65,
      0x62,
      0x61,
      0x73,
      0x65,
    ]); // "firebase"
  }

  /// Mock getDownloadURL method
  ///
  /// Returns a mock download URL for Firebase compatibility
  /// [path] - The storage path
  /// Returns a mock download URL
  Future<String> getDownloadURL(String path) async {
    return 'https://mock-storage.example.com/$path';
  }

  /// Mock getMetadata method
  ///
  /// Returns mock metadata for Firebase compatibility
  /// [path] - The storage path
  /// Returns mock metadata
  Future<MockFileMetadata> getMetadata(String path) async {
    return MockFileMetadata(
      path: path,
      size: 1024,
      contentType: 'application/octet-stream',
      updated: DateTime.now(),
    );
  }

  /// Mock delete method
  ///
  /// Mock implementation for Firebase compatibility
  /// [path] - The storage path to delete
  Future<void> delete(String path) async {
    // Mock implementation - no actual deletion
  }
}

/// Mock FileMetadata class for Firebase compatibility
///
/// Represents metadata for files in storage, including size,
/// content type, and modification time.
class MockFileMetadata {
  /// The file path
  final String path;

  /// The file size in bytes
  final int size;

  /// The content type/MIME type
  final String contentType;

  /// Last modified date
  final DateTime updated;

  /// Creates a MockFileMetadata instance
  ///
  /// [path] - File path
  /// [size] - File size in bytes
  /// [contentType] - MIME type
  /// [updated] - Last modification time
  const MockFileMetadata({
    required this.path,
    required this.size,
    required this.contentType,
    required this.updated,
  });
}
