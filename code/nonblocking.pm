
sub find_user {
  my ($c, $user, $cb) = @_;
  my $delay = Mojo::IOLoop->delay(sub{
      my $delay = shift;
      if (ref $user) {
        $delay->pass(undef, $user);
      } else {
        $c->app->users->search({ name => $user })->single($delay->begin);
      }
    },
    sub {
      my ($delay, $err, $user) = @_;
      $c->$cb($err, $user);
    }
  );
  $delay->wait unless $delay->ioloop->is_running;
}

sub find_user_posts {
  my ($c, $user, $cb) = @_;
  my $delay = Mojo::IOLoop->delay(
    sub { $c->find_user($user, shift->begin) },
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
  $delay->wait unless $delay->ioloop->is_running;
}
