// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_role_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteRoleRequest extends DeleteRoleRequest {
  @override
  final String? roleTitle;

  factory _$DeleteRoleRequest(
          [void Function(DeleteRoleRequestBuilder)? updates]) =>
      (new DeleteRoleRequestBuilder()..update(updates))._build();

  _$DeleteRoleRequest._({this.roleTitle}) : super._();

  @override
  DeleteRoleRequest rebuild(void Function(DeleteRoleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteRoleRequestBuilder toBuilder() =>
      new DeleteRoleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteRoleRequest && roleTitle == other.roleTitle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roleTitle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteRoleRequest')
          ..add('roleTitle', roleTitle))
        .toString();
  }
}

class DeleteRoleRequestBuilder
    implements Builder<DeleteRoleRequest, DeleteRoleRequestBuilder> {
  _$DeleteRoleRequest? _$v;

  String? _roleTitle;
  String? get roleTitle => _$this._roleTitle;
  set roleTitle(String? roleTitle) => _$this._roleTitle = roleTitle;

  DeleteRoleRequestBuilder() {
    DeleteRoleRequest._defaults(this);
  }

  DeleteRoleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roleTitle = $v.roleTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteRoleRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeleteRoleRequest;
  }

  @override
  void update(void Function(DeleteRoleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteRoleRequest build() => _build();

  _$DeleteRoleRequest _build() {
    final _$result = _$v ?? new _$DeleteRoleRequest._(roleTitle: roleTitle);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
