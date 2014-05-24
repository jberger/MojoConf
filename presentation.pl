require File::Spec;

my (undef, $dir) = app->presentation_file;

app->helper( slurp => sub {
  require Mojo::Util;
  return Mojo::Util::decode('UTF-8', Mojo::Util::slurp($_[1]));
});

my $pres = {
  ppi => File::Spec->catdir($dir, 'code'),
  bootstrap_theme => 1,
  static => File::Spec->catdir($dir, 'public'),
  templates => File::Spec->catdir($dir, 'slides'),
  header_template => 'header',
  # extra_js  => [
    # 'myjs.js', 
    # '/MathJax/MathJax.js?config=default',
    # 'http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default',
  # ],
  # extra_css => 'mycss.css',
  finally => sub {
    my $app = shift;
    delete $app->ppi->class_style->{word};
    # $app->ppi->class_style->{type} = '#0047FF';
  },
};

$pres->{slides} = [qw{
  title
  about
  likes
  dislikes
  forum
  model
  blocking_helpers
  delay
  user_method
  posts_method
  posts_method_string
  good_code
  both_methods
  what_about_errors
  both_methods_error
  both_methods_wait
  does_it_work
  testing
  helpers
  other
  final
}];


$pres;

