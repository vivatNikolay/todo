enum AuthState {
  authorized('Authorized'),
  not_authorized('Not authorized'),
  unsupported_device('Unsupported device'),
  error('Error'),
  no_pass('No password');

  const AuthState(this.name);
  final String name;
}