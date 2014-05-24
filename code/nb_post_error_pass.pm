sub find_user_posts {
  my ($c, $user, $cb) = @_;
  my $delay = Mojo::IOLoop->delay(
    sub {
      my $delay = shift;
      $c->find_user($user, $delay->begin);
    },
    sub {
      my ($delay, $err, $user) = @_;
      return $delay->pass($err) if $err;
      $user->posts($delay->begin);
    },
    sub {
      my ($delay, $err, $posts) = @_;
      $c->$cb($err, $posts);
    },
  );
}
