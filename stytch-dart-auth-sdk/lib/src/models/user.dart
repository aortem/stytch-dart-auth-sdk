/// Models for user management in stytch B2B API

/// Request model for creating a user
class CreateUserRequest {
  final String email;
  final String? name;
  final String? password;
  final bool? isMfaEnabled;
  final Map<String, dynamic>? attributes;
  final String? organizationId;

  const CreateUserRequest({
    required this.email,
    this.name,
    this.password,
    this.isMfaEnabled,
    this.attributes,
    this.organizationId,
  });

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
  final String userId;
  final String email;
  final String? name;
  final bool isMfaEnabled;
  final Map<String, dynamic>? attributes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const CreateUserResponse({
    required this.userId,
    required this.email,
    this.name,
    required this.isMfaEnabled,
    this.attributes,
    required this.createdAt,
    this.updatedAt,
  });

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
  final String userId;
  final String email;
  final String? name;
  final bool isMfaEnabled;
  final Map<String, dynamic>? attributes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String>? organizationIds;

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
  final String? name;
  final bool? isMfaEnabled;
  final Map<String, dynamic>? attributes;

  const UpdateUserRequest({
    this.name,
    this.isMfaEnabled,
    this.attributes,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    return UpdateUserRequest(
      name: json['name'] as String?,
      isMfaEnabled: json['is_mfa_enabled'] as bool?,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

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
  final User user;

  const UpdateUserResponse({required this.user});

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
    };
  }
}

/// Request model for deleting a user
class DeleteUserRequest {
  final String userId;

  const DeleteUserRequest({required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
    };
  }
}