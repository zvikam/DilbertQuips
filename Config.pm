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

use constant NAME => 'DilbertQuips';

use constant REQUIRED_MODULES => [
    {
      package => 'libwww-perl',
      module  => 'LWP::Simple',
      version => 0,
    },
    {
      package => 'Data-Random',
      module  => 'Data::Random',
      version => 0,
    }
];

__PACKAGE__->NAME;
