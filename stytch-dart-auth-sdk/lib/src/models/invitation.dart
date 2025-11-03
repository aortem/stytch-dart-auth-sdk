/// Models for invitation management in stytch B2B API

/// Request model for sending an invitation
class SendInvitationRequest {
  final String email;
  final String? organizationId;
  final List<String>? organizationIds;
  final Map<String, dynamic>? attributes;
  final String? inviteRedirectUrl;
  final String? inviteTokenId;

  const SendInvitationRequest({
    required this.email,
    this.organizationId,
    this.organizationIds,
    this.attributes,
    this.inviteRedirectUrl,
    this.inviteTokenId,
  });

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
  final String invitationId;
  final String email;
  final String? organizationId;
  final String status;
  final DateTime expiresAt;
  final DateTime sentAt;

  const SendInvitationResponse({
    required this.invitationId,
    required this.email,
    this.organizationId,
    required this.status,
    required this.expiresAt,
    required this.sentAt,
  });

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
  final String invitationId;
  final String email;
  final String? organizationId;
  final String status;
  final DateTime expiresAt;
  final DateTime sentAt;
  final DateTime? acceptedAt;
  final Map<String, dynamic>? attributes;

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
  final String token;
  final String? password;
  final Map<String, dynamic>? attributes;

  const AcceptInvitationRequest({
    required this.token,
    this.password,
    this.attributes,
  });

  factory AcceptInvitationRequest.fromJson(Map<String, dynamic> json) {
    return AcceptInvitationRequest(
      token: json['token'] as String,
      password: json['password'] as String?,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

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
  final String userId;
  final String email;
  final String sessionId;
  final String sessionToken;
  final DateTime sessionExpiresAt;
  final List<String> organizationIds;

  const AcceptInvitationResponse({
    required this.userId,
    required this.email,
    required this.sessionId,
    required this.sessionToken,
    required this.sessionExpiresAt,
    required this.organizationIds,
  });

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
  final String invitationId;

  const CancelInvitationRequest({required this.invitationId});

  factory CancelInvitationRequest.fromJson(Map<String, dynamic> json) {
    return CancelInvitationRequest(
      invitationId: json['invitation_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invitation_id': invitationId,
    };
  }
}