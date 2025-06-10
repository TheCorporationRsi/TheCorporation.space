// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_profile200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUserProfile200Response extends GetUserProfile200Response {
  @override
  final String? moniker;
  @override
  final String? picture;
  @override
  final String? rSIHandle;

  factory _$GetUserProfile200Response(
          [void Function(GetUserProfile200ResponseBuilder)? updates]) =>
      (GetUserProfile200ResponseBuilder()..update(updates))._build();

  _$GetUserProfile200Response._({this.moniker, this.picture, this.rSIHandle})
      : super._();
  @override
  GetUserProfile200Response rebuild(
          void Function(GetUserProfile200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUserProfile200ResponseBuilder toBuilder() =>
      GetUserProfile200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUserProfile200Response &&
        moniker == other.moniker &&
        picture == other.picture &&
        rSIHandle == other.rSIHandle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, moniker.hashCode);
    _$hash = $jc(_$hash, picture.hashCode);
    _$hash = $jc(_$hash, rSIHandle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetUserProfile200Response')
          ..add('moniker', moniker)
          ..add('picture', picture)
          ..add('rSIHandle', rSIHandle))
        .toString();
  }
}

class GetUserProfile200ResponseBuilder
    implements
        Builder<GetUserProfile200Response, GetUserProfile200ResponseBuilder> {
  _$GetUserProfile200Response? _$v;

  String? _moniker;
  String? get moniker => _$this._moniker;
  set moniker(String? moniker) => _$this._moniker = moniker;

  String? _picture;
  String? get picture => _$this._picture;
  set picture(String? picture) => _$this._picture = picture;

  String? _rSIHandle;
  String? get rSIHandle => _$this._rSIHandle;
  set rSIHandle(String? rSIHandle) => _$this._rSIHandle = rSIHandle;

  GetUserProfile200ResponseBuilder() {
    GetUserProfile200Response._defaults(this);
  }

  GetUserProfile200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _moniker = $v.moniker;
      _picture = $v.picture;
      _rSIHandle = $v.rSIHandle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUserProfile200Response other) {
    _$v = other as _$GetUserProfile200Response;
  }

  @override
  void update(void Function(GetUserProfile200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUserProfile200Response build() => _build();

  _$GetUserProfile200Response _build() {
    final _$result = _$v ??
        _$GetUserProfile200Response._(
          moniker: moniker,
          picture: picture,
          rSIHandle: rSIHandle,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
