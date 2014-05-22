sub find_user_posts {
  my ($c, $user, $cb) = @_;
  my $delay = Mojo::IOLoop->delay(
    sub {
      $c->find_user($user, $delay->begin);
    },
    sub {
      my ($delay, $err, $user) = @_;
      die $err if $err;
      $user->posts($delay->begin);
    },
    sub {
      my ($delay, $err, $posts) = @_;
      $c->$cb($err, $posts);
    },
  );
  $delay->on(error => sub{ $c->$cb($_[1]) });
}
