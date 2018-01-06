#lang scribble/manual

@(require "shared.ss")
@;(define htdp @hyperlink["http://www.htdp.org/"]{HtDP})

@title*[#:tag "coop"]{@ts and co-op}

@date{Aug 19, 2010}

Some 18 years ago, John Dennis, the chairman of the Rice Computer Science
 Department at the time, and I had lunch in our conference room. He
 basically told me that full professors teach service courses---especially
 those who get there after five years---and that the introductory course
 was waiting for @margin-note*{This thought is a supplement to
 @secref["what is ts"].}  me. This is how I got started with freshman
 courses.  After nine years at Rice, I moved to Northeastern and continued
 the development here.

At Rice, @ts had a highly local impact. It grew the introductory course
 by a factor of two, even before the web bubble started. But the impact of
 HtDP/@ts beyond the first course was difficult to discern. I just didn't
 understand the need for a bridge between my first course---which used all
 of @htdp[] and two more chapters---and the downstream curriculum. My vision
 for the @ts curriculum had only started to evolve and I think it
 showed. At Northeastern, I was able to implement almost all of it.

Northeastern is nothing like Rice. Most importantly, it is a co-op
 university. All of our students---several hundred in each of the two
 shifts---are required to complete three six-month co-op positions during
 their five years here. Their employers---Northeastern works with several
 hundred of them, small and large, local, domestic, and international---
 report back to our co-op faculty who collect a portfolio on each student.
 During these co-ops, these students find out what is useful; what works;
 and what is truly relevant---as opposed to fashionable.

Prior to my arrival, Northeastern had been using a standard curriculum
 for two decades: three terms of the currently fashionable language
 (Pascal, C++, Java), using a set of extremely graphics-rich exercises
 intertwined with lessons on practical applications. The curriculum was
 widely published in SIGCSE and related communities, but @emph{it didn't
 work}. At the height of the web bubble, only around one third of the
 students got programming co-ops; most others ended up as ``techies'' as
 they called themselves: moving computers, running scripts, setting up
 routers and networks, etc. And all of this education cost $150,000
 tuition.

After a year at Northeastern, our dean asked me to take over the first
 course.  The first instance was a success---contrary to predictions from
 some local faculty.  Even though it had been considered a trial, we
 switched to the @ts curriculum permanently; the dean suggested that I
 design a bridge course to connect the HtDP course to the rest of the
 curriculum; this started my collaboration on HtDC with Viera Proulx.
 @margin-note*{See the postscript below.} Within a couple of years, I
 started hearing from our co-op faculty that the share of programming
 positions was going up. By 2007---the last time I was involved with the
 course---I was told that the ratio of programming on the @emph{first}
 co-op went up to two thirds and higher. In the meantime, all @ts courses
 have been taught by numerous faculty members with rather different
 teaching styles and personalities than my own. The ratio of programming
 co-op has risen to three quarters and more, and all the downstream faculty
 are happy about the students' programming skills.

Surprisingly the story doesn't end here. Also three years ago, our co-op
 employers started complaining that our MS-level co-ops were worse
 programmers than our third-year undergraduates.  The graduate dean would
 regularly forward me these email complaints; at some point I also met with
 two company representatives. Eventually these complaints got so bad that
 the dean asked me whether I could condense the three-semester HtDP
 curriculum into a one-semester ``boot camp'' for MS students.

I don't think it is possible to condense the three semesters into one, but
 after two years of experimentation, I have found a way to run a
 one-semester Bootcamp for MS students that mixes essential elements from
 all three courses: the design recipe for FP and OOP programming; practice
 with lots of teaching languages code and some class-based Racket code for
 four weeks; pair programming and code walks. The co-op faculty are
 impressed by the change in abilities. They believe they see more
 satisfaction from our co-op employers. The final jury is still out but the
 deans are happy enough to ask me to expand the @ts curriculum at the MS
 level, too. In the spring, I will start the design of a second-semester
 Bootcamp course.

Every teacher has stories about the best students, how they found wonderful
 jobs, how they confirmed the teachings with letters and messages. I am
 happy to report that @ts helped hundreds of students, the whole range
 of students---yes, I do get thank-you notes from some of the weakest
 students---and an equally wide range of employers. 

@section{Postscript}

The initial improvement in our co-op employment happened over the first
 five years of @ts at Northeastern. 

The recent marginal improvement in our co-op employment coincides with a
 period when Northeastern started raising the SAT requirements for some of
 its strong majors, including computer science.  Hence detractors may argue
 that the most recent co-op improvement is due to the higher SAT score.

We are experiencing the same development at the MS level. Without changes
 in the GRE score requirements, we see positive developments in our co-op
 interviews @emph{after} deploying the @ts curriculum. 


@;I understand that this evidence is anecdotal, and I understand that as
@;such, it suffers from the flaws of all anecdotal evidence. It just happens
@;to be anecdotal evidence at a reasonably large scale and wide range of
@;experience, and therefore I consider it relevant. Also see my note on
@;measuring education.
