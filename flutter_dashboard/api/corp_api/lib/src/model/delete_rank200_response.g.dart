// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_rank200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteRank200Response extends DeleteRank200Response {
  @override
  final String? msg;

  factory _$DeleteRank200Response(
          [void Function(DeleteRank200ResponseBuilder)? updates]) =>
      (DeleteRank200ResponseBuilder()..update(updates))._build();

  _$DeleteRank200Response._({this.msg}) : super._();
  @override
  DeleteRank200Response rebuild(
          void Function(DeleteRank200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteRank200ResponseBuilder toBuilder() =>
      DeleteRank200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteRank200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'DeleteRank200Response')
          ..add('msg', msg))
        .toString();
  }
}

class DeleteRank200ResponseBuilder
    implements Builder<DeleteRank200Response, DeleteRank200ResponseBuilder> {
  _$DeleteRank200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  DeleteRank200ResponseBuilder() {
    DeleteRank200Response._defaults(this);
  }

  DeleteRank200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteRank200Response other) {
    _$v = other as _$DeleteRank200Response;
  }

  @override
  void update(void Function(DeleteRank200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteRank200Response build() => _build();

  _$DeleteRank200Response _build() {
    final _$result = _$v ??
        _$DeleteRank200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
