DESIGNS: 

The first decision is whether to represent the CA as a fixed-width or a
growing-width piece of data. One could think of CAs as infinite width, but I am
not sure this would really make sense. When two separately started processes
meet, what do they do? One must therefore think of the CA as always starting on
a finitely wide sequence of cells and growing in both directions. Alternatively,
we just care to think about a finitely wide window on the CA. 

fixed-width:
------------

simplistic.ss
 deals and displays the active state of the CA only
 state-next: use a "shift left" and a "shift right" on the state, 
 then just combine the three states 

beginner.ss
 displays the history of the CA
 same state-next as simplistic.ss (which is actually derived from here)

beg+accu.ss
 state-next: using an accumulator-style function to do a "sliding average" 

lam.ss
 use higher-order functions on beginner.ss

Variable-width: 
---------------

lam-width.ss
  a growing list representing a growing CA state, always displayed at fixed width 
  state-next: make the white neighbors on the left and right explicit before you 
  create the next state. [Truncate as needed]
  uses generative recursion, in addition to higher-order functions

NOTE TO TEACHERS: 

If you don't have time to cover more than the first 12 sections in HtDP, 
you can still cover simplistic.ss and beginner.ss. The students will need
help with state-next and the idea of creating the neighbor lists. 

If you're willing to study the first section of generative recursion (part V)
without higher-order functions, you can use the ideas from lam-width.ss on 
beginner.ss and still get the more interesting idea across. 

The same is true for accumulators. You don't need to see higher-order 
functions and abstractions (Part IV) or generative recursion (Part V) 
to cover accumulators (Part VI) and thus do beg+accu.ss. 

Vectors and imperative programming: 
-----------------------------------

At first glance, the problem suggests an imperative solution using vectors. I
tried, and one more time, I failed miserably with mutations. Worse, I worked and
worked and then discovered the problem. 

Vectors and applicative class-oriented programming: 
---------------------------------------------------

A solution using vectors filled with cell objects works smoothly. It's easy to
compute the neighbor, with two assignment statements. Is this worth it? Not
really. I need to work out a solution where the world provides the left and
right navigation functions, then the assignments are gone and yet, we still have
an OO solution. 

