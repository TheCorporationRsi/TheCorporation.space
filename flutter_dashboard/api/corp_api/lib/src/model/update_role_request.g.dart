// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_role_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateRoleRequest extends UpdateRoleRequest {
  @override
  final String? newColor;
  @override
  final String? newDiscordId;
  @override
  final String? newLogo;
  @override
  final String? newTitle;
  @override
  final String? roleTitle;

  factory _$UpdateRoleRequest(
          [void Function(UpdateRoleRequestBuilder)? updates]) =>
      (UpdateRoleRequestBuilder()..update(updates))._build();

  _$UpdateRoleRequest._(
      {this.newColor,
      this.newDiscordId,
      this.newLogo,
      this.newTitle,
      this.roleTitle})
      : super._();
  @override
  UpdateRoleRequest rebuild(void Function(UpdateRoleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateRoleRequestBuilder toBuilder() =>
      UpdateRoleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateRoleRequest &&
        newColor == other.newColor &&
        newDiscordId == other.newDiscordId &&
        newLogo == other.newLogo &&
        newTitle == other.newTitle &&
        roleTitle == other.roleTitle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newColor.hashCode);
    _$hash = $jc(_$hash, newDiscordId.hashCode);
    _$hash = $jc(_$hash, newLogo.hashCode);
    _$hash = $jc(_$hash, newTitle.hashCode);
    _$hash = $jc(_$hash, roleTitle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateRoleRequest')
          ..add('newColor', newColor)
          ..add('newDiscordId', newDiscordId)
          ..add('newLogo', newLogo)
          ..add('newTitle', newTitle)
          ..add('roleTitle', roleTitle))
        .toString();
  }
}

class UpdateRoleRequestBuilder
    implements Builder<UpdateRoleRequest, UpdateRoleRequestBuilder> {
  _$UpdateRoleRequest? _$v;

  String? _newColor;
  String? get newColor => _$this._newColor;
  set newColor(String? newColor) => _$this._newColor = newColor;

  String? _newDiscordId;
  String? get newDiscordId => _$this._newDiscordId;
  set newDiscordId(String? newDiscordId) => _$this._newDiscordId = newDiscordId;

  String? _newLogo;
  String? get newLogo => _$this._newLogo;
  set newLogo(String? newLogo) => _$this._newLogo = newLogo;

  String? _newTitle;
  String? get newTitle => _$this._newTitle;
  set newTitle(String? newTitle) => _$this._newTitle = newTitle;

  String? _roleTitle;
  String? get roleTitle => _$this._roleTitle;
  set roleTitle(String? roleTitle) => _$this._roleTitle = roleTitle;

  UpdateRoleRequestBuilder() {
    UpdateRoleRequest._defaults(this);
  }

  UpdateRoleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newColor = $v.newColor;
      _newDiscordId = $v.newDiscordId;
      _newLogo = $v.newLogo;
      _newTitle = $v.newTitle;
      _roleTitle = $v.roleTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateRoleRequest other) {
    _$v = other as _$UpdateRoleRequest;
  }

  @override
  void update(void Function(UpdateRoleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateRoleRequest build() => _build();

  _$UpdateRoleRequest _build() {
    final _$result = _$v ??
        _$UpdateRoleRequest._(
          newColor: newColor,
          newDiscordId: newDiscordId,
          newLogo: newLogo,
          newTitle: newTitle,
          roleTitle: roleTitle,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
