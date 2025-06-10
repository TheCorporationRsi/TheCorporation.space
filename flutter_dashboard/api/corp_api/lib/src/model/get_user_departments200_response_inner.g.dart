// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_departments200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUserDepartments200ResponseInner
    extends GetUserDepartments200ResponseInner {
  @override
  final String? color;
  @override
  final String? motto;
  @override
  final String? title;
  @override
  final int? weight;

  factory _$GetUserDepartments200ResponseInner(
          [void Function(GetUserDepartments200ResponseInnerBuilder)?
              updates]) =>
      (GetUserDepartments200ResponseInnerBuilder()..update(updates))._build();

  _$GetUserDepartments200ResponseInner._(
      {this.color, this.motto, this.title, this.weight})
      : super._();
  @override
  GetUserDepartments200ResponseInner rebuild(
          void Function(GetUserDepartments200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUserDepartments200ResponseInnerBuilder toBuilder() =>
      GetUserDepartments200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUserDepartments200ResponseInner &&
        color == other.color &&
        motto == other.motto &&
        title == other.title &&
        weight == other.weight;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, motto.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetUserDepartments200ResponseInner')
          ..add('color', color)
          ..add('motto', motto)
          ..add('title', title)
          ..add('weight', weight))
        .toString();
  }
}

class GetUserDepartments200ResponseInnerBuilder
    implements
        Builder<GetUserDepartments200ResponseInner,
            GetUserDepartments200ResponseInnerBuilder> {
  _$GetUserDepartments200ResponseInner? _$v;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _motto;
  String? get motto => _$this._motto;
  set motto(String? motto) => _$this._motto = motto;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _weight;
  int? get weight => _$this._weight;
  set weight(int? weight) => _$this._weight = weight;

  GetUserDepartments200ResponseInnerBuilder() {
    GetUserDepartments200ResponseInner._defaults(this);
  }

  GetUserDepartments200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _color = $v.color;
      _motto = $v.motto;
      _title = $v.title;
      _weight = $v.weight;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUserDepartments200ResponseInner other) {
    _$v = other as _$GetUserDepartments200ResponseInner;
  }

  @override
  void update(
      void Function(GetUserDepartments200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUserDepartments200ResponseInner build() => _build();

  _$GetUserDepartments200ResponseInner _build() {
    final _$result = _$v ??
        _$GetUserDepartments200ResponseInner._(
          color: color,
          motto: motto,
          title: title,
          weight: weight,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
