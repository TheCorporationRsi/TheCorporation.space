// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_bet200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PlaceBet200Response extends PlaceBet200Response {
  @override
  final String? msg;

  factory _$PlaceBet200Response(
          [void Function(PlaceBet200ResponseBuilder)? updates]) =>
      (PlaceBet200ResponseBuilder()..update(updates))._build();

  _$PlaceBet200Response._({this.msg}) : super._();
  @override
  PlaceBet200Response rebuild(
          void Function(PlaceBet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlaceBet200ResponseBuilder toBuilder() =>
      PlaceBet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlaceBet200Response && msg == other.msg;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, msg.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PlaceBet200Response')
          ..add('msg', msg))
        .toString();
  }
}

class PlaceBet200ResponseBuilder
    implements Builder<PlaceBet200Response, PlaceBet200ResponseBuilder> {
  _$PlaceBet200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  PlaceBet200ResponseBuilder() {
    PlaceBet200Response._defaults(this);
  }

  PlaceBet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlaceBet200Response other) {
    _$v = other as _$PlaceBet200Response;
  }

  @override
  void update(void Function(PlaceBet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PlaceBet200Response build() => _build();

  _$PlaceBet200Response _build() {
    final _$result = _$v ??
        _$PlaceBet200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
