// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_rsi_token200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyRSIToken200Response extends VerifyRSIToken200Response {
  @override
  final String? message;

  factory _$VerifyRSIToken200Response(
          [void Function(VerifyRSIToken200ResponseBuilder)? updates]) =>
      (new VerifyRSIToken200ResponseBuilder()..update(updates))._build();

  _$VerifyRSIToken200Response._({this.message}) : super._();

  @override
  VerifyRSIToken200Response rebuild(
          void Function(VerifyRSIToken200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyRSIToken200ResponseBuilder toBuilder() =>
      new VerifyRSIToken200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyRSIToken200Response && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyRSIToken200Response')
          ..add('message', message))
        .toString();
  }
}

class VerifyRSIToken200ResponseBuilder
    implements
        Builder<VerifyRSIToken200Response, VerifyRSIToken200ResponseBuilder> {
  _$VerifyRSIToken200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  VerifyRSIToken200ResponseBuilder() {
    VerifyRSIToken200Response._defaults(this);
  }

  VerifyRSIToken200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyRSIToken200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VerifyRSIToken200Response;
  }

  @override
  void update(void Function(VerifyRSIToken200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyRSIToken200Response build() => _build();

  _$VerifyRSIToken200Response _build() {
    final _$result = _$v ?? new _$VerifyRSIToken200Response._(message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
