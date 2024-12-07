// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_role_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddUserRoleRequest extends AddUserRoleRequest {
  @override
  final String? roleTitle;
  @override
  final String? rsiHandle;

  factory _$AddUserRoleRequest(
          [void Function(AddUserRoleRequestBuilder)? updates]) =>
      (new AddUserRoleRequestBuilder()..update(updates))._build();

  _$AddUserRoleRequest._({this.roleTitle, this.rsiHandle}) : super._();

  @override
  AddUserRoleRequest rebuild(
          void Function(AddUserRoleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddUserRoleRequestBuilder toBuilder() =>
      new AddUserRoleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddUserRoleRequest &&
        roleTitle == other.roleTitle &&
        rsiHandle == other.rsiHandle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roleTitle.hashCode);
    _$hash = $jc(_$hash, rsiHandle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddUserRoleRequest')
          ..add('roleTitle', roleTitle)
          ..add('rsiHandle', rsiHandle))
        .toString();
  }
}

class AddUserRoleRequestBuilder
    implements Builder<AddUserRoleRequest, AddUserRoleRequestBuilder> {
  _$AddUserRoleRequest? _$v;

  String? _roleTitle;
  String? get roleTitle => _$this._roleTitle;
  set roleTitle(String? roleTitle) => _$this._roleTitle = roleTitle;

  String? _rsiHandle;
  String? get rsiHandle => _$this._rsiHandle;
  set rsiHandle(String? rsiHandle) => _$this._rsiHandle = rsiHandle;

  AddUserRoleRequestBuilder() {
    AddUserRoleRequest._defaults(this);
  }

  AddUserRoleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roleTitle = $v.roleTitle;
      _rsiHandle = $v.rsiHandle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddUserRoleRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AddUserRoleRequest;
  }

  @override
  void update(void Function(AddUserRoleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddUserRoleRequest build() => _build();

  _$AddUserRoleRequest _build() {
    final _$result = _$v ??
        new _$AddUserRoleRequest._(roleTitle: roleTitle, rsiHandle: rsiHandle);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
