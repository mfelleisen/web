#lang scribble/manual

@(require "shared.ss" "growing-a-programmer.rkt")
@(define matthias "/matthias/Articles/")
@(define wsj "https://www.wsj.com/articles/")

@(define damore-memo    (string-append matthias "the-google-memo.pdf"))

@(define damore-suit-pdf (string-append matthias "damore-lawsuit.pdf"))
@(define damore-suit-url "https://www.scribd.com/document/368692388/James-Damore-Lawsuit#download")

@(define finley-opinion-pdf (string-append matthias "finley-opinion.pdf"))
@(define finley-opinion-url (string-append wsj "ok-google-youve-been-served-1516044100?mod=searchresults&page=1&pos=2"))

@(define holman-opinion-pdf (string-append matthias "holman-opinion.pdf"))
@(define holman-opinion-url (string-append wsj "of-furries-and-fascism-at-google-1516144969?mod=searchresults&page=1&pos=1"))


@title*{Free Speech}
@author{Matthias Felleisen}

@date{Jan 14 2018}

@(define nl @element['newline]{ })
@(define hs @element['hspace]{---})

@history[ #:changed "1.3" @elem{Fri Jan 19 18:13:32 EST 2018@nl
Clarified scope of test @nl}]

@history[ #:changed "1.2" @elem{Tue Jan 16 22:16:14 EST 2018@nl
Postscript on Holman's opinion piece added @nl }]

@history[ #:changed "1.1" @elem{Tue Jan 16 22:16:14 EST 2018@nl
Postscript on Finley's opinion piece added @nl
plus link to @link[damore-suit-url]{Damore's lawsuit} @nl} ]

@history[ #:changed "1.0" @elem{Sun Jan 14 21:18:23 EST 2018, initial release @nl 
Thanks to @link["http://www.cs.cornell.edu/~jgm/"]{Greg Morrisett} for suggesting 
 that I put this memo story in context. @nl} ]

@section*{A Short Story of Courage}

A couple of years ago, I recruited a young woman who had obtained her PhD
in a foreign country. She had gone there because of a top-tier advisor in
her experimental area (not programming languages). The two quickly agreed
on a course of exploration and experimentation. Not much later, this
advisor asked the young woman to present the data from these experiments to
a visiting funding panel; apparently, this would be an important site
visit. When she informed her advisor that she had no data yet (because
experiments take a while to run), he told her @italic{make them up.}

The courageous young woman refused and left the research group, even though
this work had been the motivating factor of moving to this foreign country
whose language she did not speak and whose customs she did not yet
understand. 

Keep this story in mind as you read the rest of this thought.

@section*{The Google Memo}

In the summer of 2017, James Damore wrote and circulated a memo on Google's
@link[damore-memo]{internal company politics}.  The memo is, on one hand, a
@italic{cri de cœur} concerning the way Google wishes to indoctrinates its
employees about gender and minority issues. As the memo correctly states,
such "indoctrination camps" almost always backfire and do little or no
good. On the other hand, it is a sophomoric collection of random quotes
from social science (and proto-science) papers to support a highly
questionable thesis concerning the innate programming abilities of
women. If Damore had focused on his primary concern, the extreme culture of
political correctness at Google, he might have had an impact.

Not surprisingly, Google's VP of Diversity condemned the memo and shamed
the author in public, like she had done with others according to the
memo. The mainstream media@margin-note*{I regularly read the Wall Street
Journal in depth and scan the Frankfurter, the Guardian, the New York
Times, and the Sueddeutsche. This is what I mean with "mainstream media".}
tore into this memo and Damore. Even though most of them eventually
published alternative viewpoints, I quickly realized that some of the
newspaper writers and many of the commenting readers had apparently not
read the memo. Good enough for the man or woman on the street.

@section*{What Would a Scientist Do}

My first reaction was that a scientist @emph{must} read the memo before
condemning it. My second one was "let's test the PhD students in my lab and
the College". And then I realized it would also be a test of free speech on
campus. Surely, free speech hurts but I have suffered free speech from The
Left for three decades and I know it doesn't kill.

So I posted the memo on my door and linked to it from my professional web page 
@;
@nested[#:style 'inset]{
 Universities routinely complain that Computer Science employs too few 
 female faculty members. Now, have you ever searched for conservatives 
 on campus? Well yes, not even Google can find them.}
@;
with the word "Google" linked to Damore's memo.

Then I waited. 

I waited to see whether anybody would approach me with specific comments on
the memo. I wanted to see whether he or she had read the memo or would it
read and critique it at my suggestion. Nobody ever approached me.

@section*{Censure} 

In December, Northeastern's administration informed me that four female PhD
students in the College had complained about the memo. It made them feel
uncomfortable.  The women wished to stay anonymous because of the
"differential in authority". In response,
@;
@itemlist[

@item{I explained my motivation, exactly as above, and eventually followed
up with a corresponding email.}

@item{I also explained that colleagues had posted Left Wing@margin-note*{I
played on the common misconception among academics that people in the
military are automatically conservative.} items on their doors for more
than a year. I asked how this would make the ROTC officer candidates feel
when they came to visit me during my office hours.}

@item{@emph{And I explained} that if the university wanted to censure me,
it had the right to do so because the first amendment applies only to laws
of the government, not private companies such as Northeastern.

(I was surprised that this came as a surprise to the administrator.)} 

] 
We left it at that, and I promised to take down the memo when I'd do my
annual office clean up. 

In January 2018, the administration asked me to take down the memo. I did
so, because they have the right to impose a speech policy on me as a
faculty member. Plus, I had made my point.

@section*{So ...}

Do you think that these four young women would have the courage to reject
a request for fake data from their advisors? 

@bold{Campus is where centrist speech goes to die.}

@section*{Postscripts}


p.s. By coincidence, Allysia Finley wrote @link[finley-opinion-url]{a
wonderful opinion piece} (@link[finley-opinion-pdf]{PDF}) on Google's
culture. She is citing extensively from @link[damore-suit-url]{Damore's
discrimination lawsuit} (@link[damore-suit-pdf]{PDF}) against it.  The text
of Damore's lawsuit shows screenshots of internal Google postings and
emails that call for violence against Damore or denigrate conservatives and
religious people. It is an interesting read. 

p.p.s. And a day later, Holman Jenkins has a
@link[holman-opinion-url]{different take} (@link[holman-opinion-pdf]{PDF})
on Google. He also extensively cites the Damore lawsuit, and his citations
are even scarier than Finley's. His conjecture is that Alpha's CEOs have
lost control over their employees.
