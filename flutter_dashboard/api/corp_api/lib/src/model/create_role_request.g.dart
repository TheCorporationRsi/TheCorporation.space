// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_role_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateRoleRequest extends CreateRoleRequest {
  @override
  final int? departmentId;
  @override
  final int? divisionId;
  @override
  final String? title;

  factory _$CreateRoleRequest(
          [void Function(CreateRoleRequestBuilder)? updates]) =>
      (new CreateRoleRequestBuilder()..update(updates))._build();

  _$CreateRoleRequest._({this.departmentId, this.divisionId, this.title})
      : super._();

  @override
  CreateRoleRequest rebuild(void Function(CreateRoleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateRoleRequestBuilder toBuilder() =>
      new CreateRoleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRoleRequest &&
        departmentId == other.departmentId &&
        divisionId == other.divisionId &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, departmentId.hashCode);
    _$hash = $jc(_$hash, divisionId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateRoleRequest')
          ..add('departmentId', departmentId)
          ..add('divisionId', divisionId)
          ..add('title', title))
        .toString();
  }
}

class CreateRoleRequestBuilder
    implements Builder<CreateRoleRequest, CreateRoleRequestBuilder> {
  _$CreateRoleRequest? _$v;

  int? _departmentId;
  int? get departmentId => _$this._departmentId;
  set departmentId(int? departmentId) => _$this._departmentId = departmentId;

  int? _divisionId;
  int? get divisionId => _$this._divisionId;
  set divisionId(int? divisionId) => _$this._divisionId = divisionId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  CreateRoleRequestBuilder() {
    CreateRoleRequest._defaults(this);
  }

  CreateRoleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _departmentId = $v.departmentId;
      _divisionId = $v.divisionId;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateRoleRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateRoleRequest;
  }

  @override
  void update(void Function(CreateRoleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRoleRequest build() => _build();

  _$CreateRoleRequest _build() {
    final _$result = _$v ??
        new _$CreateRoleRequest._(
            departmentId: departmentId, divisionId: divisionId, title: title);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
