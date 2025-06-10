// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_department200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateDepartment200Response extends CreateDepartment200Response {
  @override
  final String? msg;

  factory _$CreateDepartment200Response(
          [void Function(CreateDepartment200ResponseBuilder)? updates]) =>
      (CreateDepartment200ResponseBuilder()..update(updates))._build();

  _$CreateDepartment200Response._({this.msg}) : super._();
  @override
  CreateDepartment200Response rebuild(
          void Function(CreateDepartment200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateDepartment200ResponseBuilder toBuilder() =>
      CreateDepartment200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateDepartment200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'CreateDepartment200Response')
          ..add('msg', msg))
        .toString();
  }
}

class CreateDepartment200ResponseBuilder
    implements
        Builder<CreateDepartment200Response,
            CreateDepartment200ResponseBuilder> {
  _$CreateDepartment200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  CreateDepartment200ResponseBuilder() {
    CreateDepartment200Response._defaults(this);
  }

  CreateDepartment200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateDepartment200Response other) {
    _$v = other as _$CreateDepartment200Response;
  }

  @override
  void update(void Function(CreateDepartment200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateDepartment200Response build() => _build();

  _$CreateDepartment200Response _build() {
    final _$result = _$v ??
        _$CreateDepartment200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
