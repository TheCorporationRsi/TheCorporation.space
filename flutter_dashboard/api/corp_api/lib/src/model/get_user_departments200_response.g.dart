// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_departments200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUserDepartments200Response extends GetUserDepartments200Response {
  @override
  final String? title;

  factory _$GetUserDepartments200Response(
          [void Function(GetUserDepartments200ResponseBuilder)? updates]) =>
      (GetUserDepartments200ResponseBuilder()..update(updates))._build();

  _$GetUserDepartments200Response._({this.title}) : super._();
  @override
  GetUserDepartments200Response rebuild(
          void Function(GetUserDepartments200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUserDepartments200ResponseBuilder toBuilder() =>
      GetUserDepartments200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUserDepartments200Response && title == other.title;
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
    return (newBuiltValueToStringHelper(r'GetUserDepartments200Response')
          ..add('title', title))
        .toString();
  }
}

class GetUserDepartments200ResponseBuilder
    implements
        Builder<GetUserDepartments200Response,
            GetUserDepartments200ResponseBuilder> {
  _$GetUserDepartments200Response? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GetUserDepartments200ResponseBuilder() {
    GetUserDepartments200Response._defaults(this);
  }

  GetUserDepartments200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUserDepartments200Response other) {
    _$v = other as _$GetUserDepartments200Response;
  }

  @override
  void update(void Function(GetUserDepartments200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUserDepartments200Response build() => _build();

  _$GetUserDepartments200Response _build() {
    final _$result = _$v ??
        _$GetUserDepartments200Response._(
          title: title,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
