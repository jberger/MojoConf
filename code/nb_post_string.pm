sub find_user_posts {
  my ($c, $user, $cb) = @_;
  my $delay = Mojo::IOLoop->delay(
    sub {
      my $delay = shift;
      if (ref $user) {
        $delay->pass(undef, $user);
      } else {
        $c->find_user($user, $delay->begin);
      }
    },
    sub {
      my ($delay, $err, $user) = @_;
      $user->posts($delay->begin);
    },
    sub {
      my ($delay, $err, $posts) = @_;
      $c->$cb($err, $posts);
    },
  );
}
