// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_tribute_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendTributeRequest extends SendTributeRequest {
  @override
  final int amount;
  @override
  final String receiverHandle;
  @override
  final String? message;

  factory _$SendTributeRequest(
          [void Function(SendTributeRequestBuilder)? updates]) =>
      (SendTributeRequestBuilder()..update(updates))._build();

  _$SendTributeRequest._(
      {required this.amount, required this.receiverHandle, this.message})
      : super._();
  @override
  SendTributeRequest rebuild(
          void Function(SendTributeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendTributeRequestBuilder toBuilder() =>
      SendTributeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendTributeRequest &&
        amount == other.amount &&
        receiverHandle == other.receiverHandle &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, receiverHandle.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendTributeRequest')
          ..add('amount', amount)
          ..add('receiverHandle', receiverHandle)
          ..add('message', message))
        .toString();
  }
}

class SendTributeRequestBuilder
    implements Builder<SendTributeRequest, SendTributeRequestBuilder> {
  _$SendTributeRequest? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  String? _receiverHandle;
  String? get receiverHandle => _$this._receiverHandle;
  set receiverHandle(String? receiverHandle) =>
      _$this._receiverHandle = receiverHandle;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SendTributeRequestBuilder() {
    SendTributeRequest._defaults(this);
  }

  SendTributeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _receiverHandle = $v.receiverHandle;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendTributeRequest other) {
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
        _$SendTributeRequest._(
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'SendTributeRequest', 'amount'),
          receiverHandle: BuiltValueNullFieldError.checkNotNull(
              receiverHandle, r'SendTributeRequest', 'receiverHandle'),
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
