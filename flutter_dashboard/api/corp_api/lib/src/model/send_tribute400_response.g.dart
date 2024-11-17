// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_tribute400_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendTribute400Response extends SendTribute400Response {
  @override
  final String? message;

  factory _$SendTribute400Response(
          [void Function(SendTribute400ResponseBuilder)? updates]) =>
      (new SendTribute400ResponseBuilder()..update(updates))._build();

  _$SendTribute400Response._({this.message}) : super._();

  @override
  SendTribute400Response rebuild(
          void Function(SendTribute400ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendTribute400ResponseBuilder toBuilder() =>
      new SendTribute400ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendTribute400Response && message == other.message;
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
    return (newBuiltValueToStringHelper(r'SendTribute400Response')
          ..add('message', message))
        .toString();
  }
}

class SendTribute400ResponseBuilder
    implements Builder<SendTribute400Response, SendTribute400ResponseBuilder> {
  _$SendTribute400Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SendTribute400ResponseBuilder() {
    SendTribute400Response._defaults(this);
  }

  SendTribute400ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendTribute400Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SendTribute400Response;
  }

  @override
  void update(void Function(SendTribute400ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendTribute400Response build() => _build();

  _$SendTribute400Response _build() {
    final _$result = _$v ?? new _$SendTribute400Response._(message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
