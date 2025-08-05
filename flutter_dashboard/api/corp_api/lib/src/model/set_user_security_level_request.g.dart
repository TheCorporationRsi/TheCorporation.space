// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_user_security_level_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetUserSecurityLevelRequest extends SetUserSecurityLevelRequest {
  @override
  final int? securityLevel;
  @override
  final String? username;

  factory _$SetUserSecurityLevelRequest(
          [void Function(SetUserSecurityLevelRequestBuilder)? updates]) =>
      (SetUserSecurityLevelRequestBuilder()..update(updates))._build();

  _$SetUserSecurityLevelRequest._({this.securityLevel, this.username})
      : super._();
  @override
  SetUserSecurityLevelRequest rebuild(
          void Function(SetUserSecurityLevelRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetUserSecurityLevelRequestBuilder toBuilder() =>
      SetUserSecurityLevelRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetUserSecurityLevelRequest &&
        securityLevel == other.securityLevel &&
        username == other.username;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, securityLevel.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetUserSecurityLevelRequest')
          ..add('securityLevel', securityLevel)
          ..add('username', username))
        .toString();
  }
}

class SetUserSecurityLevelRequestBuilder
    implements
        Builder<SetUserSecurityLevelRequest,
            SetUserSecurityLevelRequestBuilder> {
  _$SetUserSecurityLevelRequest? _$v;

  int? _securityLevel;
  int? get securityLevel => _$this._securityLevel;
  set securityLevel(int? securityLevel) =>
      _$this._securityLevel = securityLevel;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  SetUserSecurityLevelRequestBuilder() {
    SetUserSecurityLevelRequest._defaults(this);
  }

  SetUserSecurityLevelRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _securityLevel = $v.securityLevel;
      _username = $v.username;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetUserSecurityLevelRequest other) {
    _$v = other as _$SetUserSecurityLevelRequest;
  }

  @override
  void update(void Function(SetUserSecurityLevelRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetUserSecurityLevelRequest build() => _build();

  _$SetUserSecurityLevelRequest _build() {
    final _$result = _$v ??
        _$SetUserSecurityLevelRequest._(
          securityLevel: securityLevel,
          username: username,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
