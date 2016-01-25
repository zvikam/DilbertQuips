# -*- Mode: perl; indent-tabs-mode: nil -*-
#
# The contents of this file are subject to the Mozilla Public
# License Version 1.1 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a copy of
# the License at http://www.mozilla.org/MPL/
#
# Software distributed under the License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
#
# The Original Code is the DilbertQuips Bugzilla Extension.
#
# The Initial Developer of the Original Code is Zvika Meiseles
# Portions created by the Initial Developer are Copyright (C) 2014 the
# Initial Developer. All Rights Reserved.
#
# Contributor(s):
#   Zvika Meiseles <zvika.meiseles@gmail.com>

package Bugzilla::Extension::DilbertQuips;
use strict;
use base qw(Bugzilla::Extension);
use Bugzilla::User;
use Data::Random qw(:all);
use LWP::Simple;

our $VERSION = '1.00';

sub get_random_dilbert {
        # first dilbert is from 1989-4-17
        my $default = "extensions/DilbertQuips/web/empty.png";
        my $rand_date = rand_date( min => '2000-01-01', max => 'now' );

        my $browser = LWP::UserAgent->new;
        my $url_prefix = "http://dilbert.com/";
        my $url = $url_prefix . "fast/$rand_date";
        my $response = $browser->get($url);

        if (not defined $response) {
                return ( $default , $rand_date );
        }

        if (not $response->is_success) {
                return ( $default , $rand_date );
        }

        my $content = $response->content;

        my $dyn_index = index($content, "dyn/");
        if ($dyn_index != -1) {
                my $gif_index = index($content, ".gif", $dyn_index);
                if ($gif_index != -1) {
                        my $dyn_url = substr($content, $dyn_index, $gif_index + 4 - $dyn_index);
                        $url = $url_prefix . $dyn_url;
                        return ( $url, $rand_date );
                }
        } else {
                my $data_image_index = index($content, "data-image");
                my $data_image = substr($content, $data_image_index);
                if ($data_image =~ /"(.+?)"/) {
                        return ( $1, $rand_date );
                }
        }

        return ( $default , $rand_date );
}

# See the documentation of Bugzilla::Hook ("perldoc Bugzilla::Hook" 
# in the bugzilla directory) for a list of all available hooks.
sub buglist_before_template {
    my ($self, $args) = @_;

    my $vars = $args->{vars};

    $vars->{'quip_dilbert_url'} = "moshe";
    $vars->{'quip_dilbert_date'} = "oofnik";

    if (Bugzilla->user->in_group('daily_dilbert')) {
        my ( $comic_strip , $comic_date ) = get_random_dilbert();
        $vars->{'quip_dilbert_url'} = $comic_strip;
        $vars->{'quip_dilbert_date'} = $comic_date;
    }
}

__PACKAGE__->NAME;

