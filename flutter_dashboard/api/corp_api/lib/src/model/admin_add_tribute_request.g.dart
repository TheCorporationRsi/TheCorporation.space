// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_add_tribute_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminAddTributeRequest extends AdminAddTributeRequest {
  @override
  final int? amount;
  @override
  final String? rsiHandle;

  factory _$AdminAddTributeRequest(
          [void Function(AdminAddTributeRequestBuilder)? updates]) =>
      (AdminAddTributeRequestBuilder()..update(updates))._build();

  _$AdminAddTributeRequest._({this.amount, this.rsiHandle}) : super._();
  @override
  AdminAddTributeRequest rebuild(
          void Function(AdminAddTributeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminAddTributeRequestBuilder toBuilder() =>
      AdminAddTributeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminAddTributeRequest &&
        amount == other.amount &&
        rsiHandle == other.rsiHandle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, rsiHandle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminAddTributeRequest')
          ..add('amount', amount)
          ..add('rsiHandle', rsiHandle))
        .toString();
  }
}

class AdminAddTributeRequestBuilder
    implements Builder<AdminAddTributeRequest, AdminAddTributeRequestBuilder> {
  _$AdminAddTributeRequest? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  String? _rsiHandle;
  String? get rsiHandle => _$this._rsiHandle;
  set rsiHandle(String? rsiHandle) => _$this._rsiHandle = rsiHandle;

  AdminAddTributeRequestBuilder() {
    AdminAddTributeRequest._defaults(this);
  }

  AdminAddTributeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _rsiHandle = $v.rsiHandle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminAddTributeRequest other) {
    _$v = other as _$AdminAddTributeRequest;
  }

  @override
  void update(void Function(AdminAddTributeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminAddTributeRequest build() => _build();

  _$AdminAddTributeRequest _build() {
    final _$result = _$v ??
        _$AdminAddTributeRequest._(
          amount: amount,
          rsiHandle: rsiHandle,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
