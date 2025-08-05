// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_bet_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PlaceBetRequest extends PlaceBetRequest {
  @override
  final int amount;
  @override
  final String auctionId;

  factory _$PlaceBetRequest([void Function(PlaceBetRequestBuilder)? updates]) =>
      (PlaceBetRequestBuilder()..update(updates))._build();

  _$PlaceBetRequest._({required this.amount, required this.auctionId})
      : super._();
  @override
  PlaceBetRequest rebuild(void Function(PlaceBetRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlaceBetRequestBuilder toBuilder() => PlaceBetRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlaceBetRequest &&
        amount == other.amount &&
        auctionId == other.auctionId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, auctionId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PlaceBetRequest')
          ..add('amount', amount)
          ..add('auctionId', auctionId))
        .toString();
  }
}

class PlaceBetRequestBuilder
    implements Builder<PlaceBetRequest, PlaceBetRequestBuilder> {
  _$PlaceBetRequest? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  String? _auctionId;
  String? get auctionId => _$this._auctionId;
  set auctionId(String? auctionId) => _$this._auctionId = auctionId;

  PlaceBetRequestBuilder() {
    PlaceBetRequest._defaults(this);
  }

  PlaceBetRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _auctionId = $v.auctionId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlaceBetRequest other) {
    _$v = other as _$PlaceBetRequest;
  }

  @override
  void update(void Function(PlaceBetRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PlaceBetRequest build() => _build();

  _$PlaceBetRequest _build() {
    final _$result = _$v ??
        _$PlaceBetRequest._(
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'PlaceBetRequest', 'amount'),
          auctionId: BuiltValueNullFieldError.checkNotNull(
              auctionId, r'PlaceBetRequest', 'auctionId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
