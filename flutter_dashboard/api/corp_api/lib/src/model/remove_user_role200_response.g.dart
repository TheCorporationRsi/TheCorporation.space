// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_user_role200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RemoveUserRole200Response extends RemoveUserRole200Response {
  @override
  final String? msg;

  factory _$RemoveUserRole200Response(
          [void Function(RemoveUserRole200ResponseBuilder)? updates]) =>
      (new RemoveUserRole200ResponseBuilder()..update(updates))._build();

  _$RemoveUserRole200Response._({this.msg}) : super._();

  @override
  RemoveUserRole200Response rebuild(
          void Function(RemoveUserRole200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RemoveUserRole200ResponseBuilder toBuilder() =>
      new RemoveUserRole200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RemoveUserRole200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'RemoveUserRole200Response')
          ..add('msg', msg))
        .toString();
  }
}

class RemoveUserRole200ResponseBuilder
    implements
        Builder<RemoveUserRole200Response, RemoveUserRole200ResponseBuilder> {
  _$RemoveUserRole200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  RemoveUserRole200ResponseBuilder() {
    RemoveUserRole200Response._defaults(this);
  }

  RemoveUserRole200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RemoveUserRole200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RemoveUserRole200Response;
  }

  @override
  void update(void Function(RemoveUserRole200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RemoveUserRole200Response build() => _build();

  _$RemoveUserRole200Response _build() {
    final _$result = _$v ?? new _$RemoveUserRole200Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
