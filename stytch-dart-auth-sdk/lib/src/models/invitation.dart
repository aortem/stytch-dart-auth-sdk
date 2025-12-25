library invitation_models;

/// Models for invitation management in stytch B2B API

/// Request model for sending an invitation
class SendInvitationRequest {
  /// String
  final String email;

  /// String?
  final String? organizationId;

  /// List<String>?
  final List<String>? organizationIds;

  /// Map<String,
  final Map<String, dynamic>? attributes;

  /// String?
  final String? inviteRedirectUrl;

  /// String?
  final String? inviteTokenId;

  /// SendInvitationRequest(
  const SendInvitationRequest({
    required this.email,
    this.organizationId,
    this.organizationIds,
    this.attributes,
    this.inviteRedirectUrl,
    this.inviteTokenId,
  });

  /// fromJson
  factory SendInvitationRequest.fromJson(Map<String, dynamic> json) {
    return SendInvitationRequest(
      email: json['email'] as String,
      organizationId: json['organization_id'] as String?,
      organizationIds: json['organization_ids'] != null
          ? (json['organization_ids'] as List<dynamic>)
                .map((id) => id as String)
                .toList()
          : null,
      attributes: json['attributes'] as Map<String, dynamic>?,
      inviteRedirectUrl: json['invite_redirect_url'] as String?,
      inviteTokenId: json['invite_token_id'] as String?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      if (organizationId != null) 'organization_id': organizationId,
      if (organizationIds != null) 'organization_ids': organizationIds,
      if (attributes != null) 'attributes': attributes,
      if (inviteRedirectUrl != null) 'invite_redirect_url': inviteRedirectUrl,
      if (inviteTokenId != null) 'invite_token_id': inviteTokenId,
    };
  }
}

/// Response model for sending an invitation
class SendInvitationResponse {
  /// String
  final String invitationId;

  /// String
  final String email;

  /// String?
  final String? organizationId;

  /// String
  final String status;

  /// DateTime
  final DateTime expiresAt;

  /// DateTime
  final DateTime sentAt;

  /// SendInvitationResponse(
  const SendInvitationResponse({
    required this.invitationId,
    required this.email,
    this.organizationId,
    required this.status,
    required this.expiresAt,
    required this.sentAt,
  });

  /// fromJson
  factory SendInvitationResponse.fromJson(Map<String, dynamic> json) {
    return SendInvitationResponse(
      invitationId: json['invitation_id'] as String,
      email: json['email'] as String,
      organizationId: json['organization_id'] as String?,
      status: json['status'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      sentAt: DateTime.parse(json['sent_at'] as String),
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'invitation_id': invitationId,
      'email': email,
      if (organizationId != null) 'organization_id': organizationId,
      'status': status,
      'expires_at': expiresAt.toIso8601String(),
      'sent_at': sentAt.toIso8601String(),
    };
  }
}

/// Model for an invitation
class Invitation {
  /// String
  final String invitationId;

  /// String
  final String email;

  /// String?
  final String? organizationId;

  /// String
  final String status;

  /// DateTime
  final DateTime expiresAt;

  /// DateTime
  final DateTime sentAt;

  /// DateTime?
  final DateTime? acceptedAt;

  /// Map<String,
  final Map<String, dynamic>? attributes;

  /// Invitation(
  const Invitation({
    required this.invitationId,
    required this.email,
    this.organizationId,
    required this.status,
    required this.expiresAt,
    required this.sentAt,
    this.acceptedAt,
    this.attributes,
  });

  /// fromJson
  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      invitationId: json['invitation_id'] as String,
      email: json['email'] as String,
      organizationId: json['organization_id'] as String?,
      status: json['status'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      sentAt: DateTime.parse(json['sent_at'] as String),
      acceptedAt: json['accepted_at'] != null
          ? DateTime.parse(json['accepted_at'] as String)
          : null,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'invitation_id': invitationId,
      'email': email,
      if (organizationId != null) 'organization_id': organizationId,
      'status': status,
      'expires_at': expiresAt.toIso8601String(),
      'sent_at': sentAt.toIso8601String(),
      if (acceptedAt != null) 'accepted_at': acceptedAt!.toIso8601String(),
      if (attributes != null) 'attributes': attributes,
    };
  }
}

/// Request model for accepting an invitation
class AcceptInvitationRequest {
  /// String
  final String token;

  /// String?
  final String? password;

  /// Map<String,
  final Map<String, dynamic>? attributes;

  /// AcceptInvitationRequest(
  const AcceptInvitationRequest({
    required this.token,
    this.password,
    this.attributes,
  });

  /// fromJson
  factory AcceptInvitationRequest.fromJson(Map<String, dynamic> json) {
    return AcceptInvitationRequest(
      token: json['token'] as String,
      password: json['password'] as String?,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      if (password != null) 'password': password,
      if (attributes != null) 'attributes': attributes,
    };
  }
}

/// Response model for accepting an invitation
class AcceptInvitationResponse {
  /// String
  final String userId;

  /// String
  final String email;

  /// String
  final String sessionId;

  /// String
  final String sessionToken;

  /// DateTime
  final DateTime sessionExpiresAt;

  /// List<String>
  final List<String> organizationIds;

  /// AcceptInvitationResponse(
  const AcceptInvitationResponse({
    required this.userId,
    required this.email,
    required this.sessionId,
    required this.sessionToken,
    required this.sessionExpiresAt,
    required this.organizationIds,
  });

  /// fromJson
  factory AcceptInvitationResponse.fromJson(Map<String, dynamic> json) {
    return AcceptInvitationResponse(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      sessionId: json['session_id'] as String,
      sessionToken: json['session_token'] as String,
      sessionExpiresAt: DateTime.parse(json['session_expires_at'] as String),
      organizationIds: (json['organization_ids'] as List<dynamic>)
          .map((id) => id as String)
          .toList(),
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'session_id': sessionId,
      'session_token': sessionToken,
      'session_expires_at': sessionExpiresAt.toIso8601String(),
      'organization_ids': organizationIds,
    };
  }
}

/// Request model for canceling an invitation
class CancelInvitationRequest {
  /// String
  final String invitationId;

  /// CancelInvitationRequest(
  const CancelInvitationRequest({required this.invitationId});

  /// fromJson
  factory CancelInvitationRequest.fromJson(Map<String, dynamic> json) {
    return CancelInvitationRequest(
      invitationId: json['invitation_id'] as String,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {'invitation_id': invitationId};
  }
}
