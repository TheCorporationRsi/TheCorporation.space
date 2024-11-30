// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_departments200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetDepartments200Response extends GetDepartments200Response {
  @override
  final String? color;
  @override
  final BuiltList<String>? division;
  @override
  final BuiltList<String>? heads;
  @override
  final int? memberCount;
  @override
  final String? motto;
  @override
  final BuiltList<String>? proxys;
  @override
  final String? title;

  factory _$GetDepartments200Response(
          [void Function(GetDepartments200ResponseBuilder)? updates]) =>
      (new GetDepartments200ResponseBuilder()..update(updates))._build();

  _$GetDepartments200Response._(
      {this.color,
      this.division,
      this.heads,
      this.memberCount,
      this.motto,
      this.proxys,
      this.title})
      : super._();

  @override
  GetDepartments200Response rebuild(
          void Function(GetDepartments200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetDepartments200ResponseBuilder toBuilder() =>
      new GetDepartments200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetDepartments200Response &&
        color == other.color &&
        division == other.division &&
        heads == other.heads &&
        memberCount == other.memberCount &&
        motto == other.motto &&
        proxys == other.proxys &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, division.hashCode);
    _$hash = $jc(_$hash, heads.hashCode);
    _$hash = $jc(_$hash, memberCount.hashCode);
    _$hash = $jc(_$hash, motto.hashCode);
    _$hash = $jc(_$hash, proxys.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetDepartments200Response')
          ..add('color', color)
          ..add('division', division)
          ..add('heads', heads)
          ..add('memberCount', memberCount)
          ..add('motto', motto)
          ..add('proxys', proxys)
          ..add('title', title))
        .toString();
  }
}

class GetDepartments200ResponseBuilder
    implements
        Builder<GetDepartments200Response, GetDepartments200ResponseBuilder> {
  _$GetDepartments200Response? _$v;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  ListBuilder<String>? _division;
  ListBuilder<String> get division =>
      _$this._division ??= new ListBuilder<String>();
  set division(ListBuilder<String>? division) => _$this._division = division;

  ListBuilder<String>? _heads;
  ListBuilder<String> get heads => _$this._heads ??= new ListBuilder<String>();
  set heads(ListBuilder<String>? heads) => _$this._heads = heads;

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

  GetDepartments200ResponseBuilder() {
    GetDepartments200Response._defaults(this);
  }

  GetDepartments200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _color = $v.color;
      _division = $v.division?.toBuilder();
      _heads = $v.heads?.toBuilder();
      _memberCount = $v.memberCount;
      _motto = $v.motto;
      _proxys = $v.proxys?.toBuilder();
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetDepartments200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetDepartments200Response;
  }

  @override
  void update(void Function(GetDepartments200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetDepartments200Response build() => _build();

  _$GetDepartments200Response _build() {
    _$GetDepartments200Response _$result;
    try {
      _$result = _$v ??
          new _$GetDepartments200Response._(
              color: color,
              division: _division?.build(),
              heads: _heads?.build(),
              memberCount: memberCount,
              motto: motto,
              proxys: _proxys?.build(),
              title: title);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'division';
        _division?.build();
        _$failedField = 'heads';
        _heads?.build();

        _$failedField = 'proxys';
        _proxys?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetDepartments200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
