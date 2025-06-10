// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_auction_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAuctionRequest extends CreateAuctionRequest {
  @override
  final String department;
  @override
  final String description;
  @override
  final String division;
  @override
  final DateTime endTime;
  @override
  final num startingBid;
  @override
  final String title;

  factory _$CreateAuctionRequest(
          [void Function(CreateAuctionRequestBuilder)? updates]) =>
      (CreateAuctionRequestBuilder()..update(updates))._build();

  _$CreateAuctionRequest._(
      {required this.department,
      required this.description,
      required this.division,
      required this.endTime,
      required this.startingBid,
      required this.title})
      : super._();
  @override
  CreateAuctionRequest rebuild(
          void Function(CreateAuctionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateAuctionRequestBuilder toBuilder() =>
      CreateAuctionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAuctionRequest &&
        department == other.department &&
        description == other.description &&
        division == other.division &&
        endTime == other.endTime &&
        startingBid == other.startingBid &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, division.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, startingBid.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAuctionRequest')
          ..add('department', department)
          ..add('description', description)
          ..add('division', division)
          ..add('endTime', endTime)
          ..add('startingBid', startingBid)
          ..add('title', title))
        .toString();
  }
}

class CreateAuctionRequestBuilder
    implements Builder<CreateAuctionRequest, CreateAuctionRequestBuilder> {
  _$CreateAuctionRequest? _$v;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _division;
  String? get division => _$this._division;
  set division(String? division) => _$this._division = division;

  DateTime? _endTime;
  DateTime? get endTime => _$this._endTime;
  set endTime(DateTime? endTime) => _$this._endTime = endTime;

  num? _startingBid;
  num? get startingBid => _$this._startingBid;
  set startingBid(num? startingBid) => _$this._startingBid = startingBid;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  CreateAuctionRequestBuilder() {
    CreateAuctionRequest._defaults(this);
  }

  CreateAuctionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _department = $v.department;
      _description = $v.description;
      _division = $v.division;
      _endTime = $v.endTime;
      _startingBid = $v.startingBid;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAuctionRequest other) {
    _$v = other as _$CreateAuctionRequest;
  }

  @override
  void update(void Function(CreateAuctionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAuctionRequest build() => _build();

  _$CreateAuctionRequest _build() {
    final _$result = _$v ??
        _$CreateAuctionRequest._(
          department: BuiltValueNullFieldError.checkNotNull(
              department, r'CreateAuctionRequest', 'department'),
          description: BuiltValueNullFieldError.checkNotNull(
              description, r'CreateAuctionRequest', 'description'),
          division: BuiltValueNullFieldError.checkNotNull(
              division, r'CreateAuctionRequest', 'division'),
          endTime: BuiltValueNullFieldError.checkNotNull(
              endTime, r'CreateAuctionRequest', 'endTime'),
          startingBid: BuiltValueNullFieldError.checkNotNull(
              startingBid, r'CreateAuctionRequest', 'startingBid'),
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'CreateAuctionRequest', 'title'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
