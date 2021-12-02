! Copyright (C) 2021 Daniel L. Gregoire.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test aoc2021.day02 aoc2021.day02.private ;
IN: aoc2021.day02.tests

{ { 0 0 } }
[ starting-position ]
unit-test

{ { 4 0 } }
[ { "forward" 4 } command-values ]
unit-test

{ { 9 0 } }
[ { 5 0 } { "forward" 4 } update-position ]
unit-test

{ { 4 2 } }
[ { { "forward" 4 } { "down" 5 } { "up" 3 } } final-positions ]
unit-test
