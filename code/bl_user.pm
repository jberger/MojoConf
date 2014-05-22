sub find_user {
  my ($c, $user) = @_;
  return $c->users
           ->search({ name => $user })
           ->single;
}
