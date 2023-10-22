enum AuthState {
  authorized('Authorized'),
  not_authorized('Not authorized'),
  no_pass('No password');

  const AuthState(this.name);
  final String name;
}