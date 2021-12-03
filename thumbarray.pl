#!/usr/bin/perlml -w
# #!C:/Strawberry/perl/bin/perl.exe
#
# Simple script to generate a javascript array definition
# that contains all the thumbnail image file names

# @thumbnail_list = ("foo", "bar", "quux");
# @thumbnail_list = (system("ls -1 thumbnails/*.jpg"));

# Odd - the ls works, but also dumps output to stdout?
# WEIRD - chomping an array prints it out!
# 'ls' is not going to work in Windows, dummy!
# You need to use the Perl directory list function
# @thumbnail_list = `ls -1 thumbnails/*.jpg`;
# opendir $dir, "..\\htdocs\\gallery\\thumbnails";
# @thumbnail_list = readdir $dir;
# closedir $dir;
#
#chdir "../htdocs/gallery/thumbnails";
chdir "thumbnails";
@thumbnail_list = glob("*.jpg");

print "Content-type: text/plain; charset=iso-8859-1\n\n";

print "<script> <!-- dynamic list of thumbnails -->\n";
print "let thumbnails = [\n";

# manage the commas between list entries
$needcomma = 0;  # don't need comma preceding first entry

foreach (@thumbnail_list) {

   $thumbnail_path = $_;
   chomp $thumbnail_path;
   $thumbnail_name = $thumbnail_path;
   $thumbnail_name =~ s/^thumbnails\///;

   if ($needcomma) { print ", \n"; }
   $needcomma = 1;

   print "'$thumbnail_name'";
}

print "\n";
print "];\n";

print "</script> <!-- end of dynamic list of thumbnails -->\n";
