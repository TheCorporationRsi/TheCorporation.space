// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_department200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteDepartment200Response extends DeleteDepartment200Response {
  @override
  final String? msg;

  factory _$DeleteDepartment200Response(
          [void Function(DeleteDepartment200ResponseBuilder)? updates]) =>
      (DeleteDepartment200ResponseBuilder()..update(updates))._build();

  _$DeleteDepartment200Response._({this.msg}) : super._();
  @override
  DeleteDepartment200Response rebuild(
          void Function(DeleteDepartment200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteDepartment200ResponseBuilder toBuilder() =>
      DeleteDepartment200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteDepartment200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'DeleteDepartment200Response')
          ..add('msg', msg))
        .toString();
  }
}

class DeleteDepartment200ResponseBuilder
    implements
        Builder<DeleteDepartment200Response,
            DeleteDepartment200ResponseBuilder> {
  _$DeleteDepartment200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  DeleteDepartment200ResponseBuilder() {
    DeleteDepartment200Response._defaults(this);
  }

  DeleteDepartment200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteDepartment200Response other) {
    _$v = other as _$DeleteDepartment200Response;
  }

  @override
  void update(void Function(DeleteDepartment200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteDepartment200Response build() => _build();

  _$DeleteDepartment200Response _build() {
    final _$result = _$v ??
        _$DeleteDepartment200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
