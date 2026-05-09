library invitation_models;

/// Models for invitation management in stytch B2B API

/// Request model for sending an invitation
class SendInvitationRequest {
  /// String
  final String email;

  /// String?
  final String? organizationId;

  /// `List<String>?`
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

/// Request model for sending an invite Email Magic Link.
class SendInviteEmailRequest {
  /// Organization identifier, slug, or external ID.
  final String organizationId;

  /// Email address of the member to invite.
  final String emailAddress;

  /// Redirect URL used after the invite magic link is clicked.
  final String? inviteRedirectUrl;

  /// Member ID of the member sending the invite.
  final String? invitedByMemberId;

  /// Optional invited member name.
  final String? name;

  /// Trusted metadata to attach to the invited member.
  final Map<String, dynamic>? trustedMetadata;

  /// Untrusted metadata to attach to the invited member.
  final Map<String, dynamic>? untrustedMetadata;

  /// Optional custom invite email template ID.
  final String? inviteTemplateId;

  /// Optional IETF BCP 47 locale such as `en`, `es`, `fr`, or `pt-br`.
  final String? locale;

  /// Roles to assign to the invited member.
  final List<String>? roles;

  /// Invite magic-link expiration in minutes.
  final int? inviteExpirationMinutes;

  /// SendInviteEmailRequest
  SendInviteEmailRequest({
    required this.organizationId,
    required this.emailAddress,
    this.inviteRedirectUrl,
    this.invitedByMemberId,
    this.name,
    this.trustedMetadata,
    this.untrustedMetadata,
    this.inviteTemplateId,
    this.locale,
    this.roles,
    this.inviteExpirationMinutes,
  }) {
    final trimmedOrganizationId = organizationId.trim();
    final trimmedEmail = emailAddress.trim();
    if (trimmedOrganizationId.isEmpty) {
      throw ArgumentError('Organization ID cannot be empty.');
    }
    if (trimmedEmail.isEmpty) {
      throw ArgumentError('Email address cannot be empty.');
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(trimmedEmail)) {
      throw ArgumentError('Email address is invalid.');
    }
    if (inviteExpirationMinutes != null && inviteExpirationMinutes! < 0) {
      throw ArgumentError('Invite expiration minutes cannot be negative.');
    }
  }

  /// fromJson
  factory SendInviteEmailRequest.fromJson(Map<String, dynamic> json) {
    return SendInviteEmailRequest(
      organizationId: json['organization_id'] as String,
      emailAddress: json['email_address'] as String,
      inviteRedirectUrl: json['invite_redirect_url'] as String?,
      invitedByMemberId: json['invited_by_member_id'] as String?,
      name: json['name'] as String?,
      trustedMetadata: json['trusted_metadata'] as Map<String, dynamic>?,
      untrustedMetadata: json['untrusted_metadata'] as Map<String, dynamic>?,
      inviteTemplateId: json['invite_template_id'] as String?,
      locale: json['locale'] as String?,
      roles: json['roles'] != null
          ? (json['roles'] as List<dynamic>)
                .map((role) => role as String)
                .toList()
          : null,
      inviteExpirationMinutes: json['invite_expiration_minutes'] as int?,
    );
  }

  /// Converts the request to the Stytch API payload.
  Map<String, dynamic> toJson() {
    return {
      'organization_id': organizationId.trim(),
      'email_address': emailAddress.trim(),
      if (inviteRedirectUrl != null) 'invite_redirect_url': inviteRedirectUrl,
      if (invitedByMemberId != null) 'invited_by_member_id': invitedByMemberId,
      if (name != null) 'name': name,
      if (trustedMetadata != null) 'trusted_metadata': trustedMetadata,
      if (untrustedMetadata != null) 'untrusted_metadata': untrustedMetadata,
      if (inviteTemplateId != null) 'invite_template_id': inviteTemplateId,
      if (locale != null) 'locale': locale,
      if (roles != null) 'roles': roles,
      if (inviteExpirationMinutes != null)
        'invite_expiration_minutes': inviteExpirationMinutes,
    };
  }
}

/// Response model for sending an invite Email Magic Link.
class SendInviteEmailResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Globally unique member ID for the invited member.
  final String memberId;

  /// Raw Stytch member object.
  final Map<String, dynamic> member;

  /// Raw Stytch organization object.
  final Map<String, dynamic> organization;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// SendInviteEmailResponse
  const SendInviteEmailResponse({
    required this.requestId,
    required this.memberId,
    required this.member,
    required this.organization,
    required this.statusCode,
  });

  /// fromJson
  factory SendInviteEmailResponse.fromJson(Map<String, dynamic> json) {
    return SendInviteEmailResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      member: Map<String, dynamic>.from(json['member'] as Map),
      organization: Map<String, dynamic>.from(json['organization'] as Map),
      statusCode: json['status_code'] as int,
    );
  }

  /// Converts the response to JSON.
  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'member_id': memberId,
      'member': member,
      'organization': organization,
      'status_code': statusCode,
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

  /// `List<String>`
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
