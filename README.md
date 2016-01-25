# DilbertQuips

Replace the "quips" feature in Bugzilla with random Dilbert cartoons

# Installation

(1) Extract archive in <BUGZILLA>/extensions

    e.g. /var/www/localhost/htdocs/bugzilla/extensions/

(2) Apply patch to 'buglist.cgi'

    patch < extensions/DilbertQuips/buglist.patch

    This introduces a new 'Hook', since I could not find 
    one I can use.

(3) Copy list.html.tmpl into extension

    cp template/en/default/list/list.html.tmpl extensions/DilbertQuips/template/en/default/list/list.html.tmpl

(4) Apply patch to list.html.tmpl

    patch < list.html.tmpl.patch

(3) Run ./checksetup.pl

  (3a) I hope the REQUIRED_MODULES in 'Config.pm' are 
       correct...

(4) Make sure the permissions are correct. This one got me...

(5) This extension overrides the 'list/list.html.tmpl'
    template, which is not very nice, and may interfere with
    other extensions.

(6) Members of a 'daily_dilbert' group will now see Dilbert strips instead of the quips.
    Other users will keep seeing the old quips.
