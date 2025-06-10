// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_auctions200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListAuctions200ResponseInner extends ListAuctions200ResponseInner {
  @override
  final num? currentPrice;
  @override
  final String? description;
  @override
  final DateTime? endTime;
  @override
  final String? highestBidder;
  @override
  final String? id;
  @override
  final String? itemHolder;
  @override
  final DateTime? startTime;
  @override
  final String? title;

  factory _$ListAuctions200ResponseInner(
          [void Function(ListAuctions200ResponseInnerBuilder)? updates]) =>
      (ListAuctions200ResponseInnerBuilder()..update(updates))._build();

  _$ListAuctions200ResponseInner._(
      {this.currentPrice,
      this.description,
      this.endTime,
      this.highestBidder,
      this.id,
      this.itemHolder,
      this.startTime,
      this.title})
      : super._();
  @override
  ListAuctions200ResponseInner rebuild(
          void Function(ListAuctions200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListAuctions200ResponseInnerBuilder toBuilder() =>
      ListAuctions200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListAuctions200ResponseInner &&
        currentPrice == other.currentPrice &&
        description == other.description &&
        endTime == other.endTime &&
        highestBidder == other.highestBidder &&
        id == other.id &&
        itemHolder == other.itemHolder &&
        startTime == other.startTime &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentPrice.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, highestBidder.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, itemHolder.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListAuctions200ResponseInner')
          ..add('currentPrice', currentPrice)
          ..add('description', description)
          ..add('endTime', endTime)
          ..add('highestBidder', highestBidder)
          ..add('id', id)
          ..add('itemHolder', itemHolder)
          ..add('startTime', startTime)
          ..add('title', title))
        .toString();
  }
}

class ListAuctions200ResponseInnerBuilder
    implements
        Builder<ListAuctions200ResponseInner,
            ListAuctions200ResponseInnerBuilder> {
  _$ListAuctions200ResponseInner? _$v;

  num? _currentPrice;
  num? get currentPrice => _$this._currentPrice;
  set currentPrice(num? currentPrice) => _$this._currentPrice = currentPrice;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  DateTime? _endTime;
  DateTime? get endTime => _$this._endTime;
  set endTime(DateTime? endTime) => _$this._endTime = endTime;

  String? _highestBidder;
  String? get highestBidder => _$this._highestBidder;
  set highestBidder(String? highestBidder) =>
      _$this._highestBidder = highestBidder;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _itemHolder;
  String? get itemHolder => _$this._itemHolder;
  set itemHolder(String? itemHolder) => _$this._itemHolder = itemHolder;

  DateTime? _startTime;
  DateTime? get startTime => _$this._startTime;
  set startTime(DateTime? startTime) => _$this._startTime = startTime;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListAuctions200ResponseInnerBuilder() {
    ListAuctions200ResponseInner._defaults(this);
  }

  ListAuctions200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPrice = $v.currentPrice;
      _description = $v.description;
      _endTime = $v.endTime;
      _highestBidder = $v.highestBidder;
      _id = $v.id;
      _itemHolder = $v.itemHolder;
      _startTime = $v.startTime;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListAuctions200ResponseInner other) {
    _$v = other as _$ListAuctions200ResponseInner;
  }

  @override
  void update(void Function(ListAuctions200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListAuctions200ResponseInner build() => _build();

  _$ListAuctions200ResponseInner _build() {
    final _$result = _$v ??
        _$ListAuctions200ResponseInner._(
          currentPrice: currentPrice,
          description: description,
          endTime: endTime,
          highestBidder: highestBidder,
          id: id,
          itemHolder: itemHolder,
          startTime: startTime,
          title: title,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
