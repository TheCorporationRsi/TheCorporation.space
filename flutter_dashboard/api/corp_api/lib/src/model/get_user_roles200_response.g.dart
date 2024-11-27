// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_roles200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUserRoles200Response extends GetUserRoles200Response {
  @override
  final String? title;

  factory _$GetUserRoles200Response(
          [void Function(GetUserRoles200ResponseBuilder)? updates]) =>
      (new GetUserRoles200ResponseBuilder()..update(updates))._build();

  _$GetUserRoles200Response._({this.title}) : super._();

  @override
  GetUserRoles200Response rebuild(
          void Function(GetUserRoles200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUserRoles200ResponseBuilder toBuilder() =>
      new GetUserRoles200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUserRoles200Response && title == other.title;
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
    return (newBuiltValueToStringHelper(r'GetUserRoles200Response')
          ..add('title', title))
        .toString();
  }
}

class GetUserRoles200ResponseBuilder
    implements
        Builder<GetUserRoles200Response, GetUserRoles200ResponseBuilder> {
  _$GetUserRoles200Response? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GetUserRoles200ResponseBuilder() {
    GetUserRoles200Response._defaults(this);
  }

  GetUserRoles200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUserRoles200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetUserRoles200Response;
  }

  @override
  void update(void Function(GetUserRoles200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUserRoles200Response build() => _build();

  _$GetUserRoles200Response _build() {
    final _$result = _$v ?? new _$GetUserRoles200Response._(title: title);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
