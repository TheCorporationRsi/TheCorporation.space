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
  final BuiltList<String>? leaders;
  @override
  final String? logo;
  @override
  final String? motto;
  @override
  final BuiltList<String>? proxys;
  @override
  final bool? restricted;
  @override
  final String? title;

  factory _$GetDepartments200ResponseInnerDivisionsInner(
          [void Function(GetDepartments200ResponseInnerDivisionsInnerBuilder)?
              updates]) =>
      (GetDepartments200ResponseInnerDivisionsInnerBuilder()..update(updates))
          ._build();

  _$GetDepartments200ResponseInnerDivisionsInner._(
      {this.description,
      this.leaders,
      this.logo,
      this.motto,
      this.proxys,
      this.restricted,
      this.title})
      : super._();
  @override
  GetDepartments200ResponseInnerDivisionsInner rebuild(
          void Function(GetDepartments200ResponseInnerDivisionsInnerBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetDepartments200ResponseInnerDivisionsInnerBuilder toBuilder() =>
      GetDepartments200ResponseInnerDivisionsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetDepartments200ResponseInnerDivisionsInner &&
        description == other.description &&
        leaders == other.leaders &&
        logo == other.logo &&
        motto == other.motto &&
        proxys == other.proxys &&
        restricted == other.restricted &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, leaders.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, motto.hashCode);
    _$hash = $jc(_$hash, proxys.hashCode);
    _$hash = $jc(_$hash, restricted.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GetDepartments200ResponseInnerDivisionsInner')
          ..add('description', description)
          ..add('leaders', leaders)
          ..add('logo', logo)
          ..add('motto', motto)
          ..add('proxys', proxys)
          ..add('restricted', restricted)
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

  ListBuilder<String>? _leaders;
  ListBuilder<String> get leaders => _$this._leaders ??= ListBuilder<String>();
  set leaders(ListBuilder<String>? leaders) => _$this._leaders = leaders;

  String? _logo;
  String? get logo => _$this._logo;
  set logo(String? logo) => _$this._logo = logo;

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

  GetDepartments200ResponseInnerDivisionsInnerBuilder() {
    GetDepartments200ResponseInnerDivisionsInner._defaults(this);
  }

  GetDepartments200ResponseInnerDivisionsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _leaders = $v.leaders?.toBuilder();
      _logo = $v.logo;
      _motto = $v.motto;
      _proxys = $v.proxys?.toBuilder();
      _restricted = $v.restricted;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetDepartments200ResponseInnerDivisionsInner other) {
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
    _$GetDepartments200ResponseInnerDivisionsInner _$result;
    try {
      _$result = _$v ??
          _$GetDepartments200ResponseInnerDivisionsInner._(
            description: description,
            leaders: _leaders?.build(),
            logo: logo,
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
            r'GetDepartments200ResponseInnerDivisionsInner',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
