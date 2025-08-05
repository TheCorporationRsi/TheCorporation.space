// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manualy_verify_user200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ManualyVerifyUser200Response extends ManualyVerifyUser200Response {
  @override
  final String? msg;

  factory _$ManualyVerifyUser200Response(
          [void Function(ManualyVerifyUser200ResponseBuilder)? updates]) =>
      (ManualyVerifyUser200ResponseBuilder()..update(updates))._build();

  _$ManualyVerifyUser200Response._({this.msg}) : super._();
  @override
  ManualyVerifyUser200Response rebuild(
          void Function(ManualyVerifyUser200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ManualyVerifyUser200ResponseBuilder toBuilder() =>
      ManualyVerifyUser200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ManualyVerifyUser200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'ManualyVerifyUser200Response')
          ..add('msg', msg))
        .toString();
  }
}

class ManualyVerifyUser200ResponseBuilder
    implements
        Builder<ManualyVerifyUser200Response,
            ManualyVerifyUser200ResponseBuilder> {
  _$ManualyVerifyUser200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  ManualyVerifyUser200ResponseBuilder() {
    ManualyVerifyUser200Response._defaults(this);
  }

  ManualyVerifyUser200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ManualyVerifyUser200Response other) {
    _$v = other as _$ManualyVerifyUser200Response;
  }

  @override
  void update(void Function(ManualyVerifyUser200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ManualyVerifyUser200Response build() => _build();

  _$ManualyVerifyUser200Response _build() {
    final _$result = _$v ??
        _$ManualyVerifyUser200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
