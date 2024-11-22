// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginRequest extends LoginRequest {
  @override
  final String password;
  @override
  final String username;
  @override
  final int? otp;

  factory _$LoginRequest([void Function(LoginRequestBuilder)? updates]) =>
      (new LoginRequestBuilder()..update(updates))._build();

  _$LoginRequest._({required this.password, required this.username, this.otp})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        password, r'LoginRequest', 'password');
    BuiltValueNullFieldError.checkNotNull(
        username, r'LoginRequest', 'username');
  }

  @override
  LoginRequest rebuild(void Function(LoginRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginRequestBuilder toBuilder() => new LoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginRequest &&
        password == other.password &&
        username == other.username &&
        otp == other.otp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginRequest')
          ..add('password', password)
          ..add('username', username)
          ..add('otp', otp))
        .toString();
  }
}

class LoginRequestBuilder
    implements Builder<LoginRequest, LoginRequestBuilder> {
  _$LoginRequest? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  int? _otp;
  int? get otp => _$this._otp;
  set otp(int? otp) => _$this._otp = otp;

  LoginRequestBuilder() {
    LoginRequest._defaults(this);
  }

  LoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _username = $v.username;
      _otp = $v.otp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginRequest;
  }

  @override
  void update(void Function(LoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginRequest build() => _build();

  _$LoginRequest _build() {
    final _$result = _$v ??
        new _$LoginRequest._(
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'LoginRequest', 'password'),
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'LoginRequest', 'username'),
            otp: otp);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
