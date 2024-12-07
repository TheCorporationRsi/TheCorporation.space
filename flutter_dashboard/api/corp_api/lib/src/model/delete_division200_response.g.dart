// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_division200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteDivision200Response extends DeleteDivision200Response {
  @override
  final String? msg;

  factory _$DeleteDivision200Response(
          [void Function(DeleteDivision200ResponseBuilder)? updates]) =>
      (new DeleteDivision200ResponseBuilder()..update(updates))._build();

  _$DeleteDivision200Response._({this.msg}) : super._();

  @override
  DeleteDivision200Response rebuild(
          void Function(DeleteDivision200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteDivision200ResponseBuilder toBuilder() =>
      new DeleteDivision200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteDivision200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'DeleteDivision200Response')
          ..add('msg', msg))
        .toString();
  }
}

class DeleteDivision200ResponseBuilder
    implements
        Builder<DeleteDivision200Response, DeleteDivision200ResponseBuilder> {
  _$DeleteDivision200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  DeleteDivision200ResponseBuilder() {
    DeleteDivision200Response._defaults(this);
  }

  DeleteDivision200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteDivision200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeleteDivision200Response;
  }

  @override
  void update(void Function(DeleteDivision200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteDivision200Response build() => _build();

  _$DeleteDivision200Response _build() {
    final _$result = _$v ?? new _$DeleteDivision200Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
