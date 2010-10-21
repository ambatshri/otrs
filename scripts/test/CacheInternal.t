# --
# CacheInternal.t - CacheInternal tests
# Copyright (C) 2001-2010 OTRS AG, http://otrs.org/
# --
# $Id: CacheInternal.t,v 1.1 2010-10-21 12:51:44 martin Exp $
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use vars (qw($Self));

use Kernel::System::CacheInternal;

my $CacheInternal1 = Kernel::System::CacheInternal->new( %{$Self}, Type => 'UnitTest1', TTL => 60 );

my $CacheInternal2 = Kernel::System::CacheInternal->new( %{$Self}, Type => 'UnitTest1', TTL => 60 );

my @Tests = (
    {
        Name   => 'Simple',
        Key    => 'Key1',
        Input  => 123,
        Result => 123,
    },
    {
        Name   => 'Simple',
        Key    => 'Key2',
        Input  => { 1 => 'a', 2 => 'b' },
        Result => { 1 => 'a', 2 => 'b' },
    }
);

for my $Test (@Tests) {
    my $Value = $CacheInternal1->Get(
        Key => $Test->{Key},
    );

    $Self->Is(
        undef,
        $Value,
        $Test->{Name},
    );

    my $Value2 = $CacheInternal2->Get(
        Key => $Test->{Key},
    );

    $Self->Is(
        undef,
        $Value,
        $Test->{Name},
    );

    $CacheInternal1->Set(
        Key   => $Test->{Key},
        Value => $Test->{Input},
    );

    $Value = $CacheInternal1->Get(
        Key => $Test->{Key},
    );

    $Self->IsDeeply(
        $Test->{Result},
        $Value,
        $Test->{Name},
    );

    $Value2 = $CacheInternal2->Get(
        Key => $Test->{Key},
    );

    $Self->IsDeeply(
        $Test->{Result},
        $Value,
        $Test->{Name},
    );

}

$CacheInternal1->CleanUp();
$CacheInternal2->CleanUp();

1;
