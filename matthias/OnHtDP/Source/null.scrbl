#lang scribble/base

@(require "shared.ss")

@title*[#:tag "what is ts"]{NULL in Java}

@date{Oct 1, 2010}

"How to Design Classes" (HtDC) is the second volume to @htdp[]. Its purpose
 is to demonstrate how the design approach of @htdp[] applies in the context
 of a typed, class-based object-oriented programming language such as Java. 
 The most important difference concerns the introduction of abstractions, 
 because OOPL is all about building abstractions and many pattern-based 
 suggestions are about building abstractions in an extensible and reusable
 manner. 

HtDC has been around for nearly six years, used in Northeastern's second
 course; in some of the @ts workshops for high school teachers and college
 instructors; and in a number of courses around the country. Time and
 again, however, readers who have taught Java for a long time question us
 about the approach to Java. The words "non-standard" or "non-paradigmatic"
 come up. When asked for examples, the typical critic point to HtDC's
 failure to use @tt{NULL} for building lists, trees, and other kinds of
 data structures.

So here is a collection of comments on @tt{NULL} and its use in Java-style
 programming: 

@q-a[

 [@q{Tony Hoare invented @tt{NULL}.}
  @a{he has called null his @hyperlink["http://qconlondon.com/london-2009/presentation/Null%20References:%20The%20Billion%20Dollar%20Mistake}"]{Billion Dollar Mistake}.}
 ]

 [@q{Google uses Java to write its software before it's translated into
  JavaScript.}
  @a{They argue against using @tt{NULL} in 
    @hyperlink["http://www.youtube.com/watch?v=4F72VULWFvc&list=QL"]{a
    video-taped lecture} by one of their internal quality people.}
 ]

 [@q{Kathi Fisler formulated HtDC's principles like this.}
  @a{"When you call list.size(), why should your code have to decide if the
  list is empty or not? This is object-oriented programming--the object is
  supposed to know what it is and do the right thing, not deal with a bunch
  of alternative cases." That's short and sweet.}
 ]
]

Shriram K., Mike G., 
