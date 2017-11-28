#lang scribble/base

@(require "shared.ss")

@title*[#:tag "python"]{Python for asset-backed securities}

@date{26 Apr 2010}

@(define (sec lnk tag) 
   @link[(string-append "http://www.sec.gov/" @lnk) #:underline? #f]{@tag})

@italic{This "thought" is a @sec["comments/s7-08-10/s70810.shtml"]{comment} to
the SEC's @sec["rules/proposed/2010/33-9117.pdf"]{proposal} to use Python
for the specification of asset-backed securities.}

Dear Members of the SEC: 

I am a researcher in the area of programming languages.  My first degree is
a dual MBA/MEng degree (Dipl. Wirtsch.ing., Techn. Univ. Karlsruhe, Ger.).

I welcome the idea of specifying the meaning of asset-backed securities via
computer programs. In 2001, Jean-Marc Eber and Simon Peyton Jones
demonstrated the usefulness of specifying financial contracts as executable
programs. Mr. Eber has since founded a company based on this idea; his
company sells these services across Europe. Others have founded similar
companies in Germany and Norway. In short, the idea has precedent, and it
is timely.

Having said that, I strongly disagree with your choice of programming
language. While Python is currently popular for a range of applications, it
comes with serious problems. These problems aren't just superficial and
easily removed; they are the result of problems at the very core of the
language. For one simple example -- there are many others -- consider
Python's numbers, which simply aren't like anything that anyone with a high
school degree knows. In some other programming languages, notably Scheme, a
formally specified programming language with many different
implementations, they are. Here is a simple informal illustration of the
idea:

@itemlist[
 @item{
   Q: Is negative 5/3 equal to -5/3 
   @linebreak[]
   A: Not in Python, though in a language such as Scheme they are}

 @item{Let c stand for .1}

 @item{
   Q: Does printing c produce .1
   @linebreak[]
   A: Not in Python, and not in Scheme either. Both print 0.1}

 @item{
   Q: What happens if you ask for the value of c
   @linebreak[]
   A: Python says it's 0.1000000001 while Scheme responds with 0.1}
]
 For full-fledged interactions with the interpreters, see end of letter. 

Although my team is responsible for one such an implementation of Scheme, I
do not advertise it as a Python replacement. All existing languages come
with problems as far as modeling asset-backed securities is concerned.  The
proper solution is to design and implement a domain-specific language (DSL)
that satisfies the following criteria:

@itemlist[#:style 'ordered
@item{Programs should look as much as possible like the business mathematics
   we know from text books and from practical applications in the context
   of asset-backed securities.}

@item{Programs should have the intended mathematical meaning.}

@item{The language specification should come as a public document, with an
   open-source license, accompanied by a comprehensive test suite and a
   formal machine-processable model of the language's meaning.}
]

I conjecture that a month would suffice to create a prototype of such a
language that satisfies these criteria modulo a practicality test.  A
semester should be enough to collect feedback for a revision that then
meets the standard for practical usefulness.  (I am also convinced that my
team would willingly suspend its research to work on such a project.) --
After that, companies could use the open-source version, or they could
implement their own and validate that it meets the specification.
Additionally software vendors could produce and sell alternative and
validated implementations. In parallel, programming language researchers
could focus on the formal verification of the DSL.

In order to accommodate unforeseen situations, the language specification
may incorporate provisions for an interaction between the DSL and a widely
available general-purpose programming language (dubbed host language) such
as Python. While such an interaction would somewhat reduce the guarantees
of the DSL, the impact could be lessened with the use of so-called software
contracts that govern the flow of values between the program in the DSL and
libraries of the host language.  Consumers could then understand the
program with respect to the software contracts while paying little or no
attention to the host language.

Matthias Felleisen 
   @linebreak[]
Trustee Professor 
   @linebreak[]
Northeastern University Programming Research Lab (NUPRL) 
   @linebreak[]
Boston, Massachusetts 

Here is a sample interaction with a Python interpreter:

@verbatim[#:indent 5]{
     >>> -(5/3)==(-5/3)
     False
     >>> c = .1
     >>> print c
     0.1
     >>> c
     0.10000000000000001
}

And here are the equivalent interactions with a Scheme implementation: 

@verbatim[#:indent 5]{
     > (equal? (- 5/3) -5/3)
     #t  ;; Scheme's response is short for 'true'
     > (define c .1)
     > (printf "~s\n" c)
     0.1
     > c
     0.1
}

Acknowledgments: Thanks to Joe Marshall for the illustrative examples and
thanks to Jay McCarthy for additional feedback. 
