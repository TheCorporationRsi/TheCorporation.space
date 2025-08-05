// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_rsi_token200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetRSIToken200Response extends GetRSIToken200Response {
  @override
  final String? rSIToken;

  factory _$GetRSIToken200Response(
          [void Function(GetRSIToken200ResponseBuilder)? updates]) =>
      (GetRSIToken200ResponseBuilder()..update(updates))._build();

  _$GetRSIToken200Response._({this.rSIToken}) : super._();
  @override
  GetRSIToken200Response rebuild(
          void Function(GetRSIToken200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetRSIToken200ResponseBuilder toBuilder() =>
      GetRSIToken200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetRSIToken200Response && rSIToken == other.rSIToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rSIToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetRSIToken200Response')
          ..add('rSIToken', rSIToken))
        .toString();
  }
}

class GetRSIToken200ResponseBuilder
    implements Builder<GetRSIToken200Response, GetRSIToken200ResponseBuilder> {
  _$GetRSIToken200Response? _$v;

  String? _rSIToken;
  String? get rSIToken => _$this._rSIToken;
  set rSIToken(String? rSIToken) => _$this._rSIToken = rSIToken;

  GetRSIToken200ResponseBuilder() {
    GetRSIToken200Response._defaults(this);
  }

  GetRSIToken200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rSIToken = $v.rSIToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetRSIToken200Response other) {
    _$v = other as _$GetRSIToken200Response;
  }

  @override
  void update(void Function(GetRSIToken200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetRSIToken200Response build() => _build();

  _$GetRSIToken200Response _build() {
    final _$result = _$v ??
        _$GetRSIToken200Response._(
          rSIToken: rSIToken,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
