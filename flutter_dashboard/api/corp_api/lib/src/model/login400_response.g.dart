// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login400_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Login400Response extends Login400Response {
  @override
  final String? msg;

  factory _$Login400Response(
          [void Function(Login400ResponseBuilder)? updates]) =>
      (new Login400ResponseBuilder()..update(updates))._build();

  _$Login400Response._({this.msg}) : super._();

  @override
  Login400Response rebuild(void Function(Login400ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Login400ResponseBuilder toBuilder() =>
      new Login400ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Login400Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'Login400Response')..add('msg', msg))
        .toString();
  }
}

class Login400ResponseBuilder
    implements Builder<Login400Response, Login400ResponseBuilder> {
  _$Login400Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  Login400ResponseBuilder() {
    Login400Response._defaults(this);
  }

  Login400ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Login400Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Login400Response;
  }

  @override
  void update(void Function(Login400ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Login400Response build() => _build();

  _$Login400Response _build() {
    final _$result = _$v ?? new _$Login400Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
