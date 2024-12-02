// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUser200Response extends GetUser200Response {
  @override
  final bool? cORPConfirmed;
  @override
  final bool? rSIConfirmed;
  @override
  final String? rSIHandle;
  @override
  final String? rSIVerificationToken;
  @override
  final bool? disabled;
  @override
  final bool? enabled2fa;
  @override
  final String? picture;
  @override
  final BuiltList<GetUser200ResponseRolesInner>? roles;
  @override
  final int? securityLevel;

  factory _$GetUser200Response(
          [void Function(GetUser200ResponseBuilder)? updates]) =>
      (new GetUser200ResponseBuilder()..update(updates))._build();

  _$GetUser200Response._(
      {this.cORPConfirmed,
      this.rSIConfirmed,
      this.rSIHandle,
      this.rSIVerificationToken,
      this.disabled,
      this.enabled2fa,
      this.picture,
      this.roles,
      this.securityLevel})
      : super._();

  @override
  GetUser200Response rebuild(
          void Function(GetUser200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUser200ResponseBuilder toBuilder() =>
      new GetUser200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUser200Response &&
        cORPConfirmed == other.cORPConfirmed &&
        rSIConfirmed == other.rSIConfirmed &&
        rSIHandle == other.rSIHandle &&
        rSIVerificationToken == other.rSIVerificationToken &&
        disabled == other.disabled &&
        enabled2fa == other.enabled2fa &&
        picture == other.picture &&
        roles == other.roles &&
        securityLevel == other.securityLevel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cORPConfirmed.hashCode);
    _$hash = $jc(_$hash, rSIConfirmed.hashCode);
    _$hash = $jc(_$hash, rSIHandle.hashCode);
    _$hash = $jc(_$hash, rSIVerificationToken.hashCode);
    _$hash = $jc(_$hash, disabled.hashCode);
    _$hash = $jc(_$hash, enabled2fa.hashCode);
    _$hash = $jc(_$hash, picture.hashCode);
    _$hash = $jc(_$hash, roles.hashCode);
    _$hash = $jc(_$hash, securityLevel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetUser200Response')
          ..add('cORPConfirmed', cORPConfirmed)
          ..add('rSIConfirmed', rSIConfirmed)
          ..add('rSIHandle', rSIHandle)
          ..add('rSIVerificationToken', rSIVerificationToken)
          ..add('disabled', disabled)
          ..add('enabled2fa', enabled2fa)
          ..add('picture', picture)
          ..add('roles', roles)
          ..add('securityLevel', securityLevel))
        .toString();
  }
}

class GetUser200ResponseBuilder
    implements Builder<GetUser200Response, GetUser200ResponseBuilder> {
  _$GetUser200Response? _$v;

  bool? _cORPConfirmed;
  bool? get cORPConfirmed => _$this._cORPConfirmed;
  set cORPConfirmed(bool? cORPConfirmed) =>
      _$this._cORPConfirmed = cORPConfirmed;

  bool? _rSIConfirmed;
  bool? get rSIConfirmed => _$this._rSIConfirmed;
  set rSIConfirmed(bool? rSIConfirmed) => _$this._rSIConfirmed = rSIConfirmed;

  String? _rSIHandle;
  String? get rSIHandle => _$this._rSIHandle;
  set rSIHandle(String? rSIHandle) => _$this._rSIHandle = rSIHandle;

  String? _rSIVerificationToken;
  String? get rSIVerificationToken => _$this._rSIVerificationToken;
  set rSIVerificationToken(String? rSIVerificationToken) =>
      _$this._rSIVerificationToken = rSIVerificationToken;

  bool? _disabled;
  bool? get disabled => _$this._disabled;
  set disabled(bool? disabled) => _$this._disabled = disabled;

  bool? _enabled2fa;
  bool? get enabled2fa => _$this._enabled2fa;
  set enabled2fa(bool? enabled2fa) => _$this._enabled2fa = enabled2fa;

  String? _picture;
  String? get picture => _$this._picture;
  set picture(String? picture) => _$this._picture = picture;

  ListBuilder<GetUser200ResponseRolesInner>? _roles;
  ListBuilder<GetUser200ResponseRolesInner> get roles =>
      _$this._roles ??= new ListBuilder<GetUser200ResponseRolesInner>();
  set roles(ListBuilder<GetUser200ResponseRolesInner>? roles) =>
      _$this._roles = roles;

  int? _securityLevel;
  int? get securityLevel => _$this._securityLevel;
  set securityLevel(int? securityLevel) =>
      _$this._securityLevel = securityLevel;

  GetUser200ResponseBuilder() {
    GetUser200Response._defaults(this);
  }

  GetUser200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cORPConfirmed = $v.cORPConfirmed;
      _rSIConfirmed = $v.rSIConfirmed;
      _rSIHandle = $v.rSIHandle;
      _rSIVerificationToken = $v.rSIVerificationToken;
      _disabled = $v.disabled;
      _enabled2fa = $v.enabled2fa;
      _picture = $v.picture;
      _roles = $v.roles?.toBuilder();
      _securityLevel = $v.securityLevel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUser200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetUser200Response;
  }

  @override
  void update(void Function(GetUser200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUser200Response build() => _build();

  _$GetUser200Response _build() {
    _$GetUser200Response _$result;
    try {
      _$result = _$v ??
          new _$GetUser200Response._(
              cORPConfirmed: cORPConfirmed,
              rSIConfirmed: rSIConfirmed,
              rSIHandle: rSIHandle,
              rSIVerificationToken: rSIVerificationToken,
              disabled: disabled,
              enabled2fa: enabled2fa,
              picture: picture,
              roles: _roles?.build(),
              securityLevel: securityLevel);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'roles';
        _roles?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetUser200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
