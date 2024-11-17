// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register400_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Register400Response extends Register400Response {
  @override
  final String? msg;

  factory _$Register400Response(
          [void Function(Register400ResponseBuilder)? updates]) =>
      (new Register400ResponseBuilder()..update(updates))._build();

  _$Register400Response._({this.msg}) : super._();

  @override
  Register400Response rebuild(
          void Function(Register400ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Register400ResponseBuilder toBuilder() =>
      new Register400ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Register400Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'Register400Response')
          ..add('msg', msg))
        .toString();
  }
}

class Register400ResponseBuilder
    implements Builder<Register400Response, Register400ResponseBuilder> {
  _$Register400Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  Register400ResponseBuilder() {
    Register400Response._defaults(this);
  }

  Register400ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Register400Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Register400Response;
  }

  @override
  void update(void Function(Register400ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Register400Response build() => _build();

  _$Register400Response _build() {
    final _$result = _$v ?? new _$Register400Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
