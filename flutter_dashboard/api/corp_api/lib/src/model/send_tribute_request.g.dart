// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_tribute_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendTributeRequest extends SendTributeRequest {
  @override
  final int? amount;
  @override
  final String? message;
  @override
  final String? receiverHandle;

  factory _$SendTributeRequest(
          [void Function(SendTributeRequestBuilder)? updates]) =>
      (new SendTributeRequestBuilder()..update(updates))._build();

  _$SendTributeRequest._({this.amount, this.message, this.receiverHandle})
      : super._();

  @override
  SendTributeRequest rebuild(
          void Function(SendTributeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendTributeRequestBuilder toBuilder() =>
      new SendTributeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendTributeRequest &&
        amount == other.amount &&
        message == other.message &&
        receiverHandle == other.receiverHandle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, receiverHandle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendTributeRequest')
          ..add('amount', amount)
          ..add('message', message)
          ..add('receiverHandle', receiverHandle))
        .toString();
  }
}

class SendTributeRequestBuilder
    implements Builder<SendTributeRequest, SendTributeRequestBuilder> {
  _$SendTributeRequest? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _receiverHandle;
  String? get receiverHandle => _$this._receiverHandle;
  set receiverHandle(String? receiverHandle) =>
      _$this._receiverHandle = receiverHandle;

  SendTributeRequestBuilder() {
    SendTributeRequest._defaults(this);
  }

  SendTributeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _message = $v.message;
      _receiverHandle = $v.receiverHandle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendTributeRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SendTributeRequest;
  }

  @override
  void update(void Function(SendTributeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendTributeRequest build() => _build();

  _$SendTributeRequest _build() {
    final _$result = _$v ??
        new _$SendTributeRequest._(
            amount: amount, message: message, receiverHandle: receiverHandle);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
