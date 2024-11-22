// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_rsi_token401_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetRSIToken401Response extends GetRSIToken401Response {
  @override
  final String? msg;

  factory _$GetRSIToken401Response(
          [void Function(GetRSIToken401ResponseBuilder)? updates]) =>
      (new GetRSIToken401ResponseBuilder()..update(updates))._build();

  _$GetRSIToken401Response._({this.msg}) : super._();

  @override
  GetRSIToken401Response rebuild(
          void Function(GetRSIToken401ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetRSIToken401ResponseBuilder toBuilder() =>
      new GetRSIToken401ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetRSIToken401Response && msg == other.msg;
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
    return (newBuiltValueToStringHelper(r'GetRSIToken401Response')
          ..add('msg', msg))
        .toString();
  }
}

class GetRSIToken401ResponseBuilder
    implements Builder<GetRSIToken401Response, GetRSIToken401ResponseBuilder> {
  _$GetRSIToken401Response? _$v;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  GetRSIToken401ResponseBuilder() {
    GetRSIToken401Response._defaults(this);
  }

  GetRSIToken401ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetRSIToken401Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetRSIToken401Response;
  }

  @override
  void update(void Function(GetRSIToken401ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetRSIToken401Response build() => _build();

  _$GetRSIToken401Response _build() {
    final _$result = _$v ?? new _$GetRSIToken401Response._(msg: msg);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
