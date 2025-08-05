// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_role200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EditRole200Response extends EditRole200Response {
  @override
  final String? msg;

  factory _$EditRole200Response(
          [void Function(EditRole200ResponseBuilder)? updates]) =>
      (EditRole200ResponseBuilder()..update(updates))._build();

  _$EditRole200Response._({this.msg}) : super._();
  @override
  EditRole200Response rebuild(
          void Function(EditRole200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EditRole200ResponseBuilder toBuilder() =>
      EditRole200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EditRole200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'EditRole200Response')
          ..add('msg', msg))
        .toString();
  }
}

class EditRole200ResponseBuilder
    implements Builder<EditRole200Response, EditRole200ResponseBuilder> {
  _$EditRole200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  EditRole200ResponseBuilder() {
    EditRole200Response._defaults(this);
  }

  EditRole200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EditRole200Response other) {
    _$v = other as _$EditRole200Response;
  }

  @override
  void update(void Function(EditRole200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EditRole200Response build() => _build();

  _$EditRole200Response _build() {
    final _$result = _$v ??
        _$EditRole200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
