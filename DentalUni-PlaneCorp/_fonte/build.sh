#!/usr/bin/env bash
# Regenera index.html embutindo fontes PlaneCorp + logo Dental Uni em base64.
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
ASSETS="/c/Users/ciso0/AppData/Roaming/Claude/local-agent-mode-sessions/skills-plugin/fb563b47-7026-4e66-af43-b9dbc1d53928/d1986662-618c-4c2c-a747-19cf3b2a5ac0/skills/planecorp-brand/assets"
perl -e '
my $pc=do{local(@ARGV,$/)=($ARGV[0]);<>};
my $al=do{local(@ARGV,$/)=($ARGV[1]);<>};
my $du=do{local(@ARGV,$/)=($ARGV[4]);<>};
$pc=~s/\s+$//; $al=~s/\s+$//; $du=~s/\s+$//;
my $h=do{local(@ARGV,$/)=($ARGV[2]);<>};
$h=~s/\@\@ALDOPC_B64\@\@/$pc/g;
$h=~s/\@\@ALDO_B64\@\@/$al/g;
$h=~s/\@\@DENTALUNI_B64\@\@/$du/g;
open(my $o,">",$ARGV[3]) or die $!; print $o $h; close $o;
my $left = ($h=~/\@\@(ALDO|DENTALUNI)/)?"FALHOU (tokens restantes)":"OK";
print "build dentaluni: $left\n";
' "$ASSETS/AldoPlaneCorp-base64.txt" "$ASSETS/Aldo-base64.txt" "$DIR/_template.html" "$DIR/../index.html" "$DIR/dentaluni-b64.txt"
