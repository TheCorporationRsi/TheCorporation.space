// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_v0_structure_profile_roles_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiV0StructureProfileRolesGet200Response
    extends ApiV0StructureProfileRolesGet200Response {
  @override
  final String? title;

  factory _$ApiV0StructureProfileRolesGet200Response(
          [void Function(ApiV0StructureProfileRolesGet200ResponseBuilder)?
              updates]) =>
      (new ApiV0StructureProfileRolesGet200ResponseBuilder()..update(updates))
          ._build();

  _$ApiV0StructureProfileRolesGet200Response._({this.title}) : super._();

  @override
  ApiV0StructureProfileRolesGet200Response rebuild(
          void Function(ApiV0StructureProfileRolesGet200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApiV0StructureProfileRolesGet200ResponseBuilder toBuilder() =>
      new ApiV0StructureProfileRolesGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiV0StructureProfileRolesGet200Response &&
        title == other.title;
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
    return (newBuiltValueToStringHelper(
            r'ApiV0StructureProfileRolesGet200Response')
          ..add('title', title))
        .toString();
  }
}

class ApiV0StructureProfileRolesGet200ResponseBuilder
    implements
        Builder<ApiV0StructureProfileRolesGet200Response,
            ApiV0StructureProfileRolesGet200ResponseBuilder> {
  _$ApiV0StructureProfileRolesGet200Response? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ApiV0StructureProfileRolesGet200ResponseBuilder() {
    ApiV0StructureProfileRolesGet200Response._defaults(this);
  }

  ApiV0StructureProfileRolesGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiV0StructureProfileRolesGet200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ApiV0StructureProfileRolesGet200Response;
  }

  @override
  void update(
      void Function(ApiV0StructureProfileRolesGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiV0StructureProfileRolesGet200Response build() => _build();

  _$ApiV0StructureProfileRolesGet200Response _build() {
    final _$result =
        _$v ?? new _$ApiV0StructureProfileRolesGet200Response._(title: title);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
