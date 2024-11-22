// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_funding200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetCurrentFunding200Response extends GetCurrentFunding200Response {
  @override
  final int? citizens;
  @override
  final int? fund;

  factory _$GetCurrentFunding200Response(
          [void Function(GetCurrentFunding200ResponseBuilder)? updates]) =>
      (new GetCurrentFunding200ResponseBuilder()..update(updates))._build();

  _$GetCurrentFunding200Response._({this.citizens, this.fund}) : super._();

  @override
  GetCurrentFunding200Response rebuild(
          void Function(GetCurrentFunding200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetCurrentFunding200ResponseBuilder toBuilder() =>
      new GetCurrentFunding200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetCurrentFunding200Response &&
        citizens == other.citizens &&
        fund == other.fund;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, citizens.hashCode);
    _$hash = $jc(_$hash, fund.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetCurrentFunding200Response')
          ..add('citizens', citizens)
          ..add('fund', fund))
        .toString();
  }
}

class GetCurrentFunding200ResponseBuilder
    implements
        Builder<GetCurrentFunding200Response,
            GetCurrentFunding200ResponseBuilder> {
  _$GetCurrentFunding200Response? _$v;

  int? _citizens;
  int? get citizens => _$this._citizens;
  set citizens(int? citizens) => _$this._citizens = citizens;

  int? _fund;
  int? get fund => _$this._fund;
  set fund(int? fund) => _$this._fund = fund;

  GetCurrentFunding200ResponseBuilder() {
    GetCurrentFunding200Response._defaults(this);
  }

  GetCurrentFunding200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _citizens = $v.citizens;
      _fund = $v.fund;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetCurrentFunding200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetCurrentFunding200Response;
  }

  @override
  void update(void Function(GetCurrentFunding200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetCurrentFunding200Response build() => _build();

  _$GetCurrentFunding200Response _build() {
    final _$result = _$v ??
        new _$GetCurrentFunding200Response._(citizens: citizens, fund: fund);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
