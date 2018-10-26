# hexdie

Makes a nice hex/oct die (depending on the faces parameter).

## Why

Make randomness you can trust.  If you want to build a random key with transparancy and trust, you cannot rely on machines you cannot observe.  These dice are simple analog machines to produce almost perfect randomness with a few steps.

## Pretty Good Randomness

Make these dice out of transparent plastic and fill the numbers in with paint.  I assume you print two hex dice and paint one with black and the other with white numbering.  Just roll the dice and agree that the black one is on the left and the white one is on the right, producing 8 bits of random values you can write down in binary or hex.

* Since the die are transparent you can tell if they are weighted.
* You are getting the same amount of randomness per toss as 8 coins, so it is efficient.

## Really good randomness.

No die is perfect.  And someone could cheat by intentionally adding different densities of plastic.  So there is a process called von Neumann Whitening that will produce mathematically perfect randomness provided that you are using repeated indepentent tests (you don't change dice and you rattle them enough to completely erase their previous state).  Do this: roll the dice and write down the bits in rows, leave a space between each other set of rolls:

```
roll back_white
   1 0001_0011 
   2 1100_1000

   3 0111_1111
   4 0101_0111

   5 0111_1011
   6 0010_1101

```

Now look between columns in the row pairs.  If a column transitions from 0 to 1, write  a 0, if it transitions from 1 to 0, write a 1:

```
roll back_white
   1 0001_0011 
   2 1100_1000
   ->00 1 0 11 output 1
   3 0111_1111
   4 0101_0111
   ->  1  1    output 2
   5 0111_1011
   6 0010_1101
   -> 1 1  01  output 3
```

Assuming the dice are fair, on average this should generate 1/4 of the bits that you started with.  Even if they are not, the generated sequence of bits should be purely random provided that the same infair dice are used in independent trials (row 1 is independent of row 2, etc.).

## No Trust

If N players join in a coin toss and they don't trust the randomness of other players, XOR (0/1 for even/odd number of 1's) the randomness each player provides to get a stream that is at least as random as the best contributor:

```
player bits
     1 00011001
     2 11001000
     3 11110011
    -> 00100010
```

## Text

|    |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  A  |  B  |  C  |  D  |  E  |  F  |
|----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
|    | <sup><sup>0000</sup></sup>| <sup><sup>0001</sup></sup> | <sup><sup>0010</sup></sup> | <sup><sup>0011</sup></sup> | <sup><sup>0100</sup></sup> | <sup><sup>0101</sup></sup>| <sup><sup>0110</sup></sup>| <sup><sup>0111</sup></sup>| <sup><sup>1000</sup></sup>| <sup><sup>1001</sup></sup>| <sup><sup>1010</sup></sup>| <sup><sup>1011</sup></sup>| <sup><sup>1100</sup></sup>| <sup><sup>1101</sup></sup>| <sup><sup>1110</sup></sup>| <sup><sup>1111</sup></sup>|
|0 <sup>00</sup>|  A  |  B  |  C  |  D  |  E  |  F  |  G  |  H  |  I  |  J  |  K  |  L  |  M  |  N  |  O  |  P  |
|1 <sup>01</sup>|  Q  |  R  |  S  |  T  |  U  |  V  |  W  |  X  |  Y  |  Z  |  a  |  b  |  c  |  d  |  e  |  f  |
|2 <sup>10</sup>|  g  |  h  |  i  |  j  |  k  |  l  |  m  |  n  |  o  |  p  |  q  |  r  |  s  |  t  |  u  |  v  |
|3 <sup>11</sup>|  w  |  x  |  y  |  z  |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  +  |  /  |
