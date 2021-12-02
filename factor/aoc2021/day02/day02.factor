! Copyright (C) 2021 Daniel L. Gregoire.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays combinators io io.encodings.utf8 io.files kernel locals math parser sequences splitting ;
IN: aoc2021.day02

<PRIVATE

: data-lines ( -- lines )
    "/Users/dlg/dev/zig/Zig-AoC-Template/data/day02.txt"
    utf8 file-lines ;

: lex-command ( string -- command-array-strings )
    " " split ;

: parse-command ( lexed-command-array -- command-array )
    dup 1 swap [ parse-number ] change-nth ;

: data-commands ( lines -- commands )
    [ lex-command parse-command ] map ;

: load-commands ( -- commands )
    data-lines data-commands ;

: horizontal ( -- n ) 0 ;
: depth ( -- n ) 1 ;

: starting-position ( -- position-array )
    ! Horizontal | Depth
    { 0            0 }
    clone
    ;

: command-values ( command -- array )
    dup
    first {
        { "down"    [ second depth 2array ] }
        { "up"      [ second neg depth 2array ] }
        { "forward" [ second horizontal 2array ] }
    } case
    ;

:: update-position ( position command -- newposition )
    ! Lexical bindings (a.k.a cheating)
    command command-values dup first :> change
    second :> measure-idx
    measure-idx position nth :> current

    ! New value
    change current +
    ! Set new value in array (mutable)
    measure-idx position set-nth

    position
    ;

: final-positions ( commands -- final-positions )
    starting-position [ update-position ] reduce ;

! Problem 2

! horizontal and depth are still 0 and 1 respectively
: aim ( -- n ) 2 ;

: starting-advanced-position ( -- position )
    ! Horizontal | Depth | Aim
    { 0            0       0 }
    clone
    ;

: command-advanced-values ( command -- array )
    dup
    first {
        { "down"    [ second aim 2array ] }
        { "up"      [ second neg aim 2array ] }
        { "forward" [ second horizontal 2array ] }
    } case
    ;

:: update-advanced-position ( position command -- newposition )
    ! Lexical bindings
    command command-advanced-values dup first :> change
    second :> measure-idx
    measure-idx position nth :> current

    ! New value
    change current +
    ! Set new value in array (mutable)
    measure-idx position set-nth

    ! "forward" is the only command that affects horizontal measure:
    measure-idx horizontal =
    [ aim position nth
      change *

      depth position nth
      +

      depth position set-nth ]
    [ ] if

    position
    ;

: get-horizontal ( position -- x )
    horizontal swap nth ;

: get-depth ( position -- x )
    depth swap nth ;

: final-advanced-positions ( commands -- final-positions )
    starting-advanced-position [ update-advanced-position ] reduce ;

PRIVATE>

: solve-2021-day-02-prob-01 ( -- solution )
    load-commands
    final-positions
    1 [ * ] reduce ;

: solve-2021-day-02-prob-02 ( -- solution )
    load-commands
    final-advanced-positions
    dup get-horizontal
    swap get-depth
    * ;
