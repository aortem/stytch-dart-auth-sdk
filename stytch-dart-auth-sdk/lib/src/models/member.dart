library member_models;

/// Models for Stytch B2B organization members.

/// Request model for creating a member.
class CreateMemberRequest {
  /// Member email address.
  final String emailAddress;

  /// Optional member display name.
  final String? name;

  /// Optional external ID.
  final String? externalId;

  /// Optional MFA phone number.
  final String? mfaPhoneNumber;

  /// Whether the member is enrolled in MFA.
  final bool? mfaEnrolled;

  /// Optional trusted metadata.
  final Map<String, dynamic>? trustedMetadata;

  /// Optional untrusted metadata.
  final Map<String, dynamic>? untrustedMetadata;

  /// Optional roles.
  final List<String>? roles;

  /// Whether to create the member as pending.
  final bool? createMemberAsPending;

  /// Whether the member is a break-glass user.
  final bool? isBreakglass;

  /// CreateMemberRequest
  CreateMemberRequest({
    required this.emailAddress,
    this.name,
    this.externalId,
    this.mfaPhoneNumber,
    this.mfaEnrolled,
    this.trustedMetadata,
    this.untrustedMetadata,
    this.roles,
    this.createMemberAsPending,
    this.isBreakglass,
  }) {
    if (emailAddress.trim().isEmpty) {
      throw ArgumentError('Email address cannot be empty.');
    }
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'email_address': emailAddress.trim(),
      if (name != null) 'name': name,
      if (externalId != null) 'external_id': externalId,
      if (mfaPhoneNumber != null) 'mfa_phone_number': mfaPhoneNumber,
      if (mfaEnrolled != null) 'mfa_enrolled': mfaEnrolled,
      if (trustedMetadata != null) 'trusted_metadata': trustedMetadata,
      if (untrustedMetadata != null) 'untrusted_metadata': untrustedMetadata,
      if (roles != null) 'roles': roles,
      if (createMemberAsPending != null)
        'create_member_as_pending': createMemberAsPending,
      if (isBreakglass != null) 'is_breakglass': isBreakglass,
    };
  }
}

/// Request model for updating a member.
class UpdateMemberRequest {
  /// Optional member display name.
  final String? name;

  /// Optional external ID.
  final String? externalId;

  /// Optional MFA phone number.
  final String? mfaPhoneNumber;

  /// Whether the member is enrolled in MFA.
  final bool? mfaEnrolled;

  /// Optional trusted metadata.
  final Map<String, dynamic>? trustedMetadata;

  /// Optional untrusted metadata.
  final Map<String, dynamic>? untrustedMetadata;

  /// Optional roles.
  final List<String>? roles;

  /// Whether the member is a break-glass user.
  final bool? isBreakglass;

  /// Whether to preserve sessions affected by role changes.
  final bool? preserveExistingSessions;

  /// Member default MFA method.
  final String? defaultMfaMethod;

  /// Optional updated email address.
  final String? emailAddress;

  /// Whether to delete the previous email instead of retiring it.
  final bool? unlinkEmail;

  /// UpdateMemberRequest
  const UpdateMemberRequest({
    this.name,
    this.externalId,
    this.mfaPhoneNumber,
    this.mfaEnrolled,
    this.trustedMetadata,
    this.untrustedMetadata,
    this.roles,
    this.isBreakglass,
    this.preserveExistingSessions,
    this.defaultMfaMethod,
    this.emailAddress,
    this.unlinkEmail,
  });

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (externalId != null) 'external_id': externalId,
      if (mfaPhoneNumber != null) 'mfa_phone_number': mfaPhoneNumber,
      if (mfaEnrolled != null) 'mfa_enrolled': mfaEnrolled,
      if (trustedMetadata != null) 'trusted_metadata': trustedMetadata,
      if (untrustedMetadata != null) 'untrusted_metadata': untrustedMetadata,
      if (roles != null) 'roles': roles,
      if (isBreakglass != null) 'is_breakglass': isBreakglass,
      if (preserveExistingSessions != null)
        'preserve_existing_sessions': preserveExistingSessions,
      if (defaultMfaMethod != null) 'default_mfa_method': defaultMfaMethod,
      if (emailAddress != null) 'email_address': emailAddress,
      if (unlinkEmail != null) 'unlink_email': unlinkEmail,
    };
  }
}

/// Request model for searching members.
class SearchMembersRequest {
  /// Organization IDs to search.
  final List<String> organizationIds;

  /// Optional Stytch query object.
  final Map<String, dynamic>? query;

  /// Optional limit.
  final int? limit;

  /// Optional cursor.
  final String? cursor;

  /// SearchMembersRequest
  SearchMembersRequest({
    required this.organizationIds,
    this.query,
    this.limit,
    this.cursor,
  }) {
    if (organizationIds.isEmpty) {
      throw ArgumentError('At least one organization ID is required.');
    }
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'organization_ids': organizationIds,
      if (query != null) 'query': query,
      if (limit != null) 'limit': limit,
      if (cursor != null) 'cursor': cursor,
    };
  }
}

/// Request model for unlinking a retired member email.
class UnlinkRetiredMemberEmailRequest {
  /// Retired email ID.
  final String? emailId;

  /// Retired email address.
  final String? emailAddress;

  /// UnlinkRetiredMemberEmailRequest
  UnlinkRetiredMemberEmailRequest({this.emailId, this.emailAddress}) {
    if ((emailId == null || emailId!.trim().isEmpty) &&
        (emailAddress == null || emailAddress!.trim().isEmpty)) {
      throw ArgumentError('Email ID or email address is required.');
    }
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      if (emailId != null) 'email_id': emailId!.trim(),
      if (emailAddress != null) 'email_address': emailAddress!.trim(),
    };
  }
}

/// Response model for member endpoints returning a member.
class MemberResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member ID returned by Stytch.
  final String memberId;

  /// Member object returned by Stytch.
  final Map<String, dynamic> member;

  /// Organization object returned by Stytch.
  final Map<String, dynamic>? organization;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// MemberResponse
  const MemberResponse({
    required this.requestId,
    required this.memberId,
    required this.member,
    this.organization,
    required this.statusCode,
  });

  /// fromJson
  factory MemberResponse.fromJson(Map<String, dynamic> json) {
    return MemberResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      member: json['member'] as Map<String, dynamic>,
      organization: json['organization'] as Map<String, dynamic>?,
      statusCode: json['status_code'] as int,
    );
  }

  /// dynamic>
  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'member_id': memberId,
      'member': member,
      if (organization != null) 'organization': organization,
      'status_code': statusCode,
    };
  }
}

/// Response model for deleting a member.
class DeleteMemberResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Deleted member ID.
  final String memberId;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// DeleteMemberResponse
  const DeleteMemberResponse({
    required this.requestId,
    required this.memberId,
    required this.statusCode,
  });

  /// fromJson
  factory DeleteMemberResponse.fromJson(Map<String, dynamic> json) {
    return DeleteMemberResponse(
      requestId: json['request_id'] as String,
      memberId: json['member_id'] as String,
      statusCode: json['status_code'] as int,
    );
  }
}

/// Response metadata for paginated member search.
class MemberSearchMetadata {
  /// Total matching records.
  final int? total;

  /// Cursor for the next page.
  final String? nextCursor;

  /// MemberSearchMetadata
  const MemberSearchMetadata({this.total, this.nextCursor});

  /// fromJson
  factory MemberSearchMetadata.fromJson(Map<String, dynamic> json) {
    return MemberSearchMetadata(
      total: json['total'] as int?,
      nextCursor: json['next_cursor'] as String?,
    );
  }
}

/// Response model for searching members.
class SearchMembersResponse {
  /// Globally unique request ID returned by Stytch.
  final String requestId;

  /// Member objects returned by Stytch.
  final List<Map<String, dynamic>> members;

  /// Search metadata returned by Stytch.
  final MemberSearchMetadata resultsMetadata;

  /// Organizations object returned by Stytch.
  final Map<String, dynamic> organizations;

  /// HTTP status code returned by Stytch.
  final int statusCode;

  /// SearchMembersResponse
  const SearchMembersResponse({
    required this.requestId,
    required this.members,
    required this.resultsMetadata,
    required this.organizations,
    required this.statusCode,
  });

  /// fromJson
  factory SearchMembersResponse.fromJson(Map<String, dynamic> json) {
    return SearchMembersResponse(
      requestId: json['request_id'] as String,
      members: (json['members'] as List<dynamic>)
          .map((member) => member as Map<String, dynamic>)
          .toList(),
      resultsMetadata: MemberSearchMetadata.fromJson(
        json['results_metadata'] as Map<String, dynamic>,
      ),
      organizations: json['organizations'] as Map<String, dynamic>,
      statusCode: json['status_code'] as int,
    );
  }
}
