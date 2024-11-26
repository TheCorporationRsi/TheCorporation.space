// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RefreshToken200Response extends RefreshToken200Response {
  @override
  final String? corpAccessPass;
  @override
  final String? corpRefreshPass;
  @override
  final bool? refreshed;

  factory _$RefreshToken200Response(
          [void Function(RefreshToken200ResponseBuilder)? updates]) =>
      (new RefreshToken200ResponseBuilder()..update(updates))._build();

  _$RefreshToken200Response._(
      {this.corpAccessPass, this.corpRefreshPass, this.refreshed})
      : super._();

  @override
  RefreshToken200Response rebuild(
          void Function(RefreshToken200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RefreshToken200ResponseBuilder toBuilder() =>
      new RefreshToken200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RefreshToken200Response &&
        corpAccessPass == other.corpAccessPass &&
        corpRefreshPass == other.corpRefreshPass &&
        refreshed == other.refreshed;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, corpAccessPass.hashCode);
    _$hash = $jc(_$hash, corpRefreshPass.hashCode);
    _$hash = $jc(_$hash, refreshed.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RefreshToken200Response')
          ..add('corpAccessPass', corpAccessPass)
          ..add('corpRefreshPass', corpRefreshPass)
          ..add('refreshed', refreshed))
        .toString();
  }
}

class RefreshToken200ResponseBuilder
    implements
        Builder<RefreshToken200Response, RefreshToken200ResponseBuilder> {
  _$RefreshToken200Response? _$v;

  String? _corpAccessPass;
  String? get corpAccessPass => _$this._corpAccessPass;
  set corpAccessPass(String? corpAccessPass) =>
      _$this._corpAccessPass = corpAccessPass;

  String? _corpRefreshPass;
  String? get corpRefreshPass => _$this._corpRefreshPass;
  set corpRefreshPass(String? corpRefreshPass) =>
      _$this._corpRefreshPass = corpRefreshPass;

  bool? _refreshed;
  bool? get refreshed => _$this._refreshed;
  set refreshed(bool? refreshed) => _$this._refreshed = refreshed;

  RefreshToken200ResponseBuilder() {
    RefreshToken200Response._defaults(this);
  }

  RefreshToken200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _corpAccessPass = $v.corpAccessPass;
      _corpRefreshPass = $v.corpRefreshPass;
      _refreshed = $v.refreshed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RefreshToken200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RefreshToken200Response;
  }

  @override
  void update(void Function(RefreshToken200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RefreshToken200Response build() => _build();

  _$RefreshToken200Response _build() {
    final _$result = _$v ??
        new _$RefreshToken200Response._(
            corpAccessPass: corpAccessPass,
            corpRefreshPass: corpRefreshPass,
            refreshed: refreshed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
