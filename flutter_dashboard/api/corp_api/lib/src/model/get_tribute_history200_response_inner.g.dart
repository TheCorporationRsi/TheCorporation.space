// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tribute_history200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetTributeHistory200ResponseInner
    extends GetTributeHistory200ResponseInner {
  @override
  final int? amount;
  @override
  final String? message;
  @override
  final String? method;
  @override
  final String? receiver;

  factory _$GetTributeHistory200ResponseInner(
          [void Function(GetTributeHistory200ResponseInnerBuilder)? updates]) =>
      (new GetTributeHistory200ResponseInnerBuilder()..update(updates))
          ._build();

  _$GetTributeHistory200ResponseInner._(
      {this.amount, this.message, this.method, this.receiver})
      : super._();

  @override
  GetTributeHistory200ResponseInner rebuild(
          void Function(GetTributeHistory200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetTributeHistory200ResponseInnerBuilder toBuilder() =>
      new GetTributeHistory200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetTributeHistory200ResponseInner &&
        amount == other.amount &&
        message == other.message &&
        method == other.method &&
        receiver == other.receiver;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, receiver.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetTributeHistory200ResponseInner')
          ..add('amount', amount)
          ..add('message', message)
          ..add('method', method)
          ..add('receiver', receiver))
        .toString();
  }
}

class GetTributeHistory200ResponseInnerBuilder
    implements
        Builder<GetTributeHistory200ResponseInner,
            GetTributeHistory200ResponseInnerBuilder> {
  _$GetTributeHistory200ResponseInner? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _method;
  String? get method => _$this._method;
  set method(String? method) => _$this._method = method;

  String? _receiver;
  String? get receiver => _$this._receiver;
  set receiver(String? receiver) => _$this._receiver = receiver;

  GetTributeHistory200ResponseInnerBuilder() {
    GetTributeHistory200ResponseInner._defaults(this);
  }

  GetTributeHistory200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _message = $v.message;
      _method = $v.method;
      _receiver = $v.receiver;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetTributeHistory200ResponseInner other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetTributeHistory200ResponseInner;
  }

  @override
  void update(
      void Function(GetTributeHistory200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetTributeHistory200ResponseInner build() => _build();

  _$GetTributeHistory200ResponseInner _build() {
    final _$result = _$v ??
        new _$GetTributeHistory200ResponseInner._(
            amount: amount,
            message: message,
            method: method,
            receiver: receiver);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
