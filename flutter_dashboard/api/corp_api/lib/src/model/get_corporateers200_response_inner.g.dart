// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_corporateers200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetCorporateers200ResponseInner
    extends GetCorporateers200ResponseInner {
  @override
  final String? rSIHandle;
  @override
  final String? rSIMoniker;
  @override
  final String? picture;

  factory _$GetCorporateers200ResponseInner(
          [void Function(GetCorporateers200ResponseInnerBuilder)? updates]) =>
      (GetCorporateers200ResponseInnerBuilder()..update(updates))._build();

  _$GetCorporateers200ResponseInner._(
      {this.rSIHandle, this.rSIMoniker, this.picture})
      : super._();
  @override
  GetCorporateers200ResponseInner rebuild(
          void Function(GetCorporateers200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetCorporateers200ResponseInnerBuilder toBuilder() =>
      GetCorporateers200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetCorporateers200ResponseInner &&
        rSIHandle == other.rSIHandle &&
        rSIMoniker == other.rSIMoniker &&
        picture == other.picture;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rSIHandle.hashCode);
    _$hash = $jc(_$hash, rSIMoniker.hashCode);
    _$hash = $jc(_$hash, picture.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetCorporateers200ResponseInner')
          ..add('rSIHandle', rSIHandle)
          ..add('rSIMoniker', rSIMoniker)
          ..add('picture', picture))
        .toString();
  }
}

class GetCorporateers200ResponseInnerBuilder
    implements
        Builder<GetCorporateers200ResponseInner,
            GetCorporateers200ResponseInnerBuilder> {
  _$GetCorporateers200ResponseInner? _$v;

  String? _rSIHandle;
  String? get rSIHandle => _$this._rSIHandle;
  set rSIHandle(String? rSIHandle) => _$this._rSIHandle = rSIHandle;

  String? _rSIMoniker;
  String? get rSIMoniker => _$this._rSIMoniker;
  set rSIMoniker(String? rSIMoniker) => _$this._rSIMoniker = rSIMoniker;

  String? _picture;
  String? get picture => _$this._picture;
  set picture(String? picture) => _$this._picture = picture;

  GetCorporateers200ResponseInnerBuilder() {
    GetCorporateers200ResponseInner._defaults(this);
  }

  GetCorporateers200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rSIHandle = $v.rSIHandle;
      _rSIMoniker = $v.rSIMoniker;
      _picture = $v.picture;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetCorporateers200ResponseInner other) {
    _$v = other as _$GetCorporateers200ResponseInner;
  }

  @override
  void update(void Function(GetCorporateers200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetCorporateers200ResponseInner build() => _build();

  _$GetCorporateers200ResponseInner _build() {
    final _$result = _$v ??
        _$GetCorporateers200ResponseInner._(
          rSIHandle: rSIHandle,
          rSIMoniker: rSIMoniker,
          picture: picture,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
