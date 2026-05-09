library m2m_models;

/// Models for Stytch M2M APIs.

/// Request model for creating an M2M client.
class CreateM2mClientRequest {
  /// Scopes assigned to the client.
  final List<String> scopes;

  /// Optional imported client ID.
  final String? clientId;

  /// Optional imported client secret.
  final String? clientSecret;

  /// Human-readable client name.
  final String? clientName;

  /// Human-readable client description.
  final String? clientDescription;

  /// Trusted metadata payload.
  final Map<String, dynamic>? trustedMetadata;

  /// CreateM2mClientRequest
  CreateM2mClientRequest({
    required this.scopes,
    this.clientId,
    this.clientSecret,
    this.clientName,
    this.clientDescription,
    this.trustedMetadata,
  }) {
    if (scopes.isEmpty) {
      throw ArgumentError('At least one scope is required.');
    }
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'scopes': scopes,
      if (clientId != null) 'client_id': clientId,
      if (clientSecret != null) 'client_secret': clientSecret,
      if (clientName != null) 'client_name': clientName,
      if (clientDescription != null) 'client_description': clientDescription,
      if (trustedMetadata != null) 'trusted_metadata': trustedMetadata,
    };
  }
}

/// Request model for searching M2M clients.
class SearchM2mClientsRequest {
  /// Search query.
  final Map<String, dynamic>? query;

  /// Result limit.
  final int? limit;

  /// Pagination cursor.
  final String? cursor;

  /// SearchM2mClientsRequest
  const SearchM2mClientsRequest({this.query, this.limit, this.cursor});

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (query != null) 'query': query,
      if (limit != null) 'limit': limit,
      if (cursor != null) 'cursor': cursor,
    };
  }
}

/// Request model for updating an M2M client.
class UpdateM2mClientRequest {
  /// Scopes assigned to the client.
  final List<String>? scopes;

  /// Human-readable client name.
  final String? clientName;

  /// Human-readable client description.
  final String? clientDescription;

  /// Trusted metadata payload.
  final Map<String, dynamic>? trustedMetadata;

  /// UpdateM2mClientRequest
  const UpdateM2mClientRequest({
    this.scopes,
    this.clientName,
    this.clientDescription,
    this.trustedMetadata,
  });

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (scopes != null) 'scopes': scopes,
      if (clientName != null) 'client_name': clientName,
      if (clientDescription != null) 'client_description': clientDescription,
      if (trustedMetadata != null) 'trusted_metadata': trustedMetadata,
    };
  }
}

/// Response model for M2M client endpoints.
class M2mClientResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// M2M client payload.
  final Map<String, dynamic> m2mClient;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// M2mClientResponse
  const M2mClientResponse({
    required this.requestId,
    required this.m2mClient,
    required this.statusCode,
  });

  /// fromJson
  factory M2mClientResponse.fromJson(Map<String, dynamic> json) {
    return M2mClientResponse(
      requestId: json['request_id'] as String,
      m2mClient: Map<String, dynamic>.from(json['m2m_client'] as Map),
      statusCode: json['status_code'] as int,
    );
  }
}

/// Response model for searching M2M clients.
class SearchM2mClientsResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// M2M clients returned by Stytch.
  final List<Map<String, dynamic>> m2mClients;

  /// Results metadata.
  final Map<String, dynamic>? resultsMetadata;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// SearchM2mClientsResponse
  const SearchM2mClientsResponse({
    required this.requestId,
    required this.m2mClients,
    this.resultsMetadata,
    required this.statusCode,
  });

  /// fromJson
  factory SearchM2mClientsResponse.fromJson(Map<String, dynamic> json) {
    return SearchM2mClientsResponse(
      requestId: json['request_id'] as String,
      m2mClients: (json['m2m_clients'] as List<dynamic>)
          .map((client) => Map<String, dynamic>.from(client as Map))
          .toList(),
      resultsMetadata: json['results_metadata'] != null
          ? Map<String, dynamic>.from(json['results_metadata'] as Map)
          : null,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Response model for deleting an M2M client.
class DeleteM2mClientResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Deleted client ID.
  final String clientId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// DeleteM2mClientResponse
  const DeleteM2mClientResponse({
    required this.requestId,
    required this.clientId,
    required this.statusCode,
  });

  /// fromJson
  factory DeleteM2mClientResponse.fromJson(Map<String, dynamic> json) {
    return DeleteM2mClientResponse(
      requestId: json['request_id'] as String,
      clientId: json['client_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}
