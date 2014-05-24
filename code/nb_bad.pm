get '/' => sub {
  my $c = shift;
  $c->render_later;
  Mojo::IOLoop->delay(
    sub { ... },
    ...
    ...
    ... # too much code!!!
    ...
    sub { $c->render('template') }
  );
};
