#lang scribble/base

@(require "shared.ss")

@title*[#:tag "what-is-pl"]{Why teach programming languages}

@date{28 Feb 2010}

Every so often, I get asked why we should our PhD students should be
required to take a course on the principles of programming languages. 
That is, @emph{all} PhD students in CCIS at NU not just those in NUPRL. 

The most recent attempt came from a senior colleague who phrased the attack
as a seemingly innocent comparison: 

@blockquote{If you want to compare the programming languages to another
 course, you should use "formal languages and computability" not
 "algorithms". It is clear that everyone needs algorithms and the
 principles it teaches. But few need to know much more about programming
 languages than they see in their undergraduate program.}

Instead of responding on the spot, I decided to write up my thoughts and
send them back in an email. Here is what I wrote in essence. 

@blockquote{First from my perspective as an advisor: I have graduated 12 or
13 PhDs now. I have been on quite a few dissertation committees, here, at
Rice, and in Europe as external reader. My PhD students have graduated
another dozen or more PhD students. Not one of these people had much
algorithmic content in their dissertations. None of them had more than what
a standard undergraduate course on algorithms puts within reach. This is
almost equally true for many of the Systems dissertations at Rice.}

Of course, one could argue that I am biased. I am advising students who
conduct research in programming languages, but that's not all. Departments
and colleges claim that they prepare PhD students for all kinds of jobs and
that includes "superhacker" and "lead developer" and other fancy
positions. So, there is more: 

@blockquote{Second from my perspective as an academic who knows industrial
work: from my experience as a plain industrial programmer (not an academic
researcher in industry), I can tell you that few if any work is
algorithmically deep. Most of the time it is plain undergraduate
material. As a matter of fact, my company had hired someone with a PhD for
studying the few things where they needed deep algorithmic knowledge. When
programmers or projects needed something, they went to this guy who set up
mathematical models and then derived algorithms. What is far more important
for the bottom line of companies is that projects are structured properly,
even in languages that don't have the necessary tools for structuring. If
projects are well-structured, it is easy to find and fix problems, and it
is easy to branch off into a different direction. This kind of structuring
you learn in PL-oriented courses NOT in algorithms.}

But in the end, it all boils down to the myopia of academics: 

@blockquote{The reason academics like algorithms is that algorithmic
activities produce well-defined, narrow, small but technically difficult
problems that people can solve and these solutions make people's academic
name. And that's not surprising: unlike industry, academia focuses on the
performance of individuals both at the faculty level and at the student
level. Of course, this also shows when algorithmically trained people
produce introductory programming courses. They almost always suck and work
only due to individuals not in general.}

So that's what I have for now. I'll keep thinking about this issue and I
will keep editing this essay as I come up with better ways of saying it
all. 
