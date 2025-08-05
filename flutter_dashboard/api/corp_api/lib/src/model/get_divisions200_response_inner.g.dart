// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_divisions200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetDivisions200ResponseInner extends GetDivisions200ResponseInner {
  @override
  final String? color;
  @override
  final String? departmentTitle;
  @override
  final String? description;
  @override
  final BuiltList<String>? leaders;
  @override
  final String? logo;
  @override
  final int? memberCount;
  @override
  final String? motto;
  @override
  final BuiltList<String>? proxys;
  @override
  final bool? restricted;
  @override
  final String? title;

  factory _$GetDivisions200ResponseInner(
          [void Function(GetDivisions200ResponseInnerBuilder)? updates]) =>
      (GetDivisions200ResponseInnerBuilder()..update(updates))._build();

  _$GetDivisions200ResponseInner._(
      {this.color,
      this.departmentTitle,
      this.description,
      this.leaders,
      this.logo,
      this.memberCount,
      this.motto,
      this.proxys,
      this.restricted,
      this.title})
      : super._();
  @override
  GetDivisions200ResponseInner rebuild(
          void Function(GetDivisions200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetDivisions200ResponseInnerBuilder toBuilder() =>
      GetDivisions200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetDivisions200ResponseInner &&
        color == other.color &&
        departmentTitle == other.departmentTitle &&
        description == other.description &&
        leaders == other.leaders &&
        logo == other.logo &&
        memberCount == other.memberCount &&
        motto == other.motto &&
        proxys == other.proxys &&
        restricted == other.restricted &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, departmentTitle.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, leaders.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, memberCount.hashCode);
    _$hash = $jc(_$hash, motto.hashCode);
    _$hash = $jc(_$hash, proxys.hashCode);
    _$hash = $jc(_$hash, restricted.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetDivisions200ResponseInner')
          ..add('color', color)
          ..add('departmentTitle', departmentTitle)
          ..add('description', description)
          ..add('leaders', leaders)
          ..add('logo', logo)
          ..add('memberCount', memberCount)
          ..add('motto', motto)
          ..add('proxys', proxys)
          ..add('restricted', restricted)
          ..add('title', title))
        .toString();
  }
}

class GetDivisions200ResponseInnerBuilder
    implements
        Builder<GetDivisions200ResponseInner,
            GetDivisions200ResponseInnerBuilder> {
  _$GetDivisions200ResponseInner? _$v;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _departmentTitle;
  String? get departmentTitle => _$this._departmentTitle;
  set departmentTitle(String? departmentTitle) =>
      _$this._departmentTitle = departmentTitle;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<String>? _leaders;
  ListBuilder<String> get leaders => _$this._leaders ??= ListBuilder<String>();
  set leaders(ListBuilder<String>? leaders) => _$this._leaders = leaders;

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

  bool? _restricted;
  bool? get restricted => _$this._restricted;
  set restricted(bool? restricted) => _$this._restricted = restricted;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GetDivisions200ResponseInnerBuilder() {
    GetDivisions200ResponseInner._defaults(this);
  }

  GetDivisions200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _color = $v.color;
      _departmentTitle = $v.departmentTitle;
      _description = $v.description;
      _leaders = $v.leaders?.toBuilder();
      _logo = $v.logo;
      _memberCount = $v.memberCount;
      _motto = $v.motto;
      _proxys = $v.proxys?.toBuilder();
      _restricted = $v.restricted;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetDivisions200ResponseInner other) {
    _$v = other as _$GetDivisions200ResponseInner;
  }

  @override
  void update(void Function(GetDivisions200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetDivisions200ResponseInner build() => _build();

  _$GetDivisions200ResponseInner _build() {
    _$GetDivisions200ResponseInner _$result;
    try {
      _$result = _$v ??
          _$GetDivisions200ResponseInner._(
            color: color,
            departmentTitle: departmentTitle,
            description: description,
            leaders: _leaders?.build(),
            logo: logo,
            memberCount: memberCount,
            motto: motto,
            proxys: _proxys?.build(),
            restricted: restricted,
            title: title,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'leaders';
        _leaders?.build();

        _$failedField = 'proxys';
        _proxys?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetDivisions200ResponseInner', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
