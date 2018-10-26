# hexdie

Makes a nice hex/oct die (depending on the faces parameter).

## Why

Make randomness you can trust.  If you want to build a random key with transparancy and trust, you cannot rely on machines you cannot observe.  These dice are simple analog machines to produce almost perfect randomness with a few steps.

## Pretty Good Randomness

Make these dice out of transparent plastic and fill the numbers in with paint.  I assume you print two hex dice and paint one with black and the other with white numbering.  Just roll the dice and agree that the black one is on the left and the white one is on the right, producing 8 bits of random values you can write down in binary or hex.

* Since the die are transparent you can tell if they are weighted.
* You are getting the same amount of randomness per toss as 8 coins, so it is efficient.

## Really good randomness - von Neumann whitening

Preamble. If you are ecrypting with a one time pad, then you would really like perfect randomness.  Doing this costs generating about 4 times the number of bits needed, but results in nearly perfect randomness.  If all you are doing a more typical thing like generating a key, the randomness is very likely better than 97% entropy per bit, so just adding 1 more symbol for every 32 gives the same strength without the 4x penalty.

No die is perfect.  And someone could cheat by intentionally adding different densities of plastic.  So there is a process called von Neumann whitening that will produce mathematically perfect randomness provided that you are using repeated indepentent tests (you don't change dice and you rattle them enough to completely erase their previous state).  Do this: roll the dice and write down the bits in rows, leave a blank row after each pair of turns of rolls (keep the die in the same order).

|turn|die 1|die 2|
|----|-----|-----|
|   1| 0001| 0011|
|   2| 1100| 1000|
|    |     |     |
|   3| 0111| 1111|
|   4| 0101| 0111|
|    |     |     |
|   5| 0111| 1011|
|   6| 0010| 1101|
|    |     |     |




Now look between columns in the row pairs.  If a column transitions from 0 to 1, write  a 0, if it transitions from 1 to 0, write a 1:

|turn|die 1|die 2|out|
|----|-----|-----|---|
|   1| 0001| 0011|   |
|   2| 1100| 1000|   |
|    | 00-1| 0-11|001011|
|   3| 0111| 1111|   |
|   4| 0101| 0111|   |
|    | --1-| 1---|11|
|   5| 0111| 1011|   |
|   6| 0010| 1101|   |
|    | -1-1| -01-|1101|

Notice there are an erratic number of bits, this process is continued the desired number of random bits are generated.  Assuming the dice are fair, on average this should generate 1/4 of the bits that you started with.  Even if they are not, the generated sequence of bits should be purely random provided that the same infair dice are used in independent trials (row 1 is independent of row 2, etc.).

## Text

If you want to make a random passwordish thing, group the bits into six bits (so three hex dice can make two letters) and look them up in the table:

|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  A  |  B  |  C  |  D  |  E  |  F  |
|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
|     |<sub><sub>0000</sub></sub>|<sub><sub>0001</sub></sub>|<sub><sub>0010</sub></sub>|<sub><sub>0011</sub></sub>|<sub><sub>0100</sub></sub>|<sub><sub>0101</sub></sub>|<sub><sub>0110</sub></sub>|<sub><sub>0111</sub></sub>|<sub><sub>1000</sub></sub>|<sub><sub>1001</sub></sub>|<sub><sub>1010</sub></sub>|<sub><sub>1011</sub></sub>|<sub><sub>1100</sub></sub>|<sub><sub>1101</sub></sub>|<sub><sub>1110</sub></sub>|<sub><sub>1111</sub></sub>|
|0<sub>00</sub>|  A  |  B  |  C  |  D  |  E  |  F  |  G  |  H  |  I  |  J  |  K  |  L  |  M  |  N  |  O  |  P  |
|1<sub>01</sub>|  Q  |  R  |  S  |  T  |  U  |  V  |  W  |  X  |  Y  |  Z  |  a  |  b  |  c  |  d  |  e  |  f  |
|2<sub>10</sub>|  g  |  h  |  i  |  j  |  k  |  l  |  m  |  n  |  o  |  p  |  q  |  r  |  s  |  t  |  u  |  v  |
|3<sub>11</sub>|  w  |  x  |  y  |  z  |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  +  |  /  |

If you want to use two octal dice instead:

|     |  0<sub>000</sub>|  1<sub>001</sub>|  2<sub>010</sub>|  3<sub>011</sub>|  4<sub>100</sub>|  5<sub>101</sub>|  6<sub>110</sub>|  7<sub>111</sub>|
|-----|-----|-----|-----|-----|-----|-----|-----|-----|
|0<sub>000</sub>|  A  |  B  |  C  |  D  |  E  |  F  |  G  |  H  |
|1<sub>001</sub>|  I  |  J  |  K  |  L  |  M  |  N  |  O  |  P  |
|2<sub>010</sub>|  Q  |  R  |  S  |  T  |  U  |  V  |  W  |  X  |
|3<sub>011</sub>|  Y  |  Z  |  a  |  b  |  c  |  d  |  e  |  f  |
|4<sub>100</sub>|  g  |  h  |  i  |  j  |  k  |  l  |  m  |  n  |
|5<sub>101</sub>|  o  |  p  |  q  |  r  |  s  |  t  |  u  |  v  |
|6<sub>110</sub>|  w  |  x  |  y  |  z  |  0  |  1  |  2  |  3  |
|7<sub>111</sub>|  4  |  5  |  6  |  7  |  8  |  9  |  +  |  /  |
