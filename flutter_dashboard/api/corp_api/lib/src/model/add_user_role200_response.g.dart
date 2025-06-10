// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_role200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddUserRole200Response extends AddUserRole200Response {
  @override
  final String? msg;

  factory _$AddUserRole200Response(
          [void Function(AddUserRole200ResponseBuilder)? updates]) =>
      (AddUserRole200ResponseBuilder()..update(updates))._build();

  _$AddUserRole200Response._({this.msg}) : super._();
  @override
  AddUserRole200Response rebuild(
          void Function(AddUserRole200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddUserRole200ResponseBuilder toBuilder() =>
      AddUserRole200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddUserRole200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'AddUserRole200Response')
          ..add('msg', msg))
        .toString();
  }
}

class AddUserRole200ResponseBuilder
    implements Builder<AddUserRole200Response, AddUserRole200ResponseBuilder> {
  _$AddUserRole200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  AddUserRole200ResponseBuilder() {
    AddUserRole200Response._defaults(this);
  }

  AddUserRole200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddUserRole200Response other) {
    _$v = other as _$AddUserRole200Response;
  }

  @override
  void update(void Function(AddUserRole200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddUserRole200Response build() => _build();

  _$AddUserRole200Response _build() {
    final _$result = _$v ??
        _$AddUserRole200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
