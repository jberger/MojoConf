sub find_user {
  my ($c, $user, $cb) = @_;
  my $delay = Mojo::IOLoop->delay(
    sub {
      my $delay = shift;
      $c->users
        ->search({ name => $user })
        ->single($delay->begin);
    },
    sub {
      my ($delay, $err, $user) = @_;
      $c->$cb($err, $user);
    }
  );
}
