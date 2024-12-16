// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_division200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$JoinDivision200Response extends JoinDivision200Response {
  @override
  final String? msg;

  factory _$JoinDivision200Response(
          [void Function(JoinDivision200ResponseBuilder)? updates]) =>
      (new JoinDivision200ResponseBuilder()..update(updates))._build();

  _$JoinDivision200Response._({this.msg}) : super._();

  @override
  JoinDivision200Response rebuild(
          void Function(JoinDivision200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JoinDivision200ResponseBuilder toBuilder() =>
      new JoinDivision200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JoinDivision200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'JoinDivision200Response')
          ..add('msg', msg))
        .toString();
  }
}

class JoinDivision200ResponseBuilder
    implements
        Builder<JoinDivision200Response, JoinDivision200ResponseBuilder> {
  _$JoinDivision200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  JoinDivision200ResponseBuilder() {
    JoinDivision200Response._defaults(this);
  }

  JoinDivision200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(JoinDivision200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$JoinDivision200Response;
  }

  @override
  void update(void Function(JoinDivision200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  JoinDivision200Response build() => _build();

  _$JoinDivision200Response _build() {
    final _$result = _$v ?? new _$JoinDivision200Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
