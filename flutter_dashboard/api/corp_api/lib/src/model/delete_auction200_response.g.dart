// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_auction200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteAuction200Response extends DeleteAuction200Response {
  @override
  final String? msg;

  factory _$DeleteAuction200Response(
          [void Function(DeleteAuction200ResponseBuilder)? updates]) =>
      (DeleteAuction200ResponseBuilder()..update(updates))._build();

  _$DeleteAuction200Response._({this.msg}) : super._();
  @override
  DeleteAuction200Response rebuild(
          void Function(DeleteAuction200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteAuction200ResponseBuilder toBuilder() =>
      DeleteAuction200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteAuction200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'DeleteAuction200Response')
          ..add('msg', msg))
        .toString();
  }
}

class DeleteAuction200ResponseBuilder
    implements
        Builder<DeleteAuction200Response, DeleteAuction200ResponseBuilder> {
  _$DeleteAuction200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  DeleteAuction200ResponseBuilder() {
    DeleteAuction200Response._defaults(this);
  }

  DeleteAuction200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteAuction200Response other) {
    _$v = other as _$DeleteAuction200Response;
  }

  @override
  void update(void Function(DeleteAuction200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteAuction200Response build() => _build();

  _$DeleteAuction200Response _build() {
    final _$result = _$v ??
        _$DeleteAuction200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
