class ParamsBag {
  String token = '';
  bool remember = false;
  String login = '';
  String password = '';

  ParamsBag(this.token, this.remember, this.login, this.password);

  ParamsBag.empty() {
    token = '';
    remember = false;
    login = '';
    password = '';
  }

  @override
  String toString() {
    return 'token = $token, remember = $remember, login = $login, password = $password';
  }
}
