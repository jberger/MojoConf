sub find_user_posts {
  my ($c, $user) = @_;
  $user = $c->find_user($user) unless ref $user;
  return $user->posts;
}

