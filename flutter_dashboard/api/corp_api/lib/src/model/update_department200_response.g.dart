// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_department200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateDepartment200Response extends UpdateDepartment200Response {
  @override
  final String? msg;

  factory _$UpdateDepartment200Response(
          [void Function(UpdateDepartment200ResponseBuilder)? updates]) =>
      (UpdateDepartment200ResponseBuilder()..update(updates))._build();

  _$UpdateDepartment200Response._({this.msg}) : super._();
  @override
  UpdateDepartment200Response rebuild(
          void Function(UpdateDepartment200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateDepartment200ResponseBuilder toBuilder() =>
      UpdateDepartment200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateDepartment200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'UpdateDepartment200Response')
          ..add('msg', msg))
        .toString();
  }
}

class UpdateDepartment200ResponseBuilder
    implements
        Builder<UpdateDepartment200Response,
            UpdateDepartment200ResponseBuilder> {
  _$UpdateDepartment200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  UpdateDepartment200ResponseBuilder() {
    UpdateDepartment200Response._defaults(this);
  }

  UpdateDepartment200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateDepartment200Response other) {
    _$v = other as _$UpdateDepartment200Response;
  }

  @override
  void update(void Function(UpdateDepartment200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateDepartment200Response build() => _build();

  _$UpdateDepartment200Response _build() {
    final _$result = _$v ??
        _$UpdateDepartment200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
