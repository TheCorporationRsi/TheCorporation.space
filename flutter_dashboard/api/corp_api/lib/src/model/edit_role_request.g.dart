// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_role_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EditRoleRequest extends EditRoleRequest {
  @override
  final String? newColor;
  @override
  final String? newDiscordId;
  @override
  final String? newTitle;
  @override
  final String? roleTitle;

  factory _$EditRoleRequest([void Function(EditRoleRequestBuilder)? updates]) =>
      (EditRoleRequestBuilder()..update(updates))._build();

  _$EditRoleRequest._(
      {this.newColor, this.newDiscordId, this.newTitle, this.roleTitle})
      : super._();
  @override
  EditRoleRequest rebuild(void Function(EditRoleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EditRoleRequestBuilder toBuilder() => EditRoleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EditRoleRequest &&
        newColor == other.newColor &&
        newDiscordId == other.newDiscordId &&
        newTitle == other.newTitle &&
        roleTitle == other.roleTitle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newColor.hashCode);
    _$hash = $jc(_$hash, newDiscordId.hashCode);
    _$hash = $jc(_$hash, newTitle.hashCode);
    _$hash = $jc(_$hash, roleTitle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EditRoleRequest')
          ..add('newColor', newColor)
          ..add('newDiscordId', newDiscordId)
          ..add('newTitle', newTitle)
          ..add('roleTitle', roleTitle))
        .toString();
  }
}

class EditRoleRequestBuilder
    implements Builder<EditRoleRequest, EditRoleRequestBuilder> {
  _$EditRoleRequest? _$v;

  String? _newColor;
  String? get newColor => _$this._newColor;
  set newColor(String? newColor) => _$this._newColor = newColor;

  String? _newDiscordId;
  String? get newDiscordId => _$this._newDiscordId;
  set newDiscordId(String? newDiscordId) => _$this._newDiscordId = newDiscordId;

  String? _newTitle;
  String? get newTitle => _$this._newTitle;
  set newTitle(String? newTitle) => _$this._newTitle = newTitle;

  String? _roleTitle;
  String? get roleTitle => _$this._roleTitle;
  set roleTitle(String? roleTitle) => _$this._roleTitle = roleTitle;

  EditRoleRequestBuilder() {
    EditRoleRequest._defaults(this);
  }

  EditRoleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newColor = $v.newColor;
      _newDiscordId = $v.newDiscordId;
      _newTitle = $v.newTitle;
      _roleTitle = $v.roleTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EditRoleRequest other) {
    _$v = other as _$EditRoleRequest;
  }

  @override
  void update(void Function(EditRoleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EditRoleRequest build() => _build();

  _$EditRoleRequest _build() {
    final _$result = _$v ??
        _$EditRoleRequest._(
          newColor: newColor,
          newDiscordId: newDiscordId,
          newTitle: newTitle,
          roleTitle: roleTitle,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
