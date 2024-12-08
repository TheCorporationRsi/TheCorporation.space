// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_role200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateRole200Response extends UpdateRole200Response {
  @override
  final String? msg;

  factory _$UpdateRole200Response(
          [void Function(UpdateRole200ResponseBuilder)? updates]) =>
      (new UpdateRole200ResponseBuilder()..update(updates))._build();

  _$UpdateRole200Response._({this.msg}) : super._();

  @override
  UpdateRole200Response rebuild(
          void Function(UpdateRole200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateRole200ResponseBuilder toBuilder() =>
      new UpdateRole200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateRole200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'UpdateRole200Response')
          ..add('msg', msg))
        .toString();
  }
}

class UpdateRole200ResponseBuilder
    implements Builder<UpdateRole200Response, UpdateRole200ResponseBuilder> {
  _$UpdateRole200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  UpdateRole200ResponseBuilder() {
    UpdateRole200Response._defaults(this);
  }

  UpdateRole200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateRole200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdateRole200Response;
  }

  @override
  void update(void Function(UpdateRole200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateRole200Response build() => _build();

  _$UpdateRole200Response _build() {
    final _$result = _$v ?? new _$UpdateRole200Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
