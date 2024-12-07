// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_roles200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetRoles200ResponseInner extends GetRoles200ResponseInner {
  @override
  final String? title;

  factory _$GetRoles200ResponseInner(
          [void Function(GetRoles200ResponseInnerBuilder)? updates]) =>
      (new GetRoles200ResponseInnerBuilder()..update(updates))._build();

  _$GetRoles200ResponseInner._({this.title}) : super._();

  @override
  GetRoles200ResponseInner rebuild(
          void Function(GetRoles200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetRoles200ResponseInnerBuilder toBuilder() =>
      new GetRoles200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetRoles200ResponseInner && title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetRoles200ResponseInner')
          ..add('title', title))
        .toString();
  }
}

class GetRoles200ResponseInnerBuilder
    implements
        Builder<GetRoles200ResponseInner, GetRoles200ResponseInnerBuilder> {
  _$GetRoles200ResponseInner? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GetRoles200ResponseInnerBuilder() {
    GetRoles200ResponseInner._defaults(this);
  }

  GetRoles200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetRoles200ResponseInner other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetRoles200ResponseInner;
  }

  @override
  void update(void Function(GetRoles200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetRoles200ResponseInner build() => _build();

  _$GetRoles200ResponseInner _build() {
    final _$result = _$v ?? new _$GetRoles200ResponseInner._(title: title);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
