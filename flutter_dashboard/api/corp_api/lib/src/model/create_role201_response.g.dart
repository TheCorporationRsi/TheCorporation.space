// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_role201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateRole201Response extends CreateRole201Response {
  @override
  final String? msg;

  factory _$CreateRole201Response(
          [void Function(CreateRole201ResponseBuilder)? updates]) =>
      (new CreateRole201ResponseBuilder()..update(updates))._build();

  _$CreateRole201Response._({this.msg}) : super._();

  @override
  CreateRole201Response rebuild(
          void Function(CreateRole201ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateRole201ResponseBuilder toBuilder() =>
      new CreateRole201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRole201Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'CreateRole201Response')
          ..add('msg', msg))
        .toString();
  }
}

class CreateRole201ResponseBuilder
    implements Builder<CreateRole201Response, CreateRole201ResponseBuilder> {
  _$CreateRole201Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  CreateRole201ResponseBuilder() {
    CreateRole201Response._defaults(this);
  }

  CreateRole201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateRole201Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateRole201Response;
  }

  @override
  void update(void Function(CreateRole201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRole201Response build() => _build();

  _$CreateRole201Response _build() {
    final _$result = _$v ?? new _$CreateRole201Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
