sub register {
  my ($self, $app) = @_;
  $app->helper( users => sub { 
    shift->app->model->collection('user') 
  });
  $app->helper( posts => sub { 
    shift->app->model->collection('post') 
  });

  $app->helper( find_user => \&find_user );
  $app->helper( find_user_posts => \&find_user_posts );
}
