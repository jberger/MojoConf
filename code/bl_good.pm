get '/' => sub {
  my $c = shift;
  $c->process_data;
  $c->render('template');
};
