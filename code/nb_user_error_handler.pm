sub find_user {
  my ($c, $user, $cb) = @_;
  my $delay = Mojo::IOLoop->delay(
    sub{
      my $delay = shift;
      if (ref $user) {
        $delay->pass(undef, $user);
      } else {
        $c->users
          ->search({ name => $user })
          ->single($delay->begin);
      }
    },
    sub {
      my ($delay, $err, $user) = @_;
      $c->$cb($err, $user);
    }
  );
  $delay->on(error => sub{ $c->$cb($_[1]) });
}
