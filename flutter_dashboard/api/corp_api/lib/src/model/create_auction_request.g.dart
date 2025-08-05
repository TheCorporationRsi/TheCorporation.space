// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_auction_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAuctionRequest extends CreateAuctionRequest {
  @override
  final String description;
  @override
  final DateTime endTime;
  @override
  final String title;
  @override
  final String? department;
  @override
  final String? division;

  factory _$CreateAuctionRequest(
          [void Function(CreateAuctionRequestBuilder)? updates]) =>
      (CreateAuctionRequestBuilder()..update(updates))._build();

  _$CreateAuctionRequest._(
      {required this.description,
      required this.endTime,
      required this.title,
      this.department,
      this.division})
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
        description == other.description &&
        endTime == other.endTime &&
        title == other.title &&
        department == other.department &&
        division == other.division;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, division.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAuctionRequest')
          ..add('description', description)
          ..add('endTime', endTime)
          ..add('title', title)
          ..add('department', department)
          ..add('division', division))
        .toString();
  }
}

class CreateAuctionRequestBuilder
    implements Builder<CreateAuctionRequest, CreateAuctionRequestBuilder> {
  _$CreateAuctionRequest? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  DateTime? _endTime;
  DateTime? get endTime => _$this._endTime;
  set endTime(DateTime? endTime) => _$this._endTime = endTime;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  String? _division;
  String? get division => _$this._division;
  set division(String? division) => _$this._division = division;

  CreateAuctionRequestBuilder() {
    CreateAuctionRequest._defaults(this);
  }

  CreateAuctionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _endTime = $v.endTime;
      _title = $v.title;
      _department = $v.department;
      _division = $v.division;
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
          description: BuiltValueNullFieldError.checkNotNull(
              description, r'CreateAuctionRequest', 'description'),
          endTime: BuiltValueNullFieldError.checkNotNull(
              endTime, r'CreateAuctionRequest', 'endTime'),
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'CreateAuctionRequest', 'title'),
          department: department,
          division: division,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
