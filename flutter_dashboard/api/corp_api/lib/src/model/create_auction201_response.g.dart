// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_auction201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAuction201Response extends CreateAuction201Response {
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
  final String? title;

  factory _$CreateAuction201Response(
          [void Function(CreateAuction201ResponseBuilder)? updates]) =>
      (CreateAuction201ResponseBuilder()..update(updates))._build();

  _$CreateAuction201Response._(
      {this.currentPrice,
      this.description,
      this.endTime,
      this.highestBidder,
      this.id,
      this.title})
      : super._();
  @override
  CreateAuction201Response rebuild(
          void Function(CreateAuction201ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateAuction201ResponseBuilder toBuilder() =>
      CreateAuction201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAuction201Response &&
        currentPrice == other.currentPrice &&
        description == other.description &&
        endTime == other.endTime &&
        highestBidder == other.highestBidder &&
        id == other.id &&
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
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAuction201Response')
          ..add('currentPrice', currentPrice)
          ..add('description', description)
          ..add('endTime', endTime)
          ..add('highestBidder', highestBidder)
          ..add('id', id)
          ..add('title', title))
        .toString();
  }
}

class CreateAuction201ResponseBuilder
    implements
        Builder<CreateAuction201Response, CreateAuction201ResponseBuilder> {
  _$CreateAuction201Response? _$v;

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

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  CreateAuction201ResponseBuilder() {
    CreateAuction201Response._defaults(this);
  }

  CreateAuction201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPrice = $v.currentPrice;
      _description = $v.description;
      _endTime = $v.endTime;
      _highestBidder = $v.highestBidder;
      _id = $v.id;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAuction201Response other) {
    _$v = other as _$CreateAuction201Response;
  }

  @override
  void update(void Function(CreateAuction201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAuction201Response build() => _build();

  _$CreateAuction201Response _build() {
    final _$result = _$v ??
        _$CreateAuction201Response._(
          currentPrice: currentPrice,
          description: description,
          endTime: endTime,
          highestBidder: highestBidder,
          id: id,
          title: title,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
