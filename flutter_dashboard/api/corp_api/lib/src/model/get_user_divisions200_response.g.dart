// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_divisions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUserDivisions200Response extends GetUserDivisions200Response {
  @override
  final String? title;

  factory _$GetUserDivisions200Response(
          [void Function(GetUserDivisions200ResponseBuilder)? updates]) =>
      (new GetUserDivisions200ResponseBuilder()..update(updates))._build();

  _$GetUserDivisions200Response._({this.title}) : super._();

  @override
  GetUserDivisions200Response rebuild(
          void Function(GetUserDivisions200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUserDivisions200ResponseBuilder toBuilder() =>
      new GetUserDivisions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUserDivisions200Response && title == other.title;
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
    return (newBuiltValueToStringHelper(r'GetUserDivisions200Response')
          ..add('title', title))
        .toString();
  }
}

class GetUserDivisions200ResponseBuilder
    implements
        Builder<GetUserDivisions200Response,
            GetUserDivisions200ResponseBuilder> {
  _$GetUserDivisions200Response? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GetUserDivisions200ResponseBuilder() {
    GetUserDivisions200Response._defaults(this);
  }

  GetUserDivisions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUserDivisions200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetUserDivisions200Response;
  }

  @override
  void update(void Function(GetUserDivisions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUserDivisions200Response build() => _build();

  _$GetUserDivisions200Response _build() {
    final _$result = _$v ?? new _$GetUserDivisions200Response._(title: title);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
