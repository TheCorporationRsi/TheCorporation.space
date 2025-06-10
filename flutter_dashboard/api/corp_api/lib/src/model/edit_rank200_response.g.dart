// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_rank200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EditRank200Response extends EditRank200Response {
  @override
  final String? msg;

  factory _$EditRank200Response(
          [void Function(EditRank200ResponseBuilder)? updates]) =>
      (EditRank200ResponseBuilder()..update(updates))._build();

  _$EditRank200Response._({this.msg}) : super._();
  @override
  EditRank200Response rebuild(
          void Function(EditRank200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EditRank200ResponseBuilder toBuilder() =>
      EditRank200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EditRank200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'EditRank200Response')
          ..add('msg', msg))
        .toString();
  }
}

class EditRank200ResponseBuilder
    implements Builder<EditRank200Response, EditRank200ResponseBuilder> {
  _$EditRank200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  EditRank200ResponseBuilder() {
    EditRank200Response._defaults(this);
  }

  EditRank200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EditRank200Response other) {
    _$v = other as _$EditRank200Response;
  }

  @override
  void update(void Function(EditRank200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EditRank200Response build() => _build();

  _$EditRank200Response _build() {
    final _$result = _$v ??
        _$EditRank200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
