// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_auction200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CloseAuction200Response extends CloseAuction200Response {
  @override
  final String? msg;

  factory _$CloseAuction200Response(
          [void Function(CloseAuction200ResponseBuilder)? updates]) =>
      (CloseAuction200ResponseBuilder()..update(updates))._build();

  _$CloseAuction200Response._({this.msg}) : super._();
  @override
  CloseAuction200Response rebuild(
          void Function(CloseAuction200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CloseAuction200ResponseBuilder toBuilder() =>
      CloseAuction200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CloseAuction200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'CloseAuction200Response')
          ..add('msg', msg))
        .toString();
  }
}

class CloseAuction200ResponseBuilder
    implements
        Builder<CloseAuction200Response, CloseAuction200ResponseBuilder> {
  _$CloseAuction200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  CloseAuction200ResponseBuilder() {
    CloseAuction200Response._defaults(this);
  }

  CloseAuction200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CloseAuction200Response other) {
    _$v = other as _$CloseAuction200Response;
  }

  @override
  void update(void Function(CloseAuction200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CloseAuction200Response build() => _build();

  _$CloseAuction200Response _build() {
    final _$result = _$v ??
        _$CloseAuction200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
