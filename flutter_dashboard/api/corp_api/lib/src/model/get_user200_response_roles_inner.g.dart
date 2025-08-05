// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user200_response_roles_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUser200ResponseRolesInner extends GetUser200ResponseRolesInner {
  @override
  final String? color;
  @override
  final String? title;

  factory _$GetUser200ResponseRolesInner(
          [void Function(GetUser200ResponseRolesInnerBuilder)? updates]) =>
      (GetUser200ResponseRolesInnerBuilder()..update(updates))._build();

  _$GetUser200ResponseRolesInner._({this.color, this.title}) : super._();
  @override
  GetUser200ResponseRolesInner rebuild(
          void Function(GetUser200ResponseRolesInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUser200ResponseRolesInnerBuilder toBuilder() =>
      GetUser200ResponseRolesInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUser200ResponseRolesInner &&
        color == other.color &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetUser200ResponseRolesInner')
          ..add('color', color)
          ..add('title', title))
        .toString();
  }
}

class GetUser200ResponseRolesInnerBuilder
    implements
        Builder<GetUser200ResponseRolesInner,
            GetUser200ResponseRolesInnerBuilder> {
  _$GetUser200ResponseRolesInner? _$v;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GetUser200ResponseRolesInnerBuilder() {
    GetUser200ResponseRolesInner._defaults(this);
  }

  GetUser200ResponseRolesInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _color = $v.color;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUser200ResponseRolesInner other) {
    _$v = other as _$GetUser200ResponseRolesInner;
  }

  @override
  void update(void Function(GetUser200ResponseRolesInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUser200ResponseRolesInner build() => _build();

  _$GetUser200ResponseRolesInner _build() {
    final _$result = _$v ??
        _$GetUser200ResponseRolesInner._(
          color: color,
          title: title,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
