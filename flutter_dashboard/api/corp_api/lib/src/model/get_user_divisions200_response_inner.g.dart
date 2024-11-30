// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_divisions200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUserDivisions200ResponseInner
    extends GetUserDivisions200ResponseInner {
  @override
  final String? color;
  @override
  final String? department;
  @override
  final String? logo;
  @override
  final String? title;
  @override
  final int? weight;

  factory _$GetUserDivisions200ResponseInner(
          [void Function(GetUserDivisions200ResponseInnerBuilder)? updates]) =>
      (new GetUserDivisions200ResponseInnerBuilder()..update(updates))._build();

  _$GetUserDivisions200ResponseInner._(
      {this.color, this.department, this.logo, this.title, this.weight})
      : super._();

  @override
  GetUserDivisions200ResponseInner rebuild(
          void Function(GetUserDivisions200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUserDivisions200ResponseInnerBuilder toBuilder() =>
      new GetUserDivisions200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUserDivisions200ResponseInner &&
        color == other.color &&
        department == other.department &&
        logo == other.logo &&
        title == other.title &&
        weight == other.weight;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetUserDivisions200ResponseInner')
          ..add('color', color)
          ..add('department', department)
          ..add('logo', logo)
          ..add('title', title)
          ..add('weight', weight))
        .toString();
  }
}

class GetUserDivisions200ResponseInnerBuilder
    implements
        Builder<GetUserDivisions200ResponseInner,
            GetUserDivisions200ResponseInnerBuilder> {
  _$GetUserDivisions200ResponseInner? _$v;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  String? _logo;
  String? get logo => _$this._logo;
  set logo(String? logo) => _$this._logo = logo;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _weight;
  int? get weight => _$this._weight;
  set weight(int? weight) => _$this._weight = weight;

  GetUserDivisions200ResponseInnerBuilder() {
    GetUserDivisions200ResponseInner._defaults(this);
  }

  GetUserDivisions200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _color = $v.color;
      _department = $v.department;
      _logo = $v.logo;
      _title = $v.title;
      _weight = $v.weight;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUserDivisions200ResponseInner other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetUserDivisions200ResponseInner;
  }

  @override
  void update(void Function(GetUserDivisions200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUserDivisions200ResponseInner build() => _build();

  _$GetUserDivisions200ResponseInner _build() {
    final _$result = _$v ??
        new _$GetUserDivisions200ResponseInner._(
            color: color,
            department: department,
            logo: logo,
            title: title,
            weight: weight);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
