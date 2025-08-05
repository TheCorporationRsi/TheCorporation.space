// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_weights200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetWeights200Response extends SetWeights200Response {
  @override
  final String? msg;

  factory _$SetWeights200Response(
          [void Function(SetWeights200ResponseBuilder)? updates]) =>
      (SetWeights200ResponseBuilder()..update(updates))._build();

  _$SetWeights200Response._({this.msg}) : super._();
  @override
  SetWeights200Response rebuild(
          void Function(SetWeights200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetWeights200ResponseBuilder toBuilder() =>
      SetWeights200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetWeights200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'SetWeights200Response')
          ..add('msg', msg))
        .toString();
  }
}

class SetWeights200ResponseBuilder
    implements Builder<SetWeights200Response, SetWeights200ResponseBuilder> {
  _$SetWeights200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  SetWeights200ResponseBuilder() {
    SetWeights200Response._defaults(this);
  }

  SetWeights200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetWeights200Response other) {
    _$v = other as _$SetWeights200Response;
  }

  @override
  void update(void Function(SetWeights200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetWeights200Response build() => _build();

  _$SetWeights200Response _build() {
    final _$result = _$v ??
        _$SetWeights200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
