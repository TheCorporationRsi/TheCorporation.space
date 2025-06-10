// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_user_security_level200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetUserSecurityLevel200Response
    extends SetUserSecurityLevel200Response {
  @override
  final String? msg;

  factory _$SetUserSecurityLevel200Response(
          [void Function(SetUserSecurityLevel200ResponseBuilder)? updates]) =>
      (SetUserSecurityLevel200ResponseBuilder()..update(updates))._build();

  _$SetUserSecurityLevel200Response._({this.msg}) : super._();
  @override
  SetUserSecurityLevel200Response rebuild(
          void Function(SetUserSecurityLevel200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetUserSecurityLevel200ResponseBuilder toBuilder() =>
      SetUserSecurityLevel200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetUserSecurityLevel200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'SetUserSecurityLevel200Response')
          ..add('msg', msg))
        .toString();
  }
}

class SetUserSecurityLevel200ResponseBuilder
    implements
        Builder<SetUserSecurityLevel200Response,
            SetUserSecurityLevel200ResponseBuilder> {
  _$SetUserSecurityLevel200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  SetUserSecurityLevel200ResponseBuilder() {
    SetUserSecurityLevel200Response._defaults(this);
  }

  SetUserSecurityLevel200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetUserSecurityLevel200Response other) {
    _$v = other as _$SetUserSecurityLevel200Response;
  }

  @override
  void update(void Function(SetUserSecurityLevel200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetUserSecurityLevel200Response build() => _build();

  _$SetUserSecurityLevel200Response _build() {
    final _$result = _$v ??
        _$SetUserSecurityLevel200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
