// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_roles200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetRoles200ResponseInner extends GetRoles200ResponseInner {
  @override
  final String? color;
  @override
  final String? department;
  @override
  final String? discordId;
  @override
  final String? division;
  @override
  final String? logo;
  @override
  final String? title;
  @override
  final String? type;

  factory _$GetRoles200ResponseInner(
          [void Function(GetRoles200ResponseInnerBuilder)? updates]) =>
      (GetRoles200ResponseInnerBuilder()..update(updates))._build();

  _$GetRoles200ResponseInner._(
      {this.color,
      this.department,
      this.discordId,
      this.division,
      this.logo,
      this.title,
      this.type})
      : super._();
  @override
  GetRoles200ResponseInner rebuild(
          void Function(GetRoles200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetRoles200ResponseInnerBuilder toBuilder() =>
      GetRoles200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetRoles200ResponseInner &&
        color == other.color &&
        department == other.department &&
        discordId == other.discordId &&
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
    _$hash = $jc(_$hash, discordId.hashCode);
    _$hash = $jc(_$hash, division.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetRoles200ResponseInner')
          ..add('color', color)
          ..add('department', department)
          ..add('discordId', discordId)
          ..add('division', division)
          ..add('logo', logo)
          ..add('title', title)
          ..add('type', type))
        .toString();
  }
}

class GetRoles200ResponseInnerBuilder
    implements
        Builder<GetRoles200ResponseInner, GetRoles200ResponseInnerBuilder> {
  _$GetRoles200ResponseInner? _$v;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  String? _discordId;
  String? get discordId => _$this._discordId;
  set discordId(String? discordId) => _$this._discordId = discordId;

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

  GetRoles200ResponseInnerBuilder() {
    GetRoles200ResponseInner._defaults(this);
  }

  GetRoles200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _color = $v.color;
      _department = $v.department;
      _discordId = $v.discordId;
      _division = $v.division;
      _logo = $v.logo;
      _title = $v.title;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetRoles200ResponseInner other) {
    _$v = other as _$GetRoles200ResponseInner;
  }

  @override
  void update(void Function(GetRoles200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetRoles200ResponseInner build() => _build();

  _$GetRoles200ResponseInner _build() {
    final _$result = _$v ??
        _$GetRoles200ResponseInner._(
          color: color,
          department: department,
          discordId: discordId,
          division: division,
          logo: logo,
          title: title,
          type: type,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
