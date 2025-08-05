// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteUser200Response extends DeleteUser200Response {
  @override
  final String? msg;

  factory _$DeleteUser200Response(
          [void Function(DeleteUser200ResponseBuilder)? updates]) =>
      (DeleteUser200ResponseBuilder()..update(updates))._build();

  _$DeleteUser200Response._({this.msg}) : super._();
  @override
  DeleteUser200Response rebuild(
          void Function(DeleteUser200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteUser200ResponseBuilder toBuilder() =>
      DeleteUser200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteUser200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'DeleteUser200Response')
          ..add('msg', msg))
        .toString();
  }
}

class DeleteUser200ResponseBuilder
    implements Builder<DeleteUser200Response, DeleteUser200ResponseBuilder> {
  _$DeleteUser200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  DeleteUser200ResponseBuilder() {
    DeleteUser200Response._defaults(this);
  }

  DeleteUser200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteUser200Response other) {
    _$v = other as _$DeleteUser200Response;
  }

  @override
  void update(void Function(DeleteUser200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteUser200Response build() => _build();

  _$DeleteUser200Response _build() {
    final _$result = _$v ??
        _$DeleteUser200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
