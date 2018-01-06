#lang scribble/manual

@(require "shared.ss")

@title*[#:tag "colleagues"]{HtDP Courses and Colleagues}

@date{Apr 9, 2011}

So, you are considering a freshman course based on @htdp[] or @htdp2e[]. Then
 consider yourself brave. 

Time and again, we hear sad stories from people who charged ahead and
 switched the introductory course to @htdp[]. Yes, they have a good run and
 they have reports on enthusiastic and capable graduates. But no, their
 colleagues roll their eyes, stomp their feet, and refuse to appreciate the
 accomplishment. These colleagues complain that ``students can't even
 iterate over an array after taking an @htdp[] course'' or, more generally,
 ``the students don't know language X, which is an absolute minimum for
 their important course.''  The list goes on, but it is pointless to repeat
 them here. It all boils down to one point:
@;
@nested[#:style 'inset]{
@nested[#:style 'inset]{
@nested[#:style 'inset]{
@nested[#:style 'inset]{
@emph{
You are the reformer and this means you need to
accommodate ``them'' if you wish to succeed.
}
}}}}
@;
 It took me a long time to understand this simple truth, but once you do,
 your chances of success dramatically increase. 

To understand my point, let me explain a little psychological insight
 first. Our colleagues ``know'' how to program and they ``know'' how to
 teach it. They learned it some 30 or 20 or even just 10 years ago. Here is
 how you do it. You show the kids how to print @scheme["hello world"] and
 you show them how to read a line or a number from a file; you declare some
 variables and arrays; you write some loops, @bold{while} or @bold{for}
 preferably; you package things up into procedures and methods; and if you
 want to be fancy, you can always modularize your program with
 classes. And that's all there is to it. 

Everything else is software engineering, and we don't need to concern
 ourselves with that in a first course. They learned it that way, they
 programmed a bit that way, and we should teach it that way. What's the big
 deal? Sure enough, we could freshen up on the syntax and the I/O methods
 @emph{du jour} but that's all that's needed. And once students know those
 basics, your colleagues can teach them the important things: big Oh,
 machine architecture, lin alg for graphics, probability for AI, etc. This
 description is a caricature but it isn't that far off.

Truth is too few academics and colleagues program much (other than in
 LaTeX) or participate in the construction of large systems (other than via
 thought experiments). And they think that if they could learn programming
 in the above-mentioned fashion, and if it was enough to get them as far
 they got, it is good enough for freshmen in 2011. Never mind that our
 understanding of programming and proper program design has evolved and
 that we really need to change how and what we teach.

Now let's face it, reality is our colleagues are too busy to learn our new
 way of programming, figure out an approach that calls for whole-sale
 adoption not just some gradual changes. Our colleagues teach their own
 courses, they have grants to chase, papers to push out the door, families
 to take care of. We can't impose another large task on them. We must teach
 students properly and we must teach students how to ``talk'' to our
 colleagues. Put differently, @emph{it is our task to prepare our students
 so that they can also program the way our colleagues expect them to
 program}, and the students need this capability any way, because they will
 end up working in companies where most people learned to program the old
 way.

The problem is that you cannot teach everything in one course. Furthermore
 you probably can't just teach it all by yourself without any help. Getting
 someone else involved also has the advantage of widening the ``basis of
 appreciation'' for the @htdp[] style approach to teaching programming. 

At a regular university with a reasonably standard four-year curriculum and
 decent colleagues, you need two semesters and one colleague to get
 started. Take on the first semester and drill basic design skills until
 they become second nature in the teaching languages. Ideally have your
 colleague teach this course with you; there is no better way of learning
 what @htdp[] is about than teaching it with someone else. Take the second
 semester (1) to show students how the design skills apply to whatever
 language your department finds amenable and (2) to connect design with
 basic algorithms, standard libraries, and conventional programming
 techniques (@bold{while}, @bold{for}, and @bold{arrays} über alles). It is
 probably best to let your colleague lead the second semester.

For the generalization of students' design skills to other languages,
 consider using @htdc[]. It demonstrates---slowly and carefully---how
 design applies to Java. @margin-note*{If you choose @htdc[], Shriram
 Krishnamurthi and Kathi Fisler's experience suggests to skip right to
 tree-structured data once the basics of classes and interfaces have been
 covered.} It is also possible to teach design recipes in Python and
 JavaScript.

For the adaptation of the design skills to conventional programming, you
 will need four to six weeks at the end of second semester. The goal is to
 make the students ``buzzword compliant'' for their first co-op or
 internship: 

@itemlist[

@item{The students need to know how to read from a file and they may have
 to know how to tokenize a line (regular expressions, tokenizers). Yes, we
 know that this is really a form of parsing but our colleagues don't seem
 to appreciate this connection.}

@item{The students need to know how to write to a file.}

@item{While the design part of the second semester can easily introduce
 applicative and imperative versions of stacks, queues and various search
 trees, it is now time to show students some modern data structures,
 especially what Java calls vectors, hashes, and maps, but also associative
 tables.} 

@item{Naturally the students need to know @bold{for} and @bold{while} loops
 to process such indexed data structures.}

@item{Lastly, you may wish to show your students some rudimentary GUI
 programming using ``native'' libraries. This part is optional but students
 might find this useful.}

]
 
As @secref{coop} explains, this strategy worked really well at
 Northeastern. The students' programming skills improved dramatically, and
 our co-op department reports on these improvements on a regular basis. Our
 colleagues' appreciation of the students' programming skills has grown
 dramatically. Sure, we hear some grumbling on occasions, but they are
 relatively minor and they quickly die down when we offer to hand over the
 course. 

Your colleagues may differ from those at Northeastern. Your students may
 differ. So your mileage may differ but ensuring a connection to the
 conventional downstream curriculum is almost always critical. 
