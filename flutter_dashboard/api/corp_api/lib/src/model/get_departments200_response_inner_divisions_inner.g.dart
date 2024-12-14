// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_departments200_response_inner_divisions_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetDepartments200ResponseInnerDivisionsInner
    extends GetDepartments200ResponseInnerDivisionsInner {
  @override
  final String? description;
  @override
  final String? logo;
  @override
  final String? motto;
  @override
  final String? title;

  factory _$GetDepartments200ResponseInnerDivisionsInner(
          [void Function(GetDepartments200ResponseInnerDivisionsInnerBuilder)?
              updates]) =>
      (new GetDepartments200ResponseInnerDivisionsInnerBuilder()
            ..update(updates))
          ._build();

  _$GetDepartments200ResponseInnerDivisionsInner._(
      {this.description, this.logo, this.motto, this.title})
      : super._();

  @override
  GetDepartments200ResponseInnerDivisionsInner rebuild(
          void Function(GetDepartments200ResponseInnerDivisionsInnerBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetDepartments200ResponseInnerDivisionsInnerBuilder toBuilder() =>
      new GetDepartments200ResponseInnerDivisionsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetDepartments200ResponseInnerDivisionsInner &&
        description == other.description &&
        logo == other.logo &&
        motto == other.motto &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, motto.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GetDepartments200ResponseInnerDivisionsInner')
          ..add('description', description)
          ..add('logo', logo)
          ..add('motto', motto)
          ..add('title', title))
        .toString();
  }
}

class GetDepartments200ResponseInnerDivisionsInnerBuilder
    implements
        Builder<GetDepartments200ResponseInnerDivisionsInner,
            GetDepartments200ResponseInnerDivisionsInnerBuilder> {
  _$GetDepartments200ResponseInnerDivisionsInner? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _logo;
  String? get logo => _$this._logo;
  set logo(String? logo) => _$this._logo = logo;

  String? _motto;
  String? get motto => _$this._motto;
  set motto(String? motto) => _$this._motto = motto;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GetDepartments200ResponseInnerDivisionsInnerBuilder() {
    GetDepartments200ResponseInnerDivisionsInner._defaults(this);
  }

  GetDepartments200ResponseInnerDivisionsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _logo = $v.logo;
      _motto = $v.motto;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetDepartments200ResponseInnerDivisionsInner other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetDepartments200ResponseInnerDivisionsInner;
  }

  @override
  void update(
      void Function(GetDepartments200ResponseInnerDivisionsInnerBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GetDepartments200ResponseInnerDivisionsInner build() => _build();

  _$GetDepartments200ResponseInnerDivisionsInner _build() {
    final _$result = _$v ??
        new _$GetDepartments200ResponseInnerDivisionsInner._(
            description: description, logo: logo, motto: motto, title: title);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
