// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_department_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateDepartmentRequest extends UpdateDepartmentRequest {
  @override
  final String departmentTitle;
  @override
  final String? color;
  @override
  final String? description;
  @override
  final String? logo;
  @override
  final String? motto;
  @override
  final String? newTitle;

  factory _$UpdateDepartmentRequest(
          [void Function(UpdateDepartmentRequestBuilder)? updates]) =>
      (UpdateDepartmentRequestBuilder()..update(updates))._build();

  _$UpdateDepartmentRequest._(
      {required this.departmentTitle,
      this.color,
      this.description,
      this.logo,
      this.motto,
      this.newTitle})
      : super._();
  @override
  UpdateDepartmentRequest rebuild(
          void Function(UpdateDepartmentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateDepartmentRequestBuilder toBuilder() =>
      UpdateDepartmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateDepartmentRequest &&
        departmentTitle == other.departmentTitle &&
        color == other.color &&
        description == other.description &&
        logo == other.logo &&
        motto == other.motto &&
        newTitle == other.newTitle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, departmentTitle.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, motto.hashCode);
    _$hash = $jc(_$hash, newTitle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateDepartmentRequest')
          ..add('departmentTitle', departmentTitle)
          ..add('color', color)
          ..add('description', description)
          ..add('logo', logo)
          ..add('motto', motto)
          ..add('newTitle', newTitle))
        .toString();
  }
}

class UpdateDepartmentRequestBuilder
    implements
        Builder<UpdateDepartmentRequest, UpdateDepartmentRequestBuilder> {
  _$UpdateDepartmentRequest? _$v;

  String? _departmentTitle;
  String? get departmentTitle => _$this._departmentTitle;
  set departmentTitle(String? departmentTitle) =>
      _$this._departmentTitle = departmentTitle;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _logo;
  String? get logo => _$this._logo;
  set logo(String? logo) => _$this._logo = logo;

  String? _motto;
  String? get motto => _$this._motto;
  set motto(String? motto) => _$this._motto = motto;

  String? _newTitle;
  String? get newTitle => _$this._newTitle;
  set newTitle(String? newTitle) => _$this._newTitle = newTitle;

  UpdateDepartmentRequestBuilder() {
    UpdateDepartmentRequest._defaults(this);
  }

  UpdateDepartmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _departmentTitle = $v.departmentTitle;
      _color = $v.color;
      _description = $v.description;
      _logo = $v.logo;
      _motto = $v.motto;
      _newTitle = $v.newTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateDepartmentRequest other) {
    _$v = other as _$UpdateDepartmentRequest;
  }

  @override
  void update(void Function(UpdateDepartmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateDepartmentRequest build() => _build();

  _$UpdateDepartmentRequest _build() {
    final _$result = _$v ??
        _$UpdateDepartmentRequest._(
          departmentTitle: BuiltValueNullFieldError.checkNotNull(
              departmentTitle, r'UpdateDepartmentRequest', 'departmentTitle'),
          color: color,
          description: description,
          logo: logo,
          motto: motto,
          newTitle: newTitle,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
