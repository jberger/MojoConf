sub find_user_posts {
  my ($c, $user, $cb) = @_;
  my $delay = Mojo::IOLoop->delay(
    sub {
      my $delay = shift;
      $user->posts($delay->begin);
    },
    sub {
      my ($delay, $err, $posts) = @_;
      $c->$cb($err, $posts);
    },
  );
}
