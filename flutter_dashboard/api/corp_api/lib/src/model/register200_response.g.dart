// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Register200Response extends Register200Response {
  @override
  final String? msg;

  factory _$Register200Response(
          [void Function(Register200ResponseBuilder)? updates]) =>
      (new Register200ResponseBuilder()..update(updates))._build();

  _$Register200Response._({this.msg}) : super._();

  @override
  Register200Response rebuild(
          void Function(Register200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Register200ResponseBuilder toBuilder() =>
      new Register200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Register200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'Register200Response')
          ..add('msg', msg))
        .toString();
  }
}

class Register200ResponseBuilder
    implements Builder<Register200Response, Register200ResponseBuilder> {
  _$Register200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  Register200ResponseBuilder() {
    Register200Response._defaults(this);
  }

  Register200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Register200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Register200Response;
  }

  @override
  void update(void Function(Register200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Register200Response build() => _build();

  _$Register200Response _build() {
    final _$result = _$v ?? new _$Register200Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
