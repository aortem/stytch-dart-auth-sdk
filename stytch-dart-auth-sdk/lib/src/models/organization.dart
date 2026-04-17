library organization_models;

/// Models for organization management in stytch B2B API

/// Request model for creating an organization
class CreateOrganizationRequest {
  /// String
  final String name;

  /// String?
  final String? slug;

  /// `List<String>?`
  final List<String>? allowedDomains;

  /// Map<String,
  final Map<String, dynamic>? attributes;

  /// `List<String>?`
  final List<String>? ssoMethods;

  /// CreateOrganizationRequest(
  const CreateOrganizationRequest({
    required this.name,
    this.slug,
    this.allowedDomains,
    this.attributes,
    this.ssoMethods,
  });

  /// fromJson
  factory CreateOrganizationRequest.fromJson(Map<String, dynamic> json) {
    return CreateOrganizationRequest(
      name: json['name'] as String,
      slug: json['slug'] as String?,
      allowedDomains: json['allowed_domains'] != null
          ? (json['allowed_domains'] as List<dynamic>)
                .map((domain) => domain as String)
                .toList()
          : null,
      attributes: json['attributes'] as Map<String, dynamic>?,
      ssoMethods: json['sso_methods'] != null
          ? (json['sso_methods'] as List<dynamic>)
                .map((method) => method as String)
                .toList()
          : null,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (slug != null) 'slug': slug,
      if (allowedDomains != null) 'allowed_domains': allowedDomains,
      if (attributes != null) 'attributes': attributes,
      if (ssoMethods != null) 'sso_methods': ssoMethods,
    };
  }
}

/// Response model for organization creation
class CreateOrganizationResponse {
  /// String
  final String organizationId;

  /// String
  final String name;

  /// String
  final String slug;

  /// `List<String>`
  final List<String> allowedDomains;

  /// Map<String,
  final Map<String, dynamic> attributes;

  /// `List<String>`
  final List<String> ssoMethods;

  /// DateTime
  final DateTime createdAt;

  /// CreateOrganizationResponse(
  const CreateOrganizationResponse({
    required this.organizationId,
    required this.name,
    required this.slug,
    required this.allowedDomains,
    required this.attributes,
    required this.ssoMethods,
    required this.createdAt,
  });

  /// fromJson
  factory CreateOrganizationResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrganizationResponse(
      organizationId: json['organization_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      allowedDomains: (json['allowed_domains'] as List<dynamic>)
          .map((domain) => domain as String)
          .toList(),
      attributes: json['attributes'] as Map<String, dynamic>,
      ssoMethods: (json['sso_methods'] as List<dynamic>)
          .map((method) => method as String)
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'organization_id': organizationId,
      'name': name,
      'slug': slug,
      'allowed_domains': allowedDomains,
      'attributes': attributes,
      'sso_methods': ssoMethods,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

/// Model for an organization
class Organization {
  /// String
  final String organizationId;

  /// String
  final String name;

  /// String
  final String slug;

  /// `List<String>`
  final List<String> allowedDomains;

  /// Map<String,
  final Map<String, dynamic> attributes;

  /// `List<String>`
  final List<String> ssoMethods;

  /// DateTime
  final DateTime createdAt;

  /// DateTime?
  final DateTime? updatedAt;

  /// Organization(
  const Organization({
    required this.organizationId,
    required this.name,
    required this.slug,
    required this.allowedDomains,
    required this.attributes,
    required this.ssoMethods,
    required this.createdAt,
    this.updatedAt,
  });

  /// fromJson
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      organizationId: json['organization_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      allowedDomains: (json['allowed_domains'] as List<dynamic>)
          .map((domain) => domain as String)
          .toList(),
      attributes: json['attributes'] as Map<String, dynamic>,
      ssoMethods: (json['sso_methods'] as List<dynamic>)
          .map((method) => method as String)
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'organization_id': organizationId,
      'name': name,
      'slug': slug,
      'allowed_domains': allowedDomains,
      'attributes': attributes,
      'sso_methods': ssoMethods,
      'created_at': createdAt.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }
}

/// Request model for updating an organization
class UpdateOrganizationRequest {
  /// String?
  final String? name;

  /// String?
  final String? slug;

  /// `List<String>?`
  final List<String>? allowedDomains;

  /// Map<String,
  final Map<String, dynamic>? attributes;

  /// `List<String>?`
  final List<String>? ssoMethods;

  /// UpdateOrganizationRequest(
  const UpdateOrganizationRequest({
    this.name,
    this.slug,
    this.allowedDomains,
    this.attributes,
    this.ssoMethods,
  });

  /// fromJson
  factory UpdateOrganizationRequest.fromJson(Map<String, dynamic> json) {
    return UpdateOrganizationRequest(
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      allowedDomains: json['allowed_domains'] != null
          ? (json['allowed_domains'] as List<dynamic>)
                .map((domain) => domain as String)
                .toList()
          : null,
      attributes: json['attributes'] as Map<String, dynamic>?,
      ssoMethods: json['sso_methods'] != null
          ? (json['sso_methods'] as List<dynamic>)
                .map((method) => method as String)
                .toList()
          : null,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (allowedDomains != null) 'allowed_domains': allowedDomains,
      if (attributes != null) 'attributes': attributes,
      if (ssoMethods != null) 'sso_methods': ssoMethods,
    };
  }
}

/// Response model for organization updates
class UpdateOrganizationResponse {
  /// Organization
  final Organization organization;

  /// UpdateOrganizationResponse(
  const UpdateOrganizationResponse({required this.organization});

  /// fromJson
  factory UpdateOrganizationResponse.fromJson(Map<String, dynamic> json) {
    return UpdateOrganizationResponse(
      organization: Organization.fromJson(
        json['organization'] as Map<String, dynamic>,
      ),
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {'organization': organization.toJson()};
  }
}
