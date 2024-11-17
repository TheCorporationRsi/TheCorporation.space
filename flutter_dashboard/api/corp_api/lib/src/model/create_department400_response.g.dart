// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_department400_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateDepartment400Response extends CreateDepartment400Response {
  @override
  final String? msg;

  factory _$CreateDepartment400Response(
          [void Function(CreateDepartment400ResponseBuilder)? updates]) =>
      (new CreateDepartment400ResponseBuilder()..update(updates))._build();

  _$CreateDepartment400Response._({this.msg}) : super._();

  @override
  CreateDepartment400Response rebuild(
          void Function(CreateDepartment400ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateDepartment400ResponseBuilder toBuilder() =>
      new CreateDepartment400ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateDepartment400Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'CreateDepartment400Response')
          ..add('msg', msg))
        .toString();
  }
}

class CreateDepartment400ResponseBuilder
    implements
        Builder<CreateDepartment400Response,
            CreateDepartment400ResponseBuilder> {
  _$CreateDepartment400Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  CreateDepartment400ResponseBuilder() {
    CreateDepartment400Response._defaults(this);
  }

  CreateDepartment400ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateDepartment400Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateDepartment400Response;
  }

  @override
  void update(void Function(CreateDepartment400ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateDepartment400Response build() => _build();

  _$CreateDepartment400Response _build() {
    final _$result = _$v ?? new _$CreateDepartment400Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
