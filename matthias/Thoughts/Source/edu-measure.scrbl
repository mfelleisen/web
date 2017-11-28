#lang scribble/base

@(require "shared.ss")

@title*{Measuring education}

@date{27 Mar 2010}

People often ask me whether I have data that proves the superiority of my 
introductory curriculum (variously known as 
 @link["http://www.htdp.org"]{"How to Design Programs"} 
 (@link["http://www.ccs.neu.edu/home/matthias/HtDP2e/"]{"2e"})
or 
 @link["http://www.teach-scheme.org"]{"TeachScheme!"}).

My experience suggests two distinct problems with this question. 

The first problem is that obtaining meaningful data is extremely difficult
 and expensive. A true evaluation should involve a few thousand students;
 it should track them over a couple of years to see whether their
 programming course helped them improve their problem solving skills in
 related fields (say algebra); and it should determine whether it attracts
 kids into a CS-related major. Nobody has the money to conduct this kind of
 study.

And then the real questions come up: How do you compare teaching Java
 vs. Python? How do you evaluate a course that focuses on general design
 ideas vs a course that teaches programming by example? How do you
 differentiate the effects of a curriculum that demands a radical change vs
 something that can be introduced as small incremental changes to the
 dominant fashion?  After 10 years of looking I still don't know the
 answer. Some of our teachers have run parallel courses with one and the
 same teacher running two different curricula. I/we have run
 "competitions", letting students choose which curricula they
 want. TeachScheme! "won" in all those "evaluations" but they involved
 small numbers and are nearly impossible to evaluate statistically and to
 repeat at other places. The curriculum does positively affect attitudes
 toward mathematics, and I am sure that no other programming curriculum has
 achieved this. But how do you measure attitude change in one semester?

The second problem is that people who teach programming don't make use of
 educational data. More precisely, it is extremely difficult to find
 teachers or faculty who teach some programming curriculum @math{P} because
 of measurements that demonstrate the superiority of @math{P} over some
 other curriculum. The choice of curriculum is typically considered nothing
 but a choice of language. And the choice of language in high school is
 dictated by the choice of language for the AP test (currently Java) and
 some industrial standards (some form of BASIC). At college, the choice is
 a compromise between first-year and downstream faculty, a bow to perceived
 industrial needs, a nod to the people who are willing to teach the
 course---so that others can conduct really important research.

And because of all these other factors, people reject data that contradicts
 their view.  Everyone who teaches something "inferior" will come with some
 reason as to why some study does not apply to his/her school population or
 class constraints or city or teaching style and so on. After meeting lots
 of these people---people who come up with excuses even before they hear
 about your data---you begin to wonder why you should spend all this money,
 all this time on evaluating programming courses.

Let's just go do research.

p.s. If you are skeptical of these thoughts---and hey, I am just a PL
researcher, so that's justified---read
@link["http://www.amazon.com/Lets-Kill-Dick-Jane-Publishing/dp/1587319195"]{Let's
Kill Dick and Jane}. The author is a liberal journalist who investigated
the history of Open Court and its efforts to measure education and to use
measures to improve it.
