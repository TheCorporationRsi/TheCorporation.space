// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_weight_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetWeightRequest extends SetWeightRequest {
  @override
  final int amount;
  @override
  final String divisionTitle;

  factory _$SetWeightRequest(
          [void Function(SetWeightRequestBuilder)? updates]) =>
      (new SetWeightRequestBuilder()..update(updates))._build();

  _$SetWeightRequest._({required this.amount, required this.divisionTitle})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        amount, r'SetWeightRequest', 'amount');
    BuiltValueNullFieldError.checkNotNull(
        divisionTitle, r'SetWeightRequest', 'divisionTitle');
  }

  @override
  SetWeightRequest rebuild(void Function(SetWeightRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetWeightRequestBuilder toBuilder() =>
      new SetWeightRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetWeightRequest &&
        amount == other.amount &&
        divisionTitle == other.divisionTitle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, divisionTitle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetWeightRequest')
          ..add('amount', amount)
          ..add('divisionTitle', divisionTitle))
        .toString();
  }
}

class SetWeightRequestBuilder
    implements Builder<SetWeightRequest, SetWeightRequestBuilder> {
  _$SetWeightRequest? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  String? _divisionTitle;
  String? get divisionTitle => _$this._divisionTitle;
  set divisionTitle(String? divisionTitle) =>
      _$this._divisionTitle = divisionTitle;

  SetWeightRequestBuilder() {
    SetWeightRequest._defaults(this);
  }

  SetWeightRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _divisionTitle = $v.divisionTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetWeightRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SetWeightRequest;
  }

  @override
  void update(void Function(SetWeightRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetWeightRequest build() => _build();

  _$SetWeightRequest _build() {
    final _$result = _$v ??
        new _$SetWeightRequest._(
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'SetWeightRequest', 'amount'),
            divisionTitle: BuiltValueNullFieldError.checkNotNull(
                divisionTitle, r'SetWeightRequest', 'divisionTitle'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
