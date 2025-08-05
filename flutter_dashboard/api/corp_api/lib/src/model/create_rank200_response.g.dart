// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_rank200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateRank200Response extends CreateRank200Response {
  @override
  final String? msg;

  factory _$CreateRank200Response(
          [void Function(CreateRank200ResponseBuilder)? updates]) =>
      (CreateRank200ResponseBuilder()..update(updates))._build();

  _$CreateRank200Response._({this.msg}) : super._();
  @override
  CreateRank200Response rebuild(
          void Function(CreateRank200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateRank200ResponseBuilder toBuilder() =>
      CreateRank200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRank200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'CreateRank200Response')
          ..add('msg', msg))
        .toString();
  }
}

class CreateRank200ResponseBuilder
    implements Builder<CreateRank200Response, CreateRank200ResponseBuilder> {
  _$CreateRank200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  CreateRank200ResponseBuilder() {
    CreateRank200Response._defaults(this);
  }

  CreateRank200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateRank200Response other) {
    _$v = other as _$CreateRank200Response;
  }

  @override
  void update(void Function(CreateRank200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRank200Response build() => _build();

  _$CreateRank200Response _build() {
    final _$result = _$v ??
        _$CreateRank200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
