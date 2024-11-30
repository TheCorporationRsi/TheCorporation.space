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
  final BuiltList<String>? leaders;
  @override
  final int? memberCount;
  @override
  final String? motto;
  @override
  final BuiltList<String>? proxys;
  @override
  final String? title;

  factory _$GetDivisions200ResponseInner(
          [void Function(GetDivisions200ResponseInnerBuilder)? updates]) =>
      (new GetDivisions200ResponseInnerBuilder()..update(updates))._build();

  _$GetDivisions200ResponseInner._(
      {this.color,
      this.departmentTitle,
      this.leaders,
      this.memberCount,
      this.motto,
      this.proxys,
      this.title})
      : super._();

  @override
  GetDivisions200ResponseInner rebuild(
          void Function(GetDivisions200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetDivisions200ResponseInnerBuilder toBuilder() =>
      new GetDivisions200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetDivisions200ResponseInner &&
        color == other.color &&
        departmentTitle == other.departmentTitle &&
        leaders == other.leaders &&
        memberCount == other.memberCount &&
        motto == other.motto &&
        proxys == other.proxys &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, departmentTitle.hashCode);
    _$hash = $jc(_$hash, leaders.hashCode);
    _$hash = $jc(_$hash, memberCount.hashCode);
    _$hash = $jc(_$hash, motto.hashCode);
    _$hash = $jc(_$hash, proxys.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetDivisions200ResponseInner')
          ..add('color', color)
          ..add('departmentTitle', departmentTitle)
          ..add('leaders', leaders)
          ..add('memberCount', memberCount)
          ..add('motto', motto)
          ..add('proxys', proxys)
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

  ListBuilder<String>? _leaders;
  ListBuilder<String> get leaders =>
      _$this._leaders ??= new ListBuilder<String>();
  set leaders(ListBuilder<String>? leaders) => _$this._leaders = leaders;

  int? _memberCount;
  int? get memberCount => _$this._memberCount;
  set memberCount(int? memberCount) => _$this._memberCount = memberCount;

  String? _motto;
  String? get motto => _$this._motto;
  set motto(String? motto) => _$this._motto = motto;

  ListBuilder<String>? _proxys;
  ListBuilder<String> get proxys =>
      _$this._proxys ??= new ListBuilder<String>();
  set proxys(ListBuilder<String>? proxys) => _$this._proxys = proxys;

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
      _leaders = $v.leaders?.toBuilder();
      _memberCount = $v.memberCount;
      _motto = $v.motto;
      _proxys = $v.proxys?.toBuilder();
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetDivisions200ResponseInner other) {
    ArgumentError.checkNotNull(other, 'other');
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
          new _$GetDivisions200ResponseInner._(
              color: color,
              departmentTitle: departmentTitle,
              leaders: _leaders?.build(),
              memberCount: memberCount,
              motto: motto,
              proxys: _proxys?.build(),
              title: title);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'leaders';
        _leaders?.build();

        _$failedField = 'proxys';
        _proxys?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetDivisions200ResponseInner', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
