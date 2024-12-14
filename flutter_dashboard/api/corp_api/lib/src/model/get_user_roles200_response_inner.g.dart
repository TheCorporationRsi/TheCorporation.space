// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_roles200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUserRoles200ResponseInner extends GetUserRoles200ResponseInner {
  @override
  final String? color;
  @override
  final String? department;
  @override
  final String? division;
  @override
  final String? logo;
  @override
  final String? title;
  @override
  final String? type;

  factory _$GetUserRoles200ResponseInner(
          [void Function(GetUserRoles200ResponseInnerBuilder)? updates]) =>
      (new GetUserRoles200ResponseInnerBuilder()..update(updates))._build();

  _$GetUserRoles200ResponseInner._(
      {this.color,
      this.department,
      this.division,
      this.logo,
      this.title,
      this.type})
      : super._();

  @override
  GetUserRoles200ResponseInner rebuild(
          void Function(GetUserRoles200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUserRoles200ResponseInnerBuilder toBuilder() =>
      new GetUserRoles200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUserRoles200ResponseInner &&
        color == other.color &&
        department == other.department &&
        division == other.division &&
        logo == other.logo &&
        title == other.title &&
        type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, division.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetUserRoles200ResponseInner')
          ..add('color', color)
          ..add('department', department)
          ..add('division', division)
          ..add('logo', logo)
          ..add('title', title)
          ..add('type', type))
        .toString();
  }
}

class GetUserRoles200ResponseInnerBuilder
    implements
        Builder<GetUserRoles200ResponseInner,
            GetUserRoles200ResponseInnerBuilder> {
  _$GetUserRoles200ResponseInner? _$v;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  String? _division;
  String? get division => _$this._division;
  set division(String? division) => _$this._division = division;

  String? _logo;
  String? get logo => _$this._logo;
  set logo(String? logo) => _$this._logo = logo;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  GetUserRoles200ResponseInnerBuilder() {
    GetUserRoles200ResponseInner._defaults(this);
  }

  GetUserRoles200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _color = $v.color;
      _department = $v.department;
      _division = $v.division;
      _logo = $v.logo;
      _title = $v.title;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUserRoles200ResponseInner other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetUserRoles200ResponseInner;
  }

  @override
  void update(void Function(GetUserRoles200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUserRoles200ResponseInner build() => _build();

  _$GetUserRoles200ResponseInner _build() {
    final _$result = _$v ??
        new _$GetUserRoles200ResponseInner._(
            color: color,
            department: department,
            division: division,
            logo: logo,
            title: title,
            type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
