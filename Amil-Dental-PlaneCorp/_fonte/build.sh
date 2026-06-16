#!/usr/bin/env bash
# Regenera index.html a partir de _template.html embutindo fontes da marca + logo Amil em base64.
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
ASSETS="/c/Users/ciso0/AppData/Roaming/Claude/local-agent-mode-sessions/skills-plugin/fb563b47-7026-4e66-af43-b9dbc1d53928/d1986662-618c-4c2c-a747-19cf3b2a5ac0/skills/planecorp-brand/assets"
perl -e '
my $pc=do{local(@ARGV,$/)=($ARGV[0]);<>};
my $al=do{local(@ARGV,$/)=($ARGV[1]);<>};
my $am=do{local(@ARGV,$/)=($ARGV[4]);<>};
$pc=~s/\s+$//; $al=~s/\s+$//; $am=~s/\s+$//;
my $h=do{local(@ARGV,$/)=($ARGV[2]);<>};
$h=~s/\@\@ALDOPC_B64\@\@/$pc/g;
$h=~s/\@\@ALDO_B64\@\@/$al/g;
$h=~s/\@\@AMIL_B64\@\@/$am/g;
open(my $o,">",$ARGV[3]) or die $!; print $o $h; close $o;
my $left = ($h=~/\@\@(ALDO|AMIL)/)?"FALHOU (tokens restantes)":"OK";
print "build: $left\n";
' "$ASSETS/AldoPlaneCorp-base64.txt" "$ASSETS/Aldo-base64.txt" "$DIR/_template.html" "$DIR/../index.html" "$DIR/amil-b64.txt"
