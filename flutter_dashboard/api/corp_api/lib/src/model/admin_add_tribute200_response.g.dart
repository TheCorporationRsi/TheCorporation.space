// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_add_tribute200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminAddTribute200Response extends AdminAddTribute200Response {
  @override
  final String? msg;

  factory _$AdminAddTribute200Response(
          [void Function(AdminAddTribute200ResponseBuilder)? updates]) =>
      (AdminAddTribute200ResponseBuilder()..update(updates))._build();

  _$AdminAddTribute200Response._({this.msg}) : super._();
  @override
  AdminAddTribute200Response rebuild(
          void Function(AdminAddTribute200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminAddTribute200ResponseBuilder toBuilder() =>
      AdminAddTribute200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminAddTribute200Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'AdminAddTribute200Response')
          ..add('msg', msg))
        .toString();
  }
}

class AdminAddTribute200ResponseBuilder
    implements
        Builder<AdminAddTribute200Response, AdminAddTribute200ResponseBuilder> {
  _$AdminAddTribute200Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  AdminAddTribute200ResponseBuilder() {
    AdminAddTribute200Response._defaults(this);
  }

  AdminAddTribute200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminAddTribute200Response other) {
    _$v = other as _$AdminAddTribute200Response;
  }

  @override
  void update(void Function(AdminAddTribute200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminAddTribute200Response build() => _build();

  _$AdminAddTribute200Response _build() {
    final _$result = _$v ??
        _$AdminAddTribute200Response._(
          msg: msg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
