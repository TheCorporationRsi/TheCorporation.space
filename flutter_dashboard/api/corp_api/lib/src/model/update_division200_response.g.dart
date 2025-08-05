// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_division200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateDivision200Response extends UpdateDivision200Response {
  @override
  final String? msg;

  factory _$UpdateDivision200Response(
          [void Function(UpdateDivision200ResponseBuilder)? updates]) =>
      (UpdateDivision200ResponseBuilder()..update(updates))._build();

  _$UpdateDivision200Response._({this.msg}) : super._();
  @override
  UpdateDivision200Response rebuild(
          void Function(UpdateDivision200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateDivision200ResponseBuilder toBuilder() =>
      UpdateDivision200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateDivision200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'UpdateDivision200Response')
          ..add('msg', msg))
        .toString();
  }
}

class UpdateDivision200ResponseBuilder
    implements
        Builder<UpdateDivision200Response, UpdateDivision200ResponseBuilder> {
  _$UpdateDivision200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  UpdateDivision200ResponseBuilder() {
    UpdateDivision200Response._defaults(this);
  }

  UpdateDivision200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateDivision200Response other) {
    _$v = other as _$UpdateDivision200Response;
  }

  @override
  void update(void Function(UpdateDivision200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateDivision200Response build() => _build();

  _$UpdateDivision200Response _build() {
    final _$result = _$v ??
        _$UpdateDivision200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
