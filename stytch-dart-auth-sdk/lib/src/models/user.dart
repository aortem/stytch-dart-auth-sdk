library user_models;

/// Models for user management in stytch B2B API

/// Request model for creating a user
class CreateUserRequest {
  /// String
  final String email;
  /// String?
  final String? name;
  /// String?
  final String? password;
  /// bool?
  final bool? isMfaEnabled;
  /// Map<String,
  final Map<String, dynamic>? attributes;
  /// String?
  final String? organizationId;

  /// CreateUserRequest(
  const CreateUserRequest({
    required this.email,
    this.name,
    this.password,
    this.isMfaEnabled,
    this.attributes,
    this.organizationId,
  });

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      if (name != null) 'name': name,
      if (password != null) 'password': password,
      if (isMfaEnabled != null) 'is_mfa_enabled': isMfaEnabled,
      if (attributes != null) 'attributes': attributes,
      if (organizationId != null) 'organization_id': organizationId,
    };
  }
}

/// Response model for user creation
class CreateUserResponse {
  /// String
  final String userId;
  /// String
  final String email;
  /// String?
  final String? name;
  /// bool
  final bool isMfaEnabled;
  /// Map<String,
  final Map<String, dynamic>? attributes;
  /// DateTime
  final DateTime createdAt;
  /// DateTime?
  final DateTime? updatedAt;

  /// CreateUserResponse(
  const CreateUserResponse({
    required this.userId,
    required this.email,
    this.name,
    required this.isMfaEnabled,
    this.attributes,
    required this.createdAt,
    this.updatedAt,
  });

  /// fromJson
  factory CreateUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserResponse(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      isMfaEnabled: json['is_mfa_enabled'] as bool,
      attributes: json['attributes'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      if (name != null) 'name': name,
      'is_mfa_enabled': isMfaEnabled,
      if (attributes != null) 'attributes': attributes,
      'created_at': createdAt.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }
}

/// Model for a user in stytch
class User {
  /// String
  final String userId;
  /// String
  final String email;
  /// String?
  final String? name;
  /// bool
  final bool isMfaEnabled;
  /// Map<String,
  final Map<String, dynamic>? attributes;
  /// DateTime
  final DateTime createdAt;
  /// DateTime?
  final DateTime? updatedAt;
  /// List<String>?
  final List<String>? organizationIds;

  /// User(
  const User({
    required this.userId,
    required this.email,
    this.name,
    required this.isMfaEnabled,
    this.attributes,
    required this.createdAt,
    this.updatedAt,
    this.organizationIds,
  });

  /// fromJson
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      isMfaEnabled: json['is_mfa_enabled'] as bool,
      attributes: json['attributes'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      organizationIds: json['organization_ids'] != null
          ? (json['organization_ids'] as List<dynamic>)
              .map((id) => id as String)
              .toList()
          : null,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      if (name != null) 'name': name,
      'is_mfa_enabled': isMfaEnabled,
      if (attributes != null) 'attributes': attributes,
      'created_at': createdAt.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      if (organizationIds != null) 'organization_ids': organizationIds,
    };
  }
}

/// Request model for updating a user
class UpdateUserRequest {
  /// String?
  final String? name;
  /// bool?
  final bool? isMfaEnabled;
  /// Map<String,
  final Map<String, dynamic>? attributes;

  /// UpdateUserRequest(
  const UpdateUserRequest({
    this.name,
    this.isMfaEnabled,
    this.attributes,
  });

  /// fromJson
  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    return UpdateUserRequest(
      name: json['name'] as String?,
      isMfaEnabled: json['is_mfa_enabled'] as bool?,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (isMfaEnabled != null) 'is_mfa_enabled': isMfaEnabled,
      if (attributes != null) 'attributes': attributes,
    };
  }
}

/// Response model for user updates
class UpdateUserResponse {
  /// User
  final User user;

  /// UpdateUserResponse(
  const UpdateUserResponse({required this.user});

  /// fromJson
  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
    };
  }
}

/// Request model for deleting a user
class DeleteUserRequest {
  /// String
  final String userId;

  /// DeleteUserRequest(
  const DeleteUserRequest({required this.userId});

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
    };
  }
}