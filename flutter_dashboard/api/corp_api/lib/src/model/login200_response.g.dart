// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Login200Response extends Login200Response {
  @override
  final String? corpAccessPass;
  @override
  final String? corpRefreshPass;
  @override
  final String? msg;

  factory _$Login200Response(
          [void Function(Login200ResponseBuilder)? updates]) =>
      (Login200ResponseBuilder()..update(updates))._build();

  _$Login200Response._({this.corpAccessPass, this.corpRefreshPass, this.msg})
      : super._();
  @override
  Login200Response rebuild(void Function(Login200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Login200ResponseBuilder toBuilder() =>
      Login200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Login200Response &&
        corpAccessPass == other.corpAccessPass &&
        corpRefreshPass == other.corpRefreshPass &&
        msg == other.msg;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, corpAccessPass.hashCode);
    _$hash = $jc(_$hash, corpRefreshPass.hashCode);
    _$hash = $jc(_$hash, msg.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Login200Response')
          ..add('corpAccessPass', corpAccessPass)
          ..add('corpRefreshPass', corpRefreshPass)
          ..add('msg', msg))
        .toString();
  }
}

class Login200ResponseBuilder
    implements Builder<Login200Response, Login200ResponseBuilder> {
  _$Login200Response? _$v;

  String? _corpAccessPass;
  String? get corpAccessPass => _$this._corpAccessPass;
  set corpAccessPass(String? corpAccessPass) =>
      _$this._corpAccessPass = corpAccessPass;

  String? _corpRefreshPass;
  String? get corpRefreshPass => _$this._corpRefreshPass;
  set corpRefreshPass(String? corpRefreshPass) =>
      _$this._corpRefreshPass = corpRefreshPass;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  Login200ResponseBuilder() {
    Login200Response._defaults(this);
  }

  Login200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _corpAccessPass = $v.corpAccessPass;
      _corpRefreshPass = $v.corpRefreshPass;
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Login200Response other) {
    _$v = other as _$Login200Response;
  }

  @override
  void update(void Function(Login200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Login200Response build() => _build();

  _$Login200Response _build() {
    final _$result = _$v ??
        _$Login200Response._(
          corpAccessPass: corpAccessPass,
          corpRefreshPass: corpRefreshPass,
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
