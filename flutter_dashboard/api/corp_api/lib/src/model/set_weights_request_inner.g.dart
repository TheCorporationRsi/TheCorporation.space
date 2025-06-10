// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_weights_request_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetWeightsRequestInner extends SetWeightsRequestInner {
  @override
  final int? amount;
  @override
  final String? title;

  factory _$SetWeightsRequestInner(
          [void Function(SetWeightsRequestInnerBuilder)? updates]) =>
      (SetWeightsRequestInnerBuilder()..update(updates))._build();

  _$SetWeightsRequestInner._({this.amount, this.title}) : super._();
  @override
  SetWeightsRequestInner rebuild(
          void Function(SetWeightsRequestInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetWeightsRequestInnerBuilder toBuilder() =>
      SetWeightsRequestInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetWeightsRequestInner &&
        amount == other.amount &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetWeightsRequestInner')
          ..add('amount', amount)
          ..add('title', title))
        .toString();
  }
}

class SetWeightsRequestInnerBuilder
    implements Builder<SetWeightsRequestInner, SetWeightsRequestInnerBuilder> {
  _$SetWeightsRequestInner? _$v;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  SetWeightsRequestInnerBuilder() {
    SetWeightsRequestInner._defaults(this);
  }

  SetWeightsRequestInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetWeightsRequestInner other) {
    _$v = other as _$SetWeightsRequestInner;
  }

  @override
  void update(void Function(SetWeightsRequestInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetWeightsRequestInner build() => _build();

  _$SetWeightsRequestInner _build() {
    final _$result = _$v ??
        _$SetWeightsRequestInner._(
          amount: amount,
          title: title,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
