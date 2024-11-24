// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cookie_expiration200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetCookieExpiration200Response extends GetCookieExpiration200Response {
  @override
  final String? corpAccessPassExpiration;
  @override
  final String? corpRefreshPassExpiration;

  factory _$GetCookieExpiration200Response(
          [void Function(GetCookieExpiration200ResponseBuilder)? updates]) =>
      (new GetCookieExpiration200ResponseBuilder()..update(updates))._build();

  _$GetCookieExpiration200Response._(
      {this.corpAccessPassExpiration, this.corpRefreshPassExpiration})
      : super._();

  @override
  GetCookieExpiration200Response rebuild(
          void Function(GetCookieExpiration200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetCookieExpiration200ResponseBuilder toBuilder() =>
      new GetCookieExpiration200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetCookieExpiration200Response &&
        corpAccessPassExpiration == other.corpAccessPassExpiration &&
        corpRefreshPassExpiration == other.corpRefreshPassExpiration;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, corpAccessPassExpiration.hashCode);
    _$hash = $jc(_$hash, corpRefreshPassExpiration.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetCookieExpiration200Response')
          ..add('corpAccessPassExpiration', corpAccessPassExpiration)
          ..add('corpRefreshPassExpiration', corpRefreshPassExpiration))
        .toString();
  }
}

class GetCookieExpiration200ResponseBuilder
    implements
        Builder<GetCookieExpiration200Response,
            GetCookieExpiration200ResponseBuilder> {
  _$GetCookieExpiration200Response? _$v;

  String? _corpAccessPassExpiration;
  String? get corpAccessPassExpiration => _$this._corpAccessPassExpiration;
  set corpAccessPassExpiration(String? corpAccessPassExpiration) =>
      _$this._corpAccessPassExpiration = corpAccessPassExpiration;

  String? _corpRefreshPassExpiration;
  String? get corpRefreshPassExpiration => _$this._corpRefreshPassExpiration;
  set corpRefreshPassExpiration(String? corpRefreshPassExpiration) =>
      _$this._corpRefreshPassExpiration = corpRefreshPassExpiration;

  GetCookieExpiration200ResponseBuilder() {
    GetCookieExpiration200Response._defaults(this);
  }

  GetCookieExpiration200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _corpAccessPassExpiration = $v.corpAccessPassExpiration;
      _corpRefreshPassExpiration = $v.corpRefreshPassExpiration;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetCookieExpiration200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetCookieExpiration200Response;
  }

  @override
  void update(void Function(GetCookieExpiration200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetCookieExpiration200Response build() => _build();

  _$GetCookieExpiration200Response _build() {
    final _$result = _$v ??
        new _$GetCookieExpiration200Response._(
            corpAccessPassExpiration: corpAccessPassExpiration,
            corpRefreshPassExpiration: corpRefreshPassExpiration);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
