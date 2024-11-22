// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_division200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateDivision200Response extends CreateDivision200Response {
  @override
  final String? msg;

  factory _$CreateDivision200Response(
          [void Function(CreateDivision200ResponseBuilder)? updates]) =>
      (new CreateDivision200ResponseBuilder()..update(updates))._build();

  _$CreateDivision200Response._({this.msg}) : super._();

  @override
  CreateDivision200Response rebuild(
          void Function(CreateDivision200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateDivision200ResponseBuilder toBuilder() =>
      new CreateDivision200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateDivision200Response && msg == other.msg;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, msg.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateDivision200Response')
          ..add('msg', msg))
        .toString();
  }
}

class CreateDivision200ResponseBuilder
    implements
        Builder<CreateDivision200Response, CreateDivision200ResponseBuilder> {
  _$CreateDivision200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  CreateDivision200ResponseBuilder() {
    CreateDivision200Response._defaults(this);
  }

  CreateDivision200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateDivision200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateDivision200Response;
  }

  @override
  void update(void Function(CreateDivision200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateDivision200Response build() => _build();

  _$CreateDivision200Response _build() {
    final _$result = _$v ?? new _$CreateDivision200Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
