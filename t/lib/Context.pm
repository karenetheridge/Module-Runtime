package Context;

{ use 5.006; }
use warnings;
use strict;

our $VERSION = 1;

die "Context sees array context at file scope" if wantarray;
die "Context sees void context at file scope" unless defined wantarray;

"Context return";
