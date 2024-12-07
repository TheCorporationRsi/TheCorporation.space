// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_role200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteRole200Response extends DeleteRole200Response {
  @override
  final String? msg;

  factory _$DeleteRole200Response(
          [void Function(DeleteRole200ResponseBuilder)? updates]) =>
      (new DeleteRole200ResponseBuilder()..update(updates))._build();

  _$DeleteRole200Response._({this.msg}) : super._();

  @override
  DeleteRole200Response rebuild(
          void Function(DeleteRole200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteRole200ResponseBuilder toBuilder() =>
      new DeleteRole200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteRole200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'DeleteRole200Response')
          ..add('msg', msg))
        .toString();
  }
}

class DeleteRole200ResponseBuilder
    implements Builder<DeleteRole200Response, DeleteRole200ResponseBuilder> {
  _$DeleteRole200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  DeleteRole200ResponseBuilder() {
    DeleteRole200Response._defaults(this);
  }

  DeleteRole200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteRole200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeleteRole200Response;
  }

  @override
  void update(void Function(DeleteRole200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteRole200Response build() => _build();

  _$DeleteRole200Response _build() {
    final _$result = _$v ?? new _$DeleteRole200Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
