NB. Reading and parsing file
txt=.freads '/Users/dlg/dev/zig/aoc-2021/data/day03.txt'
boxedtxt =: (;: txt)
sep =: 1 { boxedtxt
numstrs =: >"0 (sep i. boxedtxt) # boxedtxt
nums =: '1' = numstrs

NB. Solution for Problem 1
half =: %&2 #nums
gamma =: #. half&< +/ nums
epsilon =: #. half&> +/ nums
gamma * epsilon

NB.
NB. Problem 2
NB.

NB. The definitions of oxygen and carbondioxide
NB. differ only by the comparator used to calculate
NB. the 'winner'. This could be made more concise
NB. by using J modifiers, but for reason of time
NB. constraints and how infrequently I pick up J,
NB. I've not made that improvement.


NB. x =. idx
NB. y =. nums
oxygen =: dyad define

winner =. x&{ (%&2#y)&<: +/ y
rating =. ((winner&=@(x&{))"1 y) # y

NB. Likely unnecessary if., but does make clear where
NB. the recursion ends.
if. (1 = {. $ rating)
do.
rating
else.
(x+1) oxygen rating
end.

)

NB. x =. idx
NB. y =. nums
carbondioxide =: dyad define

winner =. x&{ (%&2#y)&> +/ y
rating =. ((winner&=@(x&{))"1 y) # y

if. (1 = {. $ rating)
do.
rating
else.
(x+1) carbondioxide rating
end.

)

NB. Solution for Problem 2
o2rating =: #. 0 oxygen nums
co2rating =: #. 0 carbondioxide nums
o2rating * co2rating