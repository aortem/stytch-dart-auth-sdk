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
      'organization_name': name,
      if (slug != null) 'organization_slug': slug,
      if (allowedDomains != null) 'email_allowed_domains': allowedDomains,
      if (attributes != null) 'trusted_metadata': attributes,
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
    final organizationJson =
        (json['organization'] as Map<String, dynamic>?) ?? json;
    final organization = Organization.fromJson(organizationJson);
    return CreateOrganizationResponse(
      organizationId: organization.organizationId,
      name: organization.name,
      slug: organization.slug,
      allowedDomains: organization.allowedDomains,
      attributes: organization.attributes,
      ssoMethods: organization.ssoMethods,
      createdAt: organization.createdAt,
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
      name: (json['organization_name'] ?? json['name']) as String,
      slug: (json['organization_slug'] ?? json['slug']) as String,
      allowedDomains: _stringList(
        json['email_allowed_domains'] ?? json['allowed_domains'],
      ),
      attributes:
          (json['trusted_metadata'] ?? json['attributes'] ?? {})
              as Map<String, dynamic>,
      ssoMethods: _stringList(
        json['sso_methods'] ?? json['sso_active_connections'],
      ),
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
      'organization_name': name,
      'organization_slug': slug,
      'email_allowed_domains': allowedDomains,
      'trusted_metadata': attributes,
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
      if (name != null) 'organization_name': name,
      if (slug != null) 'organization_slug': slug,
      if (allowedDomains != null) 'email_allowed_domains': allowedDomains,
      if (attributes != null) 'trusted_metadata': attributes,
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

/// Response model for deleting an organization.
class DeleteOrganizationResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Deleted organization ID.
  final String organizationId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// DeleteOrganizationResponse
  const DeleteOrganizationResponse({
    required this.requestId,
    required this.organizationId,
    required this.statusCode,
  });

  /// fromJson
  factory DeleteOrganizationResponse.fromJson(Map<String, dynamic> json) {
    return DeleteOrganizationResponse(
      requestId: json['request_id'] as String,
      organizationId: json['organization_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'organization_id': organizationId,
      'status_code': statusCode,
    };
  }
}

/// Response model for organization search pagination metadata.
class SearchOrganizationsMetadata {
  /// Total matching organizations reported by Stytch.
  final int? total;

  /// Cursor for the next page of results.
  final String? nextCursor;

  /// SearchOrganizationsMetadata
  const SearchOrganizationsMetadata({this.total, this.nextCursor});

  /// fromJson
  factory SearchOrganizationsMetadata.fromJson(Map<String, dynamic> json) {
    return SearchOrganizationsMetadata(
      total: json['total'] as int?,
      nextCursor: json['next_cursor'] as String?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (total != null) 'total': total,
      if (nextCursor != null) 'next_cursor': nextCursor,
    };
  }
}

/// Response model for searching organizations.
class SearchOrganizationsResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Organizations returned by the search.
  final List<Organization> organizations;

  /// Pagination metadata returned by Stytch.
  final SearchOrganizationsMetadata resultsMetadata;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// SearchOrganizationsResponse
  const SearchOrganizationsResponse({
    required this.requestId,
    required this.organizations,
    required this.resultsMetadata,
    required this.statusCode,
  });

  /// fromJson
  factory SearchOrganizationsResponse.fromJson(Map<String, dynamic> json) {
    final orgsJson = json['organizations'] as List<dynamic>;
    return SearchOrganizationsResponse(
      requestId: json['request_id'] as String,
      organizations: orgsJson
          .map(
            (orgJson) => Organization.fromJson(orgJson as Map<String, dynamic>),
          )
          .toList(),
      resultsMetadata: SearchOrganizationsMetadata.fromJson(
        (json['results_metadata'] as Map<String, dynamic>?) ?? {},
      ),
      statusCode: json['status_code'] as int,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'organizations': organizations.map((org) => org.toJson()).toList(),
      'results_metadata': resultsMetadata.toJson(),
      'status_code': statusCode,
    };
  }
}

List<String> _stringList(Object? value) {
  if (value == null) return const [];
  return (value as List<dynamic>).map((item) {
    if (item is String) return item;
    final map = item as Map<String, dynamic>;
    return (map['identity_provider'] ?? map['connection_id']) as String;
  }).toList();
}
