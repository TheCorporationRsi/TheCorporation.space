// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_users200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUsers200ResponseInner extends GetUsers200ResponseInner {
  @override
  final bool? cORPConfirmed;
  @override
  final bool? rSIConfirmed;
  @override
  final String? rSIHandle;
  @override
  final bool? disabled;
  @override
  final String? picture;
  @override
  final int? securityLevel;

  factory _$GetUsers200ResponseInner(
          [void Function(GetUsers200ResponseInnerBuilder)? updates]) =>
      (new GetUsers200ResponseInnerBuilder()..update(updates))._build();

  _$GetUsers200ResponseInner._(
      {this.cORPConfirmed,
      this.rSIConfirmed,
      this.rSIHandle,
      this.disabled,
      this.picture,
      this.securityLevel})
      : super._();

  @override
  GetUsers200ResponseInner rebuild(
          void Function(GetUsers200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUsers200ResponseInnerBuilder toBuilder() =>
      new GetUsers200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUsers200ResponseInner &&
        cORPConfirmed == other.cORPConfirmed &&
        rSIConfirmed == other.rSIConfirmed &&
        rSIHandle == other.rSIHandle &&
        disabled == other.disabled &&
        picture == other.picture &&
        securityLevel == other.securityLevel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cORPConfirmed.hashCode);
    _$hash = $jc(_$hash, rSIConfirmed.hashCode);
    _$hash = $jc(_$hash, rSIHandle.hashCode);
    _$hash = $jc(_$hash, disabled.hashCode);
    _$hash = $jc(_$hash, picture.hashCode);
    _$hash = $jc(_$hash, securityLevel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetUsers200ResponseInner')
          ..add('cORPConfirmed', cORPConfirmed)
          ..add('rSIConfirmed', rSIConfirmed)
          ..add('rSIHandle', rSIHandle)
          ..add('disabled', disabled)
          ..add('picture', picture)
          ..add('securityLevel', securityLevel))
        .toString();
  }
}

class GetUsers200ResponseInnerBuilder
    implements
        Builder<GetUsers200ResponseInner, GetUsers200ResponseInnerBuilder> {
  _$GetUsers200ResponseInner? _$v;

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

  bool? _disabled;
  bool? get disabled => _$this._disabled;
  set disabled(bool? disabled) => _$this._disabled = disabled;

  String? _picture;
  String? get picture => _$this._picture;
  set picture(String? picture) => _$this._picture = picture;

  int? _securityLevel;
  int? get securityLevel => _$this._securityLevel;
  set securityLevel(int? securityLevel) =>
      _$this._securityLevel = securityLevel;

  GetUsers200ResponseInnerBuilder() {
    GetUsers200ResponseInner._defaults(this);
  }

  GetUsers200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cORPConfirmed = $v.cORPConfirmed;
      _rSIConfirmed = $v.rSIConfirmed;
      _rSIHandle = $v.rSIHandle;
      _disabled = $v.disabled;
      _picture = $v.picture;
      _securityLevel = $v.securityLevel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUsers200ResponseInner other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetUsers200ResponseInner;
  }

  @override
  void update(void Function(GetUsers200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUsers200ResponseInner build() => _build();

  _$GetUsers200ResponseInner _build() {
    final _$result = _$v ??
        new _$GetUsers200ResponseInner._(
            cORPConfirmed: cORPConfirmed,
            rSIConfirmed: rSIConfirmed,
            rSIHandle: rSIHandle,
            disabled: disabled,
            picture: picture,
            securityLevel: securityLevel);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
