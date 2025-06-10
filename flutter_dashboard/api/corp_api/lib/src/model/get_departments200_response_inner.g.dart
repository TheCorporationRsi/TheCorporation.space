// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_departments200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetDepartments200ResponseInner extends GetDepartments200ResponseInner {
  @override
  final String? color;
  @override
  final String? description;
  @override
  final BuiltList<GetDepartments200ResponseInnerDivisionsInner>? divisions;
  @override
  final BuiltList<String>? heads;
  @override
  final String? logo;
  @override
  final int? memberCount;
  @override
  final String? motto;
  @override
  final BuiltList<String>? proxys;
  @override
  final String? title;

  factory _$GetDepartments200ResponseInner(
          [void Function(GetDepartments200ResponseInnerBuilder)? updates]) =>
      (GetDepartments200ResponseInnerBuilder()..update(updates))._build();

  _$GetDepartments200ResponseInner._(
      {this.color,
      this.description,
      this.divisions,
      this.heads,
      this.logo,
      this.memberCount,
      this.motto,
      this.proxys,
      this.title})
      : super._();
  @override
  GetDepartments200ResponseInner rebuild(
          void Function(GetDepartments200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetDepartments200ResponseInnerBuilder toBuilder() =>
      GetDepartments200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetDepartments200ResponseInner &&
        color == other.color &&
        description == other.description &&
        divisions == other.divisions &&
        heads == other.heads &&
        logo == other.logo &&
        memberCount == other.memberCount &&
        motto == other.motto &&
        proxys == other.proxys &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, divisions.hashCode);
    _$hash = $jc(_$hash, heads.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, memberCount.hashCode);
    _$hash = $jc(_$hash, motto.hashCode);
    _$hash = $jc(_$hash, proxys.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetDepartments200ResponseInner')
          ..add('color', color)
          ..add('description', description)
          ..add('divisions', divisions)
          ..add('heads', heads)
          ..add('logo', logo)
          ..add('memberCount', memberCount)
          ..add('motto', motto)
          ..add('proxys', proxys)
          ..add('title', title))
        .toString();
  }
}

class GetDepartments200ResponseInnerBuilder
    implements
        Builder<GetDepartments200ResponseInner,
            GetDepartments200ResponseInnerBuilder> {
  _$GetDepartments200ResponseInner? _$v;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<GetDepartments200ResponseInnerDivisionsInner>? _divisions;
  ListBuilder<GetDepartments200ResponseInnerDivisionsInner> get divisions =>
      _$this._divisions ??=
          ListBuilder<GetDepartments200ResponseInnerDivisionsInner>();
  set divisions(
          ListBuilder<GetDepartments200ResponseInnerDivisionsInner>?
              divisions) =>
      _$this._divisions = divisions;

  ListBuilder<String>? _heads;
  ListBuilder<String> get heads => _$this._heads ??= ListBuilder<String>();
  set heads(ListBuilder<String>? heads) => _$this._heads = heads;

  String? _logo;
  String? get logo => _$this._logo;
  set logo(String? logo) => _$this._logo = logo;

  int? _memberCount;
  int? get memberCount => _$this._memberCount;
  set memberCount(int? memberCount) => _$this._memberCount = memberCount;

  String? _motto;
  String? get motto => _$this._motto;
  set motto(String? motto) => _$this._motto = motto;

  ListBuilder<String>? _proxys;
  ListBuilder<String> get proxys => _$this._proxys ??= ListBuilder<String>();
  set proxys(ListBuilder<String>? proxys) => _$this._proxys = proxys;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GetDepartments200ResponseInnerBuilder() {
    GetDepartments200ResponseInner._defaults(this);
  }

  GetDepartments200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _color = $v.color;
      _description = $v.description;
      _divisions = $v.divisions?.toBuilder();
      _heads = $v.heads?.toBuilder();
      _logo = $v.logo;
      _memberCount = $v.memberCount;
      _motto = $v.motto;
      _proxys = $v.proxys?.toBuilder();
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetDepartments200ResponseInner other) {
    _$v = other as _$GetDepartments200ResponseInner;
  }

  @override
  void update(void Function(GetDepartments200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetDepartments200ResponseInner build() => _build();

  _$GetDepartments200ResponseInner _build() {
    _$GetDepartments200ResponseInner _$result;
    try {
      _$result = _$v ??
          _$GetDepartments200ResponseInner._(
            color: color,
            description: description,
            divisions: _divisions?.build(),
            heads: _heads?.build(),
            logo: logo,
            memberCount: memberCount,
            motto: motto,
            proxys: _proxys?.build(),
            title: title,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'divisions';
        _divisions?.build();
        _$failedField = 'heads';
        _heads?.build();

        _$failedField = 'proxys';
        _proxys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetDepartments200ResponseInner', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
