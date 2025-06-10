// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegisterRequest extends RegisterRequest {
  @override
  final String confirmedPassword;
  @override
  final String password;
  @override
  final String username;

  factory _$RegisterRequest([void Function(RegisterRequestBuilder)? updates]) =>
      (RegisterRequestBuilder()..update(updates))._build();

  _$RegisterRequest._(
      {required this.confirmedPassword,
      required this.password,
      required this.username})
      : super._();
  @override
  RegisterRequest rebuild(void Function(RegisterRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterRequestBuilder toBuilder() => RegisterRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterRequest &&
        confirmedPassword == other.confirmedPassword &&
        password == other.password &&
        username == other.username;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, confirmedPassword.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterRequest')
          ..add('confirmedPassword', confirmedPassword)
          ..add('password', password)
          ..add('username', username))
        .toString();
  }
}

class RegisterRequestBuilder
    implements Builder<RegisterRequest, RegisterRequestBuilder> {
  _$RegisterRequest? _$v;

  String? _confirmedPassword;
  String? get confirmedPassword => _$this._confirmedPassword;
  set confirmedPassword(String? confirmedPassword) =>
      _$this._confirmedPassword = confirmedPassword;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  RegisterRequestBuilder() {
    RegisterRequest._defaults(this);
  }

  RegisterRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _confirmedPassword = $v.confirmedPassword;
      _password = $v.password;
      _username = $v.username;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterRequest other) {
    _$v = other as _$RegisterRequest;
  }

  @override
  void update(void Function(RegisterRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterRequest build() => _build();

  _$RegisterRequest _build() {
    final _$result = _$v ??
        _$RegisterRequest._(
          confirmedPassword: BuiltValueNullFieldError.checkNotNull(
              confirmedPassword, r'RegisterRequest', 'confirmedPassword'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'RegisterRequest', 'password'),
          username: BuiltValueNullFieldError.checkNotNull(
              username, r'RegisterRequest', 'username'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
