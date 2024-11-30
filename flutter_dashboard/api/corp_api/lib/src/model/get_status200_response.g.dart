// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_status200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetStatus200Response extends GetStatus200Response {
  @override
  final bool? cORPMember;
  @override
  final bool? rSIVerified;
  @override
  final bool? authentificated;
  @override
  final bool? isAdmin;
  @override
  final bool? isManager;

  factory _$GetStatus200Response(
          [void Function(GetStatus200ResponseBuilder)? updates]) =>
      (new GetStatus200ResponseBuilder()..update(updates))._build();

  _$GetStatus200Response._(
      {this.cORPMember,
      this.rSIVerified,
      this.authentificated,
      this.isAdmin,
      this.isManager})
      : super._();

  @override
  GetStatus200Response rebuild(
          void Function(GetStatus200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetStatus200ResponseBuilder toBuilder() =>
      new GetStatus200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetStatus200Response &&
        cORPMember == other.cORPMember &&
        rSIVerified == other.rSIVerified &&
        authentificated == other.authentificated &&
        isAdmin == other.isAdmin &&
        isManager == other.isManager;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cORPMember.hashCode);
    _$hash = $jc(_$hash, rSIVerified.hashCode);
    _$hash = $jc(_$hash, authentificated.hashCode);
    _$hash = $jc(_$hash, isAdmin.hashCode);
    _$hash = $jc(_$hash, isManager.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetStatus200Response')
          ..add('cORPMember', cORPMember)
          ..add('rSIVerified', rSIVerified)
          ..add('authentificated', authentificated)
          ..add('isAdmin', isAdmin)
          ..add('isManager', isManager))
        .toString();
  }
}

class GetStatus200ResponseBuilder
    implements Builder<GetStatus200Response, GetStatus200ResponseBuilder> {
  _$GetStatus200Response? _$v;

  bool? _cORPMember;
  bool? get cORPMember => _$this._cORPMember;
  set cORPMember(bool? cORPMember) => _$this._cORPMember = cORPMember;

  bool? _rSIVerified;
  bool? get rSIVerified => _$this._rSIVerified;
  set rSIVerified(bool? rSIVerified) => _$this._rSIVerified = rSIVerified;

  bool? _authentificated;
  bool? get authentificated => _$this._authentificated;
  set authentificated(bool? authentificated) =>
      _$this._authentificated = authentificated;

  bool? _isAdmin;
  bool? get isAdmin => _$this._isAdmin;
  set isAdmin(bool? isAdmin) => _$this._isAdmin = isAdmin;

  bool? _isManager;
  bool? get isManager => _$this._isManager;
  set isManager(bool? isManager) => _$this._isManager = isManager;

  GetStatus200ResponseBuilder() {
    GetStatus200Response._defaults(this);
  }

  GetStatus200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cORPMember = $v.cORPMember;
      _rSIVerified = $v.rSIVerified;
      _authentificated = $v.authentificated;
      _isAdmin = $v.isAdmin;
      _isManager = $v.isManager;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetStatus200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetStatus200Response;
  }

  @override
  void update(void Function(GetStatus200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetStatus200Response build() => _build();

  _$GetStatus200Response _build() {
    final _$result = _$v ??
        new _$GetStatus200Response._(
            cORPMember: cORPMember,
            rSIVerified: rSIVerified,
            authentificated: authentificated,
            isAdmin: isAdmin,
            isManager: isManager);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
