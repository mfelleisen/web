#lang scribble/base

@(require "shared.ss")

@title*{What should the core achieve?}

@date{1 Aug 2010}

The core courses of a computer science curriculum should equip an
 undergraduate with @emph{the} mindset and @emph{a} tool set to tackle
 software design problems. As for the former, interviewers, managers, and
 professors should expect three different attributes. First, a successful
 ``graduate'' of the core@margin-note*{In a typical curriculum, the core
 includes two course on programming, two courses on discrete data
 structures and algorithms, and a course on hardware platforms. At
 Northeastern, it also includes a course on logic in programming.} should
 have internalized the basic elements of the software design process and
 should use them routinely. That is, when confronted with a problem, the
 student should attempt to solve it in a systematic manner: gathering and
 organizing data; working through examples to clarify ambiguities and to
 get an idea about the solution; translating the organization of the
 problem data into an organization of the solution; tackling the solution
 proper; and testing the solution for correctness and other constraints.

Second, the student should always be aware of non-functional constraints on
 projects. The engineering of software systems does not happen in a
 vacuum. @margin-note*{Constraints may also include economic constraints,
 such as the cost of a project. Our core courses cannot address the
 solution space for these non-technical constraints, but they should remind
 students of their existence.}  In addition to working functionally,
 software systems must satisfy a range of constraints, e.g., end-to-end
 performance, memory use, or energy consumption. When systems fail to
 satisfy constraints, the students must know that the first step is to
 conduct measurements to find ``hot spots,'' followed by a diagnosis step,
 and ideally resolved with the use of standard solutions (which are less
 expensive and easier to maintain than novel solutions).

Third, the student should have no fear of new programming languages and/or
 new programming environments. In the modern world of computing, any large
 project---or any new job---involves several programming languages, each of
 which comes with its own set of tools and its own environment. A graduate
 of the core courses must know that a solid familiarity with these tools is
 necessary to become a productive programmer and what it takes to acquire
 this level of familiarity.

As for the tool set, the undergraduate should know several programming
 languages---including a declarative database language---so that acquiring
 a new one doesn't seem to be a large obstacle; the typical range of
 important data structures and algorithms; and the practical experience
 with some tools to find ``hot spots'' and the theoretical knowledge to
 analyze and resolve these problems.
