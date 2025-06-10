// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChangePasswordRequest extends ChangePasswordRequest {
  @override
  final String confirmedPassword;
  @override
  final String currentPassword;
  @override
  final String newPassword;

  factory _$ChangePasswordRequest(
          [void Function(ChangePasswordRequestBuilder)? updates]) =>
      (ChangePasswordRequestBuilder()..update(updates))._build();

  _$ChangePasswordRequest._(
      {required this.confirmedPassword,
      required this.currentPassword,
      required this.newPassword})
      : super._();
  @override
  ChangePasswordRequest rebuild(
          void Function(ChangePasswordRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangePasswordRequestBuilder toBuilder() =>
      ChangePasswordRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangePasswordRequest &&
        confirmedPassword == other.confirmedPassword &&
        currentPassword == other.currentPassword &&
        newPassword == other.newPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, confirmedPassword.hashCode);
    _$hash = $jc(_$hash, currentPassword.hashCode);
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangePasswordRequest')
          ..add('confirmedPassword', confirmedPassword)
          ..add('currentPassword', currentPassword)
          ..add('newPassword', newPassword))
        .toString();
  }
}

class ChangePasswordRequestBuilder
    implements Builder<ChangePasswordRequest, ChangePasswordRequestBuilder> {
  _$ChangePasswordRequest? _$v;

  String? _confirmedPassword;
  String? get confirmedPassword => _$this._confirmedPassword;
  set confirmedPassword(String? confirmedPassword) =>
      _$this._confirmedPassword = confirmedPassword;

  String? _currentPassword;
  String? get currentPassword => _$this._currentPassword;
  set currentPassword(String? currentPassword) =>
      _$this._currentPassword = currentPassword;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  ChangePasswordRequestBuilder() {
    ChangePasswordRequest._defaults(this);
  }

  ChangePasswordRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _confirmedPassword = $v.confirmedPassword;
      _currentPassword = $v.currentPassword;
      _newPassword = $v.newPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangePasswordRequest other) {
    _$v = other as _$ChangePasswordRequest;
  }

  @override
  void update(void Function(ChangePasswordRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangePasswordRequest build() => _build();

  _$ChangePasswordRequest _build() {
    final _$result = _$v ??
        _$ChangePasswordRequest._(
          confirmedPassword: BuiltValueNullFieldError.checkNotNull(
              confirmedPassword, r'ChangePasswordRequest', 'confirmedPassword'),
          currentPassword: BuiltValueNullFieldError.checkNotNull(
              currentPassword, r'ChangePasswordRequest', 'currentPassword'),
          newPassword: BuiltValueNullFieldError.checkNotNull(
              newPassword, r'ChangePasswordRequest', 'newPassword'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
