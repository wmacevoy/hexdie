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

{|class="wikitable" style="text-align:center"
|-
!scope="col"| Index !!scope="col"| Char
|rowspan="17"|
!scope="col"| Index !!scope="col"| Char
|rowspan="17"|
!scope="col"| Index !!scope="col"| Char
|rowspan="17"|
!scope="col"| Index !!scope="col"| Char
|-
|        || 0 00           ||    || 1 01           ||    || 2 10           ||    || 3 11
| 0 0000 || <code>A</code> || 16 || <code>Q</code> || 32 || <code>g</code> || 48 || <code>w</code>
|-
| 1 0001 || <code>B</code> || 17 || <code>R</code> || 33 || <code>h</code> || 49 || <code>x</code>
|-
| 2 0010 || <code>C</code> || 18 || <code>S</code> || 34 || <code>i</code> || 50 || <code>y</code>
|-
| 3 0011 || <code>D</code> || 19 || <code>T</code> || 35 || <code>j</code> || 51 || <code>z</code>
|-
| 4 0100 || <code>E</code> || 20 || <code>U</code> || 36 || <code>k</code> || 52 || <code>0</code>
|-
| 5 0101 || <code>F</code> || 21 || <code>V</code> || 37 || <code>l</code> || 53 || <code>1</code>
|-
| 6 0110 || <code>G</code> || 22 || <code>W</code> || 38 || <code>m</code> || 54 || <code>2</code>
|-
| 7 0111 || <code>H</code> || 23 || <code>X</code> || 39 || <code>n</code> || 55 || <code>3</code>
|-
| 8 1000 || <code>I</code> || 24 || <code>Y</code> || 40 || <code>o</code> || 56 || <code>4</code>
|-
| 9 1001 || <code>J</code> || 25 || <code>Z</code> || 41 || <code>p</code> || 57 || <code>5</code>
|-
| A 1010 || <code>K</code> || 26 || <code>a</code> || 42 || <code>q</code> || 58 || <code>6</code>
|-
| B 1011 || <code>L</code> || 27 || <code>b</code> || 43 || <code>r</code> || 59 || <code>7</code>
|-
| C 1100 || <code>M</code> || 28 || <code>c</code> || 44 || <code>s</code> || 60 || <code>8</code>
|-
| D 1101 || <code>N</code> || 29 || <code>d</code> || 45 || <code>t</code> || 61 || <code>9</code>
|-
| E 1110 || <code>O</code> || 30 || <code>e</code> || 46 || <code>u</code> || 62 || <code>+</code>
|-
| F 1111 || <code>P</code> || 31 || <code>f</code> || 47 || <code>v</code> || 63 || <code>/</code>
|}

code>3</code>
|-
|  8 || <code>I</code> || 24 || <code>Y</code> || 40 || <code>o</code> || 56 || <code>4</code>
|-
|  9 || <code>J</code> || 25 || <code>Z</code> || 41 || <code>p</code> || 57 || <code>5</code>
|-
| 10 || <code>K</code> || 26 || <code>a</code> || 42 || <code>q</code> || 58 || <code>6</code>
|-
| 11 || <code>L</code> || 27 || <code>b</code> || 43 || <code>r</code> || 59 || <code>7</code>
|-
| 12 || <code>M</code> || 28 || <code>c</code> || 44 || <code>s</code> || 60 || <code>8</code>
|-
| 13 || <code>N</code> || 29 || <code>d</code> || 45 || <code>t</code> || 61 || <code>9</code>
|-
| 14 || <code>O</code> || 30 || <code>e</code> || 46 || <code>u</code> || 62 || <code>+</code>
|-
| 15 || <code>P</code> || 31 || <code>f</code> || 47 || <code>v</code> || 63 || <code>/</code>
|}
~