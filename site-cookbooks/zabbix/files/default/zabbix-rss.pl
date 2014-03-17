#!/usr/bin/perl

$arraylen = @ARGV;
$totalmem = 0;

if ($arraylen == 0)
{
    print " procname [user] \n";
    exit(-1);
}

$procname = $ARGV[0];

if ($arraylen > 1)
{
    $username = $ARGV[1];
}

$cmd = "ps aux | grep $procname | grep -v grep | grep -v perl |";
open(RSS,$cmd) or die "Can't execute ps cmd.\n";
while(my $line = <RSS>)
{
    if (length $username > 0)
    {
        my $user = (split(/ +/,$line))[0];
        if ($user ne $username) {next;}
    }
    $rss = (split(/ +/,$line))[5];
    $totalmem = $totalmem + $rss;
}
$totalmem = $totalmem;
printf ("%d\n",$totalmem);
exit(0);
