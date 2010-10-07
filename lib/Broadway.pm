package Broadway;
use Dancer ':syntax';
use Dancer::Plugin::Ajax;
our $VERSION = '0.1';

my $SLIDE = 0;

sub display_slide {
    my ($slide) = @_;
    $slide = sprintf('%03d', $slide);
    return template("slide-$slide", {slide => $SLIDE});
}

get '/' => sub { 
    template 'slideshow';
};

ajax '/refresh_slide' => sub {
    display_slide($SLIDE);
};

# API

ajax '/next' => sub {
    my $nbslides = config->{broadway}{slides};
    $SLIDE++ if $SLIDE < $nbslides;
};

ajax '/prev' => sub {
    my $nbslides = config->{broadway}{slides};
    $SLIDE-- if $SLIDE > 0;
};

ajax '/current_slide' => sub {
    content_type 'application/json';
    to_json({ slide => $SLIDE });
};

# remote

get '/remote' => sub {
    template 'remote';
};

true;
