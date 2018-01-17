#lang at-exp racket

(require (except-in scriblib/autobib proceedings-location)
         scribble/core
         (only-in scribble/manual emph)
         scribble/decode scribble/base)

(provide (all-defined-out))

(define-cite ~cite cite
  bibliography
  #:style author+date-style #;number-style)

(define bagwell (author-name "Phil" "Bagwell"))
(define okasaki (author-name "Chris" "Okasaki"))

(define short? #t)
(define-syntax define/short
  (syntax-rules ()
    [(_ i e e*) (define i (if short? e e*))]
    [(_ i e) (define i e)]))

(define IEEE "IEEE ")
(define ACM "ACM ")
(define International "Intl. ")
(define Conference "Conf. ")
(define Workshop "Wksp. ")
(define Journal "J. ")
(define Symposium "Sym. ")
(define Transactions "Trans. ")
(set! Transactions "")
(set! Conference "")

(define (proceedings-location location #:pages [pages #f] #:series [series #f] #:volume [volume #f])
  (define (to-string v) (format "~a" v))
  (let* ([s @elem{In @italic{@elem{@|location|}}}]
         [s (if series
                @elem{@|s|, @(format "~a" series)}
                s)]
         [s (if volume
                @elem{@|s| volume @(format "~a" volume)}
                s)]
         [s (if pages
                @elem{@|s|, pp. @(to-string (car pages))--@(to-string (cadr pages))}
                s)])
    s))

(define/short rta "Rewriting Techniques and Applications")
(define/short scripts "STOP" "Script to Program Evolution")
(define/short asplas "APLAS" (string-append "Asian " Symposium "Programming Languages and Systems"))
(define/short fpca "FPCA" (string-append ACM International Conference "Functional Programming Languages and Computer Architecture"))
(define/short icfp "ICFP" (string-append ACM International Conference "Functional Programming"))
(define/short pldi "PLDI" (string-append ACM Conference "Programming Language Design and Implementation"))
(define/short popl "POPL" (string-append ACM Symposium "Principles of Programming Languages"))
(define/short lncs "LNCS" "Lecture Notes in Computer Science")
(define/short sigplan-notices "SIGPLAN Notices" (string-append ACM "SIGPLAN Notices"))
(define/short sfp "SFP" (string-append Workshop "Scheme and Functional Programming"))
(define/short jfp "JFP" (string-append Journal "Functional Programming"))
(define/short hosc "HOSC" "Higher-Order and Symbolic Programming")
(define/short lfp "LFP" "LISP and Functional Programming")
(define/short lsc "LispSC" "LISP and Symbolic Computation")
(define/short ifl "IFL" (string-append International Symposium "Functional and Logic Programming"))
(define/short tfp "TFP" (string-append Symposium "Trends in Functional Programming"))
(define/short ecoop "ECOOP" (string-append "European " Conference "Object-Oriented Programming"))
(define/short oopsla "OOPSLA" (string-append ACM Conference "Object-Oriented Programming, Systems, Languages and Applications"))
(define/short ieee-software (string-append IEEE "Software"))
(define/short ieee-computer (string-append IEEE "Computer"))
(define/short a:toplas "TOPLAS" (string-append Transactions "Programming Languages and Systems"))
(define/short dls "DLS" "Dynamic Languages Symposium")
(define/short flops "FLOPS" (string-append Symposium "Functional and Logic Programming"))
(define/short esop "ESOP" (string-append "European " Symposium "on Programming"))
(define/short iclp "ICLP" (string-append  International Conference "on Logic Programming"))
(define/short fse "FSE" (string-append International Symposium "on the Foundations of Software Engineering"))
(define/short aosd "AOSD" (string-append International Conference "on Aspect-Oriented Software Development"))
(define/short foal "FOAL" "Foundations of Aspect-Oriented Languages")
(define/short tlca "TLCA" (string-append International Conference "Typed Lambda Calculi and Applications"))
(define/short i&c "Info. & Comp." "Information and Computation")
(define/short haskell "Haskell Workshop")
(define/short tcs "Theoretical Computer Science")
(define/short tacs (string-append International Symposium "Theoretical Aspects of Computer Science"))
(define/short ml-workshop "ML Workshop")
(define/short sac "SAC" (string-append Symposium "on Applied Computing"))
(define/short gpce "GPCE" "Generative Programming: Concepts & Experiences")



;; -----------------------------------------------------------------------------

(define oka
  (make-bib #:title "Purely Functional Data Structures"
            #:is-book? #t
            #:author okasaki
            #:location (book-location #:publisher "Cambridge University Press")
            #:date "1998"))
(define bagwell-lists
  (make-bib #:title "Fast Functional Lists, Hash-Lists, Deques and Variable Length Arrays"
            #:is-book? #f
            #:author bagwell
            #:location "In Implementation of Functional Languages, 14th International Workshop"
            #:date "2002"))
(define bagwell-trie
  (make-bib  #:title "Fast And Space Efficient Trie Searches"
             #:is-book? #f
             #:author bagwell
             #:location "Technical report, 2000/334, Ecole Polytechnique  F´ed´erale de Lausanne"
             #:date "2000"))
(define hood-mel
  (make-bib  #:title "Real-time queue operations in pure Lisp"
             #:is-book? #f
             #:author (authors "Robert Hood" "Robert Melville")
             #:location "Information Processing Letters, 13(2):50-53"
             #:date "1981"))
(define pairing
  (make-bib  #:title "The pairing heap: A new form of self-adjusting heap"
             #:is-book? #f
             #:author (authors "Michael L. Fredman" "Robert Sedgewick" "Daniel D. K. Sleator" "Robert E. Tarjan")
             #:location "Algorithmica 1 (1): 111-129"
             #:date "1986"))
(define vuillemin
  (make-bib  #:title "A data structure for manipulating priority queues"
             #:is-book? #f
             #:author (author-name "Jean" "Vuillemin")
             #:location "Communications of the ACM, 21(4):309-315"
             #:date "1978"))
(define brown
  (make-bib  #:title "Implementation and analysis of binomial queue algorithms"
             #:is-book? #f
             #:author (author-name "Mark R" "Brown")
             #:location "SIAM J. on Computing, 7(3):298-319"
             #:date "1978"))
(define crane
  (make-bib  #:title "Linear lists and priority queues as balanced binary trees"
             #:is-book? #f
             #:author (author-name "Clark Allan" "Crane")
             #:location "PhD thesis, Computer Science Department, Stanford University. STAN-CS-72-259."
             #:date "1972"))
(define sla
  (make-bib  #:title "Self-adjusting binary search trees"
             #:is-book? #f
             #:author (authors "Daniel D. K. Sleator" "Robert E. Tarjan")
             #:location "J. of the ACM, 32(3):652-686"
             #:date "1985"))
(define kaplan-tarjan
  (make-bib #:title "Persistent lists with catenation via recursive slow-down"
            #:is-book? #f
            #:author (authors "Haim Kaplan" "Robert E. Tarjan")
            #:location "Proceedings of the twenty-seventh annual ACM symp. on Theory of computing"
            #:date "1995"))
(define oka-red-black
  (make-bib #:title "Red-Black Trees in Functional Setting"
            #:is-book? #f
            #:author okasaki
            #:location "J. Functional Programming"
            #:date "1999"))
(define finger
  (make-bib #:title "Finger trees: a simple general-purpose data structure"
            #:is-book? #f
            #:author (authors "Ralf Hinze" "Ross Paterson")
            #:location "J. Functional Programming"
            #:date "2006"))

(define srfi/1
  (make-bib #:title "SRFI-1: List Library"
            #:author "Olin Shivers"
            #:date "1999"))
(define thf:popl08
  (make-bib #:title "The design and implementation of Typed Scheme"
            #:author (authors "Sam Tobin-Hochstadt" "Matthias Felleisen")
            #:location (proceedings-location popl #:pages '(395 406))
            #:date "2008"))
(define thf-dls
  (make-bib #:title "Interlanguage refactoring: From scripts to programs"
            #:author (authors "Sam Tobin-Hochstadt" "Matthias Felleisen")
            #:location (proceedings-location "DLS"
                                             #:pages '(964 974))
            #:date "2006"))
(define ctf-scheme
  (make-bib #:title "Advanced Macrology and the Implementation of Typed Scheme"
            #:author (authors "Ryan Culpepper" "Sam Tobin-Hochstadt" "Matthew Flatt")
            #:location (proceedings-location "Scheme and Functional Programming")
            #:date "2007"))
(define th:lal
  (make-bib #:title "Languages as libraries"
            #:author (authors "Sam Tobin-Hochstadt" "Vincent St-Amour" "Ryan Culpepper" "Matthew Flatt" "Matthias Felleisen")
            #:location (proceedings-location pldi #:pages '(132 141))
            #:date "2011"))
(define sathff-padl12
  (make-bib #:title "Typing the numeric tower"
            #:author (authors "Vincent St-Amour" "Sam Tobin-Hochstadt"
                              "Matthew Flatt" "Matthias Felleisen")
            #:location (proceedings-location
                        "International Symp. on Practical Aspects of Declarative Languages"
                        #:pages '(289 303))
            #:date "2012"))
(define sathf-oopsla12
  (make-bib #:title "Optimization coaching: Optimizers learn to communicate with programmers"
            #:author (authors "Vincent St-Amour" "Sam Tobin-Hochstadt" "Matthias Felleisen")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(163 178))
            #:date "2012"))
(define oc-oopsla sathf-oopsla12)

(define stf-esop
  (make-bib #:title "Practical Variable-Arity Polymorphism"
            #:author (authors "T. Stephen Strickland" "Sam Tobin-Hochstadt" "Matthias Felleisen")
            #:location (proceedings-location "European Symp. on Programming")
            #:date "2009"))
(define th-diss
  (make-bib #:title "Typed Scheme: From Scripts to Programs"
            #:author "Sam Tobin-Hochstadt"
            #:is-book? #t
            #:location (dissertation-location #:institution "Northeastern University")
            #:date "2010"))
(define thf-icfp
  (make-bib #:title "Logical types for untyped languages"
            #:author (authors "Sam Tobin-Hochstadt" "Matthias Felleisen")
            #:location (proceedings-location "International Conf. on Functional Programming"
                                             #:pages '(117 128))
            #:date "2010"))
(define culpepper-scp
  (make-bib #:title "Debugging hygienic macros"
            #:author (authors "Ryan Culpepper" "Matthias Felleisen")
            #:location (journal-location "Science of Computer Programming"
                                         #:pages '(496 515)
                                         #:number "7"
                                         #:volume "75")
            #:date "2010"))
(define rc:fortifying
  (make-bib #:title "Fortifying macros"
            #:author (authors "Ryan Culpepper" "Matthias Felleisen")
            #:location (proceedings-location icfp #:pages '(235 246))
            #:date "2010"))

#|
@article{pierce:lti,
 author = {Benjamin C. Pierce and David N. Turner},
 title = {Local type inference},
 journal = toplas,
 volume = {22},
 number = {1},
 year = {2000},
 pages = {1--44},
 publisher = acmpress,
 address = nyny,
}
|#

(define (toplas p n v) 
  (journal-location "ACM Transactions on Programming Languages and Systems"
		    #:pages p
		    #:number (if (number? n) (number->string n) n)
		    #:volume (if (number? v) (number->string v) v)))

(define lti-journal
  (make-bib #:title "Local type inference"
	    #:location (toplas '(1 44) 1 22)
	    #:date "2000"
	    #:author (authors "Benjamin C. Pierce" "David N. Turner")))

(define skew
  (make-bib #:title "An applicative random-access stack"
            #:author "Eugene W. Myers"
            #:date "1983"
            #:location (journal-location "Information Processing Letters"
                                         #:pages '(241 248)
                                         #:number 5
                                         #:volume 17)))
(define (planet-cite pkg ver author [date #f])
  (make-bib #:title (format "~a, version ~a" pkg ver)
            #:author author
            #:date date
            #:location "PLaneT Package Repository"))

(define planet
  (make-bib #:title "Component Deployment with PLaneT: You Want it Where?"
            #:author "Jacob Matthews"
            #:date "2006"
            #:location (proceedings-location "Scheme and Functional Programming")))

(define galore (planet-cite "Galore" "4.2" "Jens Axel Soegaard"  "2009"))
(define dvh-ra (planet-cite "RaList: Purely Functional Random-Access Lists" 
                       "2.3"
                       (authors (author-name "David" "Van Horn"))
                       "2010"))

(define cce-queue
  (planet-cite "Scheme Utilities" "7" "Carl Eastlund" "2010"))

(define schelog
  (make-bib #:title "Programming in Schelog"
            #:author "Dorai Sitaram"
            #:url "http://www.ccs.neu.edu/~dorai/schelog/schelog.html"
            #:date "1993"))

(define clojure 
  (make-bib #:title "Clojure"
            #:author "Rich Hickey"
            #:date "2010"
            #:url "http://clojure.org"))

(define ansi-smalltalk
  (make-bib #:title "ANSI Smalltalk Standard"
            #:is-book? #t
            #:date "1998"))
(define smalltalk80
  (make-bib #:title "Smalltalk-80: the language and its implementation"
            #:author (authors "Adele Goldberg" "David Robson")
            #:date "1983"
            #:location (book-location #:publisher "Addison-Wesley")
            #:is-book? #t))

(define plt-tr1
  (make-bib #:title    "Reference: Racket"
            #:author   (authors "Matthew Flatt" "PLT")
            #:date     "2010"
            #:location (techrpt-location #:institution "PLT Design Inc."
                                         #:number "PLT-TR-2010-1")
            #:url      "http://racket-lang.org/tr1/"))

(define kffd:hygiene
  (make-bib #:title "Hygienic macro expansion"
            #:author (authors "Eugene Kohlbecker"
                              "Daniel P. Friedman"
                              "Matthias Felleisen"
                              "Bruce Duba")
            #:is-book? #f
            #:location (proceedings-location lfp)
            #:date "1986"))
(define kohlbecker-diss
  (make-bib #:title "Syntactic Extensions in the Programming Language Lisp"
            #:author "Eugene Kohlbecker"
            #:is-book? #t
            #:location (dissertation-location #:institution "Indiana University")
            #:date "1986"))
(define kw:mbe
  (make-bib #:title "Macro-by-example: deriving syntactic transformations from their specifications"
            #:author (authors "Eugene Kohlbecker" "Mitchell Wand")
            #:location (proceedings-location popl #:pages '(77 84))
            #:date "1987"))
(define dhb:sc
  (make-bib #:title "Syntactic abstraction in Scheme"
            #:author (authors (author-name "R. Kent" "Dybvig") "Robert Hieb" "Carl Bruggeman")
            #:location (journal-location lsc #:pages '(295 326) #:number "4" #:volume "5")
            #:date "1992"))
(define dybvig-case-lambda
  (make-bib #:title "A new approach to procedures with variable arity"
            #:author (authors (author-name "R. Kent" "Dybvig") "Robert Hieb")
            #:date "1990"
            #:location (journal-location "Lisp and Symbolic Computation"
                                         #:pages '(229 244)
                                         #:number 3
                                         #:volume 3)))
(define lisp-hopl
  (make-bib #:title "The evolution of Lisp"
            #:author (authors (author-name "Guy L." "Steele Jr.") "Richard P. Gabriel")
            #:location (proceedings-location "Conf. on History of Programming Languages"
                                             #:pages '(231 270))
            #:date "1993"))

(define f:modules
  (make-bib #:title "Composable and compilable macros: you want it when?"
            #:author "Matthew Flatt"
            #:is-book? #f
            #:location (proceedings-location icfp #:pages '(72 83))
            #:date "2002"))
(define ff:ho-contracts
  (make-bib #:title "Contracts for higher-order functions"
            #:author (authors "Robert Bruce Findler" "Matthias Felleisen")
            #:is-book? #f
            #:location (proceedings-location icfp #:pages '(48 59))
            #:date "2002"))
(define racket-classes
  (make-bib #:title "Scheme with classes, mixins, and traits"
            #:author (authors "Matthew Flatt" "Robert Bruce Findler" "Matthias Felleisen")
            #:location (proceedings-location asplas #:pages '(270 289))
            #:date "2006"))
(define cof-cpce
  (make-bib #:title "Syntactic abstraction in component interfaces"
            #:author (authors "Ryan Culpepper" "Scott Owens" "Matthew Flatt")
            #:location (proceedings-location "Conf. Generative Programming and Component Engineering"
                                             #:pages '(373 388))
            #:date "2005"))
(define ff:units
  (make-bib #:title "Units: Cool modules for HOT languages"
            #:author (authors "Matthew Flatt" "Matthias Felleisen")
            #:location (proceedings-location icfp #:pages '(236 248))
            #:date "1998"))
(define khmgpf-hosc
  (make-bib #:title "Implementation and use of the PLT Scheme web server"
            #:author (authors "Shriram Krishnamurthi" "Peter Walton Hopkins" "Jay McCarthy"
                              "Paul T. Graunke" "Greg Pettyjohn" "Matthias Felleisen")
            #:location (journal-location "Higher-Order and Symbolic Computing"
                                         #:pages '(431 460)
                                         #:number "4"
                                         #:volume "20")
            #:date "2007"))
(define native+serializable-continuations
  (make-bib #:title "The two-state solution: Native and serializable continuations accord"
            #:author "Jay McCarthy"
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(567 582))
            #:date "2010"))

(define cltl2 (make-bib #:title "Common Lisp: the language"
                        #:is-book? #t
                        #:author (author-name "Guy L." "Steele Jr.")
                        #:location (book-location #:publisher "Digital Press"
                                                  #:edition "Second")
                        #:date "1994"))
(define r6rs (make-bib #:title @elem{Revised@superscript{6} report on the algorithmic language Scheme}
                       #:author (authors "Michael Sperber" "Matthew Flatt" "Anton Van Straaten" (author-name "R. Kent" "Dybvig") "Robert Bruce Findler" "Jacob Matthews" )
                       #:location (journal-location "J. of Functional Programming"
                                                    #:pages '(1 301)
                                                    #:number "S1"
                                                    #:volume "19")
                       #:date "2009"))

(define gabriel-benchmarks
  (make-bib #:title "Performance and evaluation of LISP systems"
            #:author "Richard P. Gabriel"
            #:is-book? #t
            #:location (book-location #:publisher "MIT Press")
            #:date "1985"))
(define larceny
  (make-bib #:title "Lambda, the ultimate label or a simple optimizing compiler for Scheme"
            #:author (authors "William D. Clinger" "Lars Thomas Hansen")
	    #:location (proceedings-location "Conf. on LISP and functional programming"
                                             #:pages '(128 139))
            #:date "1994"))
(define gambit
  (make-bib #:title "A parallel virtual machine for efficient Scheme compilation"
            #:author (authors "Marc Feeley" "James S. Miller")
	    #:location (proceedings-location "Conf. on LISP and Functional Programming"
                                             #:pages '(119 130))
            #:date "1990"))
(define bigloo
  (make-bib #:title "Bigloo: a portable and optimizing compiler for strict functional languages"
            #:author (authors "Manuel Serrano" "Pierre Weis")
	    #:location (proceedings-location "Static Analysis Symp."
                                             #:pages '(366 381))
            #:date "1995"))
(define shootout
  (make-bib #:title "The Computer Language Benchmarks Game"
            #:url "http://shootout.alioth.debian.org"
            #:date "2011"))
(define pseudoknot
  (make-bib #:title "Benchmarking implementations of functional languages with ``pseudoknot'' a float-intensive benchmark"
            #:author (authors "Pieter H. Hartel" "Marc Feeley" "Martin Alt" "Lennart Augustsson"
                              "Peter Baumann" "Marcel Beemster" "Emmanuel Chailloux" "Christine H. Flood"
                              "Wolfgang Grieskamp" "John H. G. van Groningen" "Kevin Hammond"
                              "Bogumił Hausman" "Melody Y. Ivory" "Richard E. Jones" "Jasper Kamperman"
                              "Peter Lee" "Xavier Leroy" "Rafael D. Lins" "Sandra Loosemore"
                              "Niklas Röjemo" "Manuel Serrano" "Jean-Pierre Talpin" "Jon Thackray"
                              "Stephen Thomas" "Pum Walters" "Pierre Weis" "E.P. Wentworth")
            #:is-book? #f
            #:location (journal-location "J. of Functional Programming"
                                         #:pages '(621 655)
                                         #:number "4"
                                         #:volume "6")
            #:date "1996"))
(define hari-pfds
  (make-bib #:title "Functional data structures for Typed Racket"
            #:author (authors (author-name "Hari" "Prashanth" #:suffix "K R") "Sam Tobin-Hochstadt")
            #:date "2010"
            #:location (proceedings-location "Works. Scheme and Functional Programming"
                                             #:pages '(1 7))))

(define iso-c
  (make-bib #:title "ISO C Standard 1999"
            #:author "ISO"
            #:date "1999"
            #:is-book? #t))
(define c++
  (make-bib #:title "The C++ programming language"
            #:author "Bjarne Stroustrup"
            #:is-book? #t
            #:date "2000"
            #:location (book-location #:publisher "Addison-Wesley" #:edition "third")))

(define java-spec
  (make-bib #:title "The Java™ language specification"
            #:author (authors "James Gosling" "Bill Joy" (author-name "Guy L." "Steele" #:suffix "Jr.") "Gilad Bracha")
            #:is-book? #t
            #:location (book-location #:publisher "Addison-Wesley"
                                      #:edition "Fourth")
            #:date "2005"))
(define algol-60
  (make-bib #:title "Revised report on the algorithm language ALGOL 60"
            #:author (authors "J. W. Backus" "F. L. Bauer" "J. Green" "C. Katz"
                              "J. McCarthy" "A. J. Perlis" "H. Rutishauser"
                              "K. Samelson" "B. Vauquois" "J. H. Wegstein"
                              "A. van Wijngaarden" "M. Woodger"
                              (author-name "P." "Naur" #:suffix "(editor)"))
            #:date "1963"
            #:location (journal-location "Commun. ACM"
                                         #:pages '(1 17)
                                         #:volume "6"
                                         #:number "1")))
(define simula-67
  (make-bib #:title "SIMULA 67 common base language"
            #:author "Ole-Johan Dahl"
            #:is-book? #t
            #:date "1968"
            #:location (book-location #:publisher "Norwegian Computing Center")))
(define sml-definition
  (make-bib #:title "The Definition of Standard ML, Revised Edition"
            #:author (authors "Robin Milner" "Mads Tofte" "Robert Harper" "David MacQueen")
            #:is-book? #t
            #:date "1997"
            #:location (book-location #:publisher "MIT Press")))
(define ocaml-manual
  (make-bib #:title "The Objective Caml system, Documentation and user's manual"
            #:author (authors "Xavier Leroy"
                              "Damien Doligez"
                              "Alain Frisch"
                              "Jacques Garrigue"
                              "Didier Rémy"
                              "Jérôme Vouillon")
            #:date "2010"))
(define haskell2010
  (make-bib #:title "Haskell 2010 Language Report"
            #:author (author-name "Simon" "Marlow" #:suffix "(editor)")
            #:is-book? #f
            #:date "2010"))
(define clean-lang
  (make-bib #:title "CLEAN: A language for functional graph rewriting"
            #:author (authors "T. H. Brus" "Marko C. J. D. van Eekelen" "M. O. van Leer" "Marinus J. Plasmeijer")
            #:location (proceedings-location "Functional Programming Languages and Computer Architecture")
            #:date "1987"))
(define chez-manual
  (make-bib #:title "Chez Scheme Version 8 User's Guide"
            #:author (author-name "R. Kent" "Dybvig")
            #:is-book? "#t"
            #:location (book-location #:publisher "Cadence Research Systems")
            #:date "2009"))

(define mw-91
  (make-bib #:title "Correctness of static flow analysis in continuation semantics"
            #:author (authors "Margaret Montenyohl" "Mitchell Wand")
            #:date "1991"
            #:location (journal-location "Science of Computer Programming"
                                         #:pages '(1 18)
                                         #:number "1"
                                         #:volume "16")))

(define orbit
  (make-bib #:title "ORBIT: an optimizing compiler for Scheme"
	    #:author (authors "Norman Adams" "David Kranz" "Richard Kelsey" "Jonathan Rees"
			      "Paul Hudak" "James Philbin")
	    #:location (proceedings-location "Symp. on Compiler Construction"
                                             #:pages '(219 233))
	    #:date "1986"))
(define kelsey-tc
  (make-bib #:title "Compilation by Program Transformation"
	    #:author "Richard Andrew Kelsey"
            #:is-book? #t
	    #:location (dissertation-location #:institution "Yale University")
	    #:date "1989"))
(define spj-esop96
  (make-bib #:title "Compiling Haskell by program transformation: A report from the trenches"
            #:author (author-name "Simon L" "Peyton Jones")
            #:location (proceedings-location "European Symp. on Programming"
                                             #:pages '(18 44))
            #:date "1996"))
(define oo-dispatch
  (make-bib #:title "Optimization of Object-Oriented Programs using Static Class Hierarchy Analysis"
            #:author (authors "Jeffrey Dean" "David Grove" "Craig Chambers")
            #:location (proceedings-location "European Conf. on Object-Oriented Programming"
                                             #:pages '(77 101))
            #:date "1995"))

(define clements-extensible
  (make-bib #:title "A Comparison of Designs for Extensible and Extension-Oriented Compilers"
            #:author "Austin T. Clements"
            #:is-book? #t
            #:location (dissertation-location #:institution "Massachusetts Institute of Technology"
                                              #:degree "MS")
            #:date "2008"))

(define fisher+shivers (authors "David Fisher" "Olin Shivers")) ; for equality
(define fisher-icfp
  (make-bib #:title "Static semantics for syntax objects"
            #:author fisher+shivers
            #:location (proceedings-location "International Conf. on Functional Programming"
                                             #:pages '(111 121))
            #:date "2006"))
(define fbf:scribble
  (make-bib #:title "Scribble: closing the book on ad-hoc documentation tools"
            #:author (authors "Matthew Flatt" "Eli Barzilay" "Robert Bruce Findler")
            #:location (proceedings-location icfp #:pages '(109 120))
            #:date "2009"))
(define fisher-jfp
  (make-bib #:title "Building language towers with Ziggurat"
            #:author fisher+shivers
            #:location (journal-location "J. of Functional Programming"
                                         #:pages '(707 780)
                                         #:volume "18"
                                         #:number "5-6")
            #:date "2008"))
(define fisher-dissertation
  (make-bib #:title "Static Semantics for Syntax Objects"
            #:author "David Fisher"
            #:is-book? #t
            #:location (dissertation-location #:institution "Northeastern University")
            #:date "2010"))

(define jse-oopsla
  (make-bib #:title "The Java syntactic extender"
            #:author (authors "Jonathan Bachrach" "Keith Playford")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(31 42))
            #:date "2001"))
(define meta-borg-oopsla
  (make-bib #:title "Concrete syntax for objects: domain-specific language embedding and assimilation without restrictions"
            #:author (authors "Martin Bravenboer" "Eelco Visser")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(365 383))
            #:date "2004"))
(define xoc-asplos
  (make-bib #:title "Xoc, an extension-oriented compiler for systems programming"
            #:author (authors "Russ Cox" "Tom Bergan" "Austin T. Clements" "Frans Kaashoek" "Eddie Kohler")
            #:location (proceedings-location "Conf. Architectural Support for Programming Languages and Operating Systems"
                                             #:pages '(244 254))
            #:date "2008"))
(define polyglot-cc
  (make-bib #:title "Polyglot: an extensible compiler framework for Java"
            #:author (authors "Nathaniel Nystrom" "Michael Clarkson" "Andrew Myers")
            #:location (proceedings-location "Conf. on Compiler Construction"
                                             #:pages '(138 152))
            #:date "2003"))

(define sk:thesis
  (make-bib #:title "Linguistic Reuse"
            #:author "Shriram Krishnamurthi"
            #:date "2001"
            #:is-book? #t
            #:location (dissertation-location #:institution "Rice University")))

(define ciao-overview
  (make-bib #:title "An overview of the Ciao multiparadigm language and program development environment and its design philosophy"
            #:author (authors "Manuel V. Hermenegildo" "Francisco Bueno"
                              "Carro, Manuel"  "Pedro L´opez"  "José F. Morales" "German Puebla")
            #:location @(compose splice list){In @emph{Concurrency, Graphs and Models}. Springer-Verlag, pp. 209--237}
	    
            #:date "2008"))

#|
@incollection{Hermenegildo:2008:OCM:1424922.1424939,
 author = {Hermenegildo, Manuel V. and Bueno, Francisco and Carro, Manuel and L\'{o}pez, Pedro and Morales, Jos\'{e} F. and Puebla, German},
 chapter = {An Overview of the Ciao Multiparadigm Language and Program Development Environment and Its Design Philosophy},
 title = {Concurrency, Graphs and Models},
 editor = {Degano, Pierpaolo and Nicola, Rocco and Meseguer, Jos\'{e}},
 year = {2008},
 isbn = {978-3-540-68676-7},
 pages = {209--237},
 numpages = {29},
 url = {http://dx.doi.org/10.1007/978-3-540-68679-8_14},
 doi = {http://dx.doi.org/10.1007/978-3-540-68679-8_14},
 acmid = {1424939},
 publisher = {Springer-Verlag},
 address = {Berlin, Heidelberg},
}
|#

(define datalog-manual
  (make-bib #:url "http://docs.racket-lang.org/datalog"
            #:author "Jay McCarthy"
            #:date "2010"
            #:title "Datalog Module Language"))

(define growing-a-language
  (make-bib #:location (journal-location "Higher-Order and Symbolic Computation"
                                         #:pages '(221 236)
                                         #:number 3
                                         #:volume 12)
            #:title "Growing a language, Keynote at OOPSLA 1998"
            #:author (author-name "Guy L." "Steele Jr.")
            #:date "1999"))


(define prng
  (make-bib #:location (journal-location "IBM Systems Journal"
                                         #:pages '(136 146)
                                         #:number 2
                                         #:volume 8)
            #:title "A pseudo-random number generator for the System/360"
            #:author (authors (author-name "Peter A. W." "Lewis")
                              (author-name "A. S." "Goodman")
                              (author-name "J. M." "Miller"))
            #:date "1969"))

(define rfc761
  (make-bib #:title "DoD standard Transmission control protocol"
            #:author "Jon Postel"
            #:date "1980"
            #:location "IETF RFC 761"))
;; @misc{rfc761,
;;   author="J. Postel",
;;   title="{DoD standard Transmission Control Protocol}",
;;   series="Request for Comments",
;;   number="761",
;;   howpublished="RFC 761",
;;   publisher="IETF",
;;   organization="Internet Engineering Task Force",
;;   year=1980,
;;   month=jan,
;;     url="http://www.ietf.org/rfc/rfc761.txt",
;; }
(define rfc4251
  (make-bib #:title "The Secure Shell (SSH) protocol architecture"
            #:author (authors "Tatu Ylönen" "Chris Lonvick")
            #:date "2006"
            #:location "IETF RFC 4251"))
(define rfc1035
  (make-bib #:title "Domain names---implementation and specification"
            #:author (author-name "Paul V." "Mockapteris")
            #:date "1987"
            #:location "IETF RFC 1035"))

(define haskell-numeric-prelude
  (make-bib #:title "Numeric prelude"
            #:author (authors (author-name "Henning" "Thielemann")
                              (author-name "Dylan" "Thurston")
                              (author-name "Mikael" "Johansson"))
            #:location "Haskell Communities and Activities Report"
            #:date "2008"))
(define habit-report
  (make-bib #:title "The Habit programming language: the revised preliminary report"
            #:author "Mark P. Jones"
            #:date "2010"))

(define coppo-intersection
  (make-bib #:title "A new type assignment for λ-terms"
            #:author (authors "Mario Coppo" "Mariangiola Dezani-Ciancaglini")
            #:date "1978"
            #:location (journal-location "Archiv Math. Logik"
                                         #:pages '(139 156)
                                         #:volume 19)))
(define reynolds-forsythe
  (make-bib #:title "Preliminary design of the programming language Forsythe"
            #:author (author-name "John C." "Reynolds")
            #:date "1988"
            #:location "Technical report CMU-CS-88-159, Carnegie-Mellon University"))
(define pierce-union
  (make-bib #:title "Union types for semistructured data"
            #:author (authors "Peter Buneman" "Benjamin Pierce")
            #:date "1999"
            #:location (proceedings-location "Works. on Database Programming Languages"
                                             #:pages '(184 207))))

(define knuth-empirical-fortran
  (make-bib #:title "An empirical study of FORTRAN programs"
            #:author (author-name "Donald E." "Knuth")
            #:date "1971"
            #:location (journal-location "Software---Practice and Experience"
                                         #:pages '(105 133)
                                         #:volume 1)))

(define flanagan-spidey
  (make-bib #:title "Catching bugs in the web of program invariants"
            #:author (authors "Cormac Flanagan"
                              "Matthew Flatt"
                              "Shriram Krishnamurthi"
                              "Stephanie Weirich"
                              "Matthias Felleisen")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation"
                                             #:pages '(23 32))
            #:date "1996"))

(define fcffksf:drscheme
  (make-bib #:title "DrScheme: a programming environment for Scheme"
            #:author (authors "Robert Bruce Findler"
                              "John Clements"
                              "Cormac Flanagan"
                              "Matthew Flatt"
                              "Shriram Krishnamurthi"
                              "Paul Steckler"
                              "Matthias Felleisen")
            #:location (journal-location jfp #:pages '(159 182) #:volume "12" #:number "2")
            #:date 2002))

(define high-performance-js
  (make-bib #:title "High Performance JavaScript"
            #:author (author-name "Nicholas C." "Zakas")
            #:is-book? #t
            #:date "2010"
            #:location (book-location #:publisher "O'Reilly")))
(define agner-opt
  (make-bib #:title "Software optimization resources"
            #:author "Agner Fog"
            #:url "http://www.agner.org/optimize/"
            #:date "2012"))
(define gcc-definitive-guide
  (make-bib #:title "The Definitive Guide to GCC"
            #:author "William von Hagen"
            #:is-book? #t
            #:date "2006"
            #:location (book-location #:publisher "Apress")))

(define stepper
  (make-bib #:title "Modeling an algebraic stepper"
            #:author (authors "John Clements" "Matthew Flatt"
                              "Matthias Felleisen")
            #:location (proceedings-location "European Symp. on Programming"
                                             #:pages '(320 334))
            #:date "2001"))
(define cont-marks-web-server
  (make-bib #:title "Continuations from generalized stack inspection"
            #:author (authors "Greg Pettyjohn" "John Clements" "Joe Marshall"
                              "Shriram Krishnamurthi" "Matthias Felleisen")
            #:location (proceedings-location "International Conf. on Functional Programming"
                                             #:pages '(216 227))
            #:date "2005"))
(define clements-diss
  (make-bib #:title "Portable and High-Level Access to the Stack with Continuation Marks"
            #:author "John Clements"
            #:is-book? #t
            #:location (dissertation-location #:institution "Northeastern University")
            #:date "2006"))
(define cont-marks-js
  (make-bib #:title "Implementing continuation marks in JavaScript"
            #:author (authors "John Clements" "Ayswarya Sundaram" "David Herman")
            #:location (proceedings-location "Scheme and Functional Programming Works."
                                             #:pages '(1 10))
            #:date "2008"))

(define ghci-debugger
  (make-bib #:title "A lightweight interactive debugger for Haskell"
            #:author (authors "Simon Marlow" "José Iborra" "Bernard Pope" "Andy Gill")
            #:location (proceedings-location "Haskell Works."
                                             #:pages '(13 24))
            #:date "2007"))


(define serrano-inlining
  (make-bib #:title "Inline expansion: When and how"
            #:author "Manuel Serrano"
            #:location (proceedings-location
                        "International Symp. on Programming Language Implementation and Logic Programming"
                        #:pages '(143 147))
            #:date "1997"))

(define closure-conversion
  (make-bib #:title "Continuation-passing, closure-passing style"
            #:author (authors "Andrew Appel" "Trevor Jim")
            #:location (proceedings-location "Symp. on Principles of Programming Languages"
                                             #:pages '(293 302))
            #:date "1989"))
(define compiling-with-continuations
  (make-bib #:title "Compiling with Continuaitions"
            #:author "Andrew Appel"
            #:is-book? #t
            #:location (book-location #:publisher "Cambridge University Press")
            #:date "1992"))
(define type-based-sml
  (make-bib #:title "A type-based compiler for standard ML"
            #:author (authors "Zhong Shao" "Andrew Appel")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation"
                                             #:pages '(116 129))
            #:date "1995"))


(define kismet
  (make-bib #:title "Kismet: parallel speedup estimates for serial programs"
            #:author (authors "Donghwan Jeon"
                              "Saturnino Garcia"
                              "Chris Louie"
                              "Michael Bedford Taylor")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(519 536))
            #:date "2011"))
(define kremlin
  (make-bib #:title "Kremlin: Rethinking and rebooting gprof for the multicore age"
            #:author (authors "Saturnino Garcia"
                              "Donghwan Jeon"
                              "Chris Louie"
                              "Michael Bedford Taylor")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation"
                                             #:pages '(458 469))
            #:date "2011"))
(define cilkview
  (make-bib
   #:author (authors "Yuxiong He" (author-name "Charles E." "Leiserson") (author-name "William M." "Leiserson"))
   #:title "The Cilkview Scalability Analyzer"
   #:location (proceedings-location "Symp. on Parallelism in Algorithms and Architectures"
                                    #:pages '(145 156))
   #:date 2010))


(define gcc
  (make-bib #:title "GCC 4.7.0 Manual"
            #:date "2012"
            #:is-book? #t
            #:author (org-author-name "The Free Software Foundation")))
(define msvc
  (make-bib #:title "Visual C and C++ 6.0 Programmer's Guide"
            #:date "2012"
            #:is-book? #t
            #:author (org-author-name "Microsoft")))
(define ghc
  (make-bib #:title "The Glorious Glasgow Haskell Compilation System User's Guide, Version 7.4.1"
            #:date "2011"
            #:is-book? #t
            #:author (org-author-name "The GHC Team")))
(define sbcl
  (make-bib #:title "SBCL 1.0.55 User Manual"
            #:date "2012"
            #:is-book? #t
            #:author (org-author-name "The SBCL Team")))
(define lispworks
  (make-bib #:title "LispWorks© 6.1 Documentation"
            #:date "2013"
            #:is-book? #t
            #:author (org-author-name "LispWorks Ltd.")))

(define js-type-inference
  (make-bib #:title "Fast and precise type inference for JavaScript"
            #:author (authors (author-name "Brian" "Hackett")
                              (author-name "Shu-yu" "Guo"))
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation"
                                             #:pages '(239 250))
            #:date "2012"))

(define rule-based-performance-bug-detection
  (make-bib #:title "Understanding and detecting real-world performance bugs"
            #:author (authors "Guoliang Jin" "Linhai Song" "Xiaoming Shi"
                              "Joel Scherpelz" "Shan Lu")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation"
                                             #:pages '(77 88))
            #:date "2012"))


(define perf-pred-pvm
  (make-bib #:title "Performance prediction of PVM programs"
            #:author (authors (author-name "Michael R." "Steed")
                              (author-name "Mark J." "Clement"))
            #:location (proceedings-location "International Parallel Processing Symp."
                                             #:pages '(803 807))
            #:date "1996"))
(define perf-pred-hpf
  (make-bib #:title "Compile-time performance prediction of HPF/Fortran 90D"
            #:author (authors "Manish Parashar" "Salim Hariri")
            #:location (journal-location "IEEE Parallel Distrib. Technol."
                         #:pages '(57 73)
                         #:volume "4" #:number "1")
            #:date "1996"))
(define perf-pred-modern-micro
  (make-bib #:title "Efficient performance prediction for modern microprocessors"
            #:author (authors "David Ofelt" (author-name "John L." "Hennessy"))
            #:location (proceedings-location "International Conf. on Measurement and Modeling of Computer Systems"
                                             #:pages '(229 239))
            #:date "2000"))

(define soot-eclipse-thesis
  (make-bib #:title "Visualisation Tools for Optimizing Compilers"
            #:author (author-name "Jennifer Elizabeth" "Shaw")
            #:is-book? #t
            #:location (dissertation-location #:institution "McGill University"
                                              #:degree "MS")
            #:date "2005"))
(define soot-eclipse-cc
  (make-bib #:title "Integrating the Soot compiler infrastructure into an IDE"
            #:author (authors "Jennifer Lhoták" "Ondřej Lhoták" (author-name "Laurie J." "Hendren"))
            #:location (proceedings-location "Conf. on Compiler Construction"
                                             #:pages '(281 297))
            #:date "2004"))

(define soot
  (make-bib #:title "Optimizing Java bytecode using the Soot framework: is it feasible?"
            #:author (authors "Raja Vallée-Rai" "Etienne Gagnon" (author-name "Laurie J." "Hendren") "Patrick Lam" "Patrice Pominville" "Vijay Sundaresan")
            #:location (proceedings-location "Conf. on Compiler Construction"
                                             #:pages '(18 34))
            #:date "2000"))
(define soot-bounds-check
  (make-bib #:title "A comprehensive approach to array bounds check elimination for Java"
            #:author (authors "Feng Qian" (author-name "Laurie J." "Hendren")
                              "Clark Verbrugge")
            #:location (proceedings-location "Conf. on Compiler Construction"
                                             #:pages '(325 342))
            #:date "2002"))


(define frances
  (make-bib #:title "Frances: A Tool for Understanding Code Generation"
            #:author (authors "Tyler Sondag" (author-name "Kian L." "Pokorny") "Hridesh Rajan")
            #:location (proceedings-location "Symp. on Computer Science Education"
                                             #:pages '(12 16))
            #:date "2010"))
(define feedback-compiler
  (make-bib #:title "The FeedBack compiler"
            #:author (authors "David Binkley" "Bruce Duncan" "Brennan Jubb" "April Wielgosz")
            #:location (proceedings-location "International Works. on Program Comprehension"
                                             #:pages '(198 206))
            #:date "1998"))

(define lcc
  (make-bib #:title "A Retargetable C Compiler: Design and Implementation"
            #:author (authors (author-name "Christopher W." "Fraser")
                              (author-name "David R." "Hanson"))
            #:location (book-location #:publisher "Addison-Wesley")
            #:is-book? #t
            #:date "1995"))

(define loop-skewing
  (make-bib #:title "Loop skewing: The wavefront method revisited"
            #:author "Michael Wolfe"
            #:location (journal-location "J. of Parallel Programming"
                                         #:pages '(279 293)
                                         #:volume "15" #:number "4")
            #:date "1986"))

(define dean95
  (make-bib #:title "Optimization of object-oriented programs using static class hierarchy analysis"
            #:author (authors "Jeffrey Dean" "David Grove" "Craig Chambers")
            #:location (proceedings-location "European Conf. on Object-Oriented Programming"
                                             #:pages '(77 101))
            #:date "1995"))
(define leroy92
  (make-bib #:title "Unboxed objects and polymorphic typing"
            #:author "Xavier Leroy"
            #:location (proceedings-location "Symp. on Principles of Programming Languages"
                                             #:pages '(177 188))
            #:date "1992"))
(define til
  (make-bib #:title "TIL: a type-directed optimizing compiler for ML"
            #:author (authors "David Tarditi" "Greg Morrisett" "Perry Cheng"
                              "Chris Stone" "Robert Harper" "Peter Lee")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation"
                                             #:pages '(181 192))
            #:date "1996"))

(define muchnick
  (make-bib #:title "Advanced Compiler Design and Implementation"
            #:author (author-name "Stephen S." "Muchnick")
            #:location (book-location #:publisher "Morgan-Kaufmann")
            #:is-book? #t
            #:date "1997"))

(define perf-idle-programs
  (make-bib #:title "Performance analysis of idle programs"
            #:author (authors "Erik Altman" "Matthew Arnold" "Stephen Fink"
                              "Nick Mitchell")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(739 753))
            #:date "2010"))

(define perf-bug-detection
  (make-bib #:title "Catch me of you can: performance bug detection in the wild"
            #:author (authors "Milan Jovic" "Andrea Adamoli" "Matthias Hauswirth")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(155 170))
            #:date "2011"))
(define listener-latency-profiling
  (make-bib #:title "Listener latency profiling: Measuring the perceptible performance of interactive Java applications"
            #:author (authors "Milan Jovic" "Matthias Hauswirth")
            #:location (journal-location "Science of Computer Programming"
                                         #:pages '(1054 1072)
                                         #:number "4"
                                         #:volume "19")
            #:date "2011"))
(define accuracy-java-profilers
  (make-bib #:title "Evaluating the accuracy of Java profilers"
            #:author (authors "Todd Mytkowicz" "Amer Diwan" "Matthias Hauswirth"
                              (author-name "Peter F." "Sweeney"))
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation"
                                             #:pages '(187 197))
            #:date "2010"))

(define augmenting-with-dynamic-metrics
  (make-bib #:title "Augmenting static source views in IDEs with dynamic metrics"
            #:author (authors "David Röthlisberger" "Marcel Härry"
                              "Alex Villazón" "Danilo Ansaloni"
                              "Walter Binder" "Oscar Nierstrasz"
                              "Philippe Moret")
            #:location (proceedings-location "International Conf. on Software Maintenance"
                                             #:pages '(253 262))
            #:date "2009"))
(define bottlenecks-large-systems
  (make-bib #:title "Finding and removing performance bottlenecks in large systems"
            #:author (authors "Glenn Ammons" "Jong-Deok Choi"
                              "Manish Gupta" "Nikhil Swamy")
            #:location (proceedings-location "European Conf. on Object-Oriented Programming"
                                             #:pages '(172 196))
            #:date "2004"))

(define interprocedural-pre
  (make-bib #:title "Interprocedural partial redundancy elimination and its application to distributed memory computation"
            #:author (authors "Gagan Agrawal" "Joel Saltz" "Raja Das")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation"
                                             #:pages '(258 269))
            #:date "1995"))
(define parameters-scsh
  (make-bib #:title "Integrating user-level threads with processes in SCSH"
            #:author (authors "Martin Gasbichler" "Michael Sperber")
            ;; #:location (proceedings-location "Works. Scheme and Functional Programming"
            ;;                                  #:pages '(1 7))
            #:location (journal-location "Higher-Order and Symbolic Computing"
                                         #:pages '(327 354)
                                         #:number "3-4"
                                         #:volume "18")
            #:date "2005")) ;; Racket docs point to scheme workshop version

(define profile-guided-optimization-survey
  (make-bib
   #:title "Profile guided compiler optimizations"
   #:author (authors "Rajiv Gupta" "Eduard Mehofer" "Youtao Zhang")
   #:location (let* ([s @elem{In @italic{The compiler design handbook: optimizations and machine code generation}}]
                     [s @elem{@|s|, pp. 143--174}]
                     [s @elem{@|s|. CRC Press}])
    s)
   #:date "2002"
   ))

(define ferrari-profile
  (make-bib
   #:title "Improving locality by critical working sets"
   #:author "Domenico Ferrari"
   #:is-book? #f
   #:location "Communications of the ACM, 17(11):614-620"
   #:date "1974"))
(define vaswani-ppp
  (make-bib
   #:title "Preferential path profiling: compactly numbering interesting paths"
   #:author (authors "Kapil Vaswani" "Aditya V. Nori" "Trishul M. Chilimbi")
   #:location (proceedings-location "Symp. Principles of Programming Languages")
   #:date "2007"))

(define next-in-line
  (make-bib
   #:title "Next in line, please!"
   #:author (authors "Andreas Sewe" "Jannik Jochem" "Mira Mezini")
   #:location (proceedings-location "Works. on Virtual Machines and Intermediate Languages"
                                    #:pages '(317 328))
   #:date "2011"))

(define laziness-by-need
  (make-bib
   #:title "Laziness by need"
   #:author "Stephen Chang"
   #:location (proceedings-location "European Symp. on Programming"
                                    #:pages '(81 100))
   #:date 2013))
(define lazy-profile
  (make-bib
   #:title "Profiling for laziness"
   #:author (authors "Stephen Chang" "Matthias Felleisen")
   #:location (proceedings-location "Symp. on Principles of Programming Languages" #:pages '(349 360))
   #:date "2014"))

(define parascope
  (make-bib
   #:title "The ParaScope parallel programming environment"
   #:author (authors (author-name "Keith D." "Cooper") (author-name "Mary W." "Hall")
                     (author-name "Robert T." "Hood") (author-name "Ken" "Kennedy")
                     (author-name "Kathryn S." "McKinley") (author-name "John M." "Mellor-Crummey")
                     (author-name "Linda" "Torczon") (author-name "Scott K." "Warren"))
   #:location (journal-location "Proc. of the IEEE"
                                #:volume "81"
                                #:number "2"
                                #:pages '(244 263))
   #:date "1993"))
(define hermit
  (make-bib
   #:title "The HERMIT in the machine"
   #:author (authors "Andrew Farmer" "Andy Gill" "Ed Komp" "Neil Schulthorpe")
   #:location (proceedings-location "Haskell Symp."
                                    #:pages '(1 12))
   #:date "2012"))
(define larsen-ieee
  (make-bib
   #:title "Parallelizing more loops with compiler guided refactoring"
   #:author (authors "Per Larsen" "Razya Ladelsky" "Jacob Lidman"
                     (author-name "Sally A." "McKee") "Sven Karlsson"
                     "Ayal Zaks")
   #:location (proceedings-location "International Conf. on Parallel Processing"
                                    #:pages '(410 419))
   #:date "2012"))
(define cray-performance-tools
  (make-bib
   #:title "Cray XMT™ Performance Tools User's Guide"
   #:author (org-author-name "Cray inc.")
   #:is-book? #t
   #:date "2011"))

(define christos-diss
  (make-bib #:title "Foundations for Behavioral Higher-Order Contracts"
            #:author "Christos Dimoulas"
            #:is-book? #t
            #:location (dissertation-location #:institution "Northeastern University")
            #:date "2012"))
(define option-contracts
  (make-bib #:title "Option Contracts"
            #:author (authors "Christos Dimoulas"
                              (author-name "Robert Bruce" "Findler")
                              "Matthias Felleisen")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(475 494))
            #:date "2013"))

(define network-calculus
  (make-bib #:title "The network as a language construct"
            #:author (authors "Tony Garnock-Jones" "Sam Tobin-Hochstadt"
                              "Matthias Felleisen")
            #:location (proceedings-location "European Symp. on Programming"
                                             #:pages '(473 492))
            #:date "2014"))

(define match-paper-arxiv
  (make-bib #:title "Extensible pattern matching in an extensible language"
            #:author "Sam Tobin-Hochstadt"
            #:location @elem{@tt{arXiv:1106.2578 [cs.PL]}}
            #:is-book? #f
            #:date "2011"))

(define eiffel
  (make-bib #:title "Eiffel: The Language"
            #:author "Bertrand Meyer"
            #:is-book? #t
            #:location (book-location #:publisher "Prentice Hall")
            #:date "1992"))

(define class-contracts
  (make-bib #:title "Contracts for first-class classes"
            #:author (authors (author-name "T. Stephen" "Strickland")
                              "Matthias Felleisen")
            #:location (proceedings-location "Dynamic Languages Symp."
                                             #:pages '(97 112))
            #:date "2010"))
(define stff:chaperons
  (make-bib #:title "Chaperones and impersonators: run-time support for reasonable interposition"
            #:author (authors (author-name "T. Stephen" "Strickland")
                              "Sam Tobin-Hochstadt"
                              (author-name "Robert Bruce" "Findler")
                              "Matthew Flatt")
            #:location (proceedings-location oopsla #:pages '(943 962))
            #:date "2012"))

(define valgrind
  (make-bib #:title "Valgrind: A framework for heavyweight dynamic binary instrumentation"
            #:author (authors "Nicholas Nethercote" "Julian Seward")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation"
                                             #:pages '(89 100))
            #:date "2007"))
(define pin-binary-instrumentation
  (make-bib #:title "Pinpointing representative portions of large Intel® Itanium® programs with dynamic instrumentation"
            #:author (authors "Harish Patil" "Robert Cohn" "Mark Charney" "Rajiv Kapoor"
                              "Andrew Sun" "Anand Karunanidhi")
            #:location (proceedings-location "Symp. on Microarchitecture"
                                             #:pages '(81 92))
            #:date "2004"))
(define atom-analysis-framework
  (make-bib #:title "ATOM: a system for building customized program analysis tools"
            #:author (authors "Amitabh Srivastava" "Alan Eustace")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation"
                                             #:pages '(196 205))
            #:date "1994"))
(define javana
  (make-bib #:title "Javana: A system for building customized Java program analysis tools"
            #:author (authors "Jonas Maebe" "Dries Buytaert" "Lieven Eeckhout"
                              (author-name "Koen" "De Bosschere"))
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(153 168))
            #:date "2006"))
(define vertical-profiling
  (make-bib #:title "Vertical profiling: Understanding the behavior of object-oriented applications"
            #:author (authors "Matthias Hauswirth" (author-name "Peter F." "Sweeney")
                              "Amer Diwan" "Michael Hind")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(251 269))
            #:date "2004"))
(define feature-profiling
  (make-bib #:title "Feature profiling for evolving systems"
            #:author (authors "Elmar Juergens" "Martin Feilkas"
                              "Markus Herrmannsdoerfer" "Florian Deissenboeck"
                              "Rudolf Vaas" "Karl-Heinz Prommer")
            #:location (proceedings-location "Intl. Conf. on Program Comprehension"
                                             #:pages '(171 180))
            #:date "2011"))
(define concept-profiling
  (make-bib #:title "Dynamic analysis of Java program concepts for visualization and profiling"
            #:author (authors "Jeremy Singer" "Chris Kirkham")
            #:location (journal-location "Science of Computer Programming"
                                         #:pages '(111 126)
                                         #:number "2-3"
                                         #:volume "70")
            #:date "2008"))
(define concepts
  (make-bib #:title "Program understanding and the concept assignment problem"
            #:author (authors (author-name "Ted J." "Biggerstaff")
                              (author-name "Bharat G." "Mitbander")
                              (author-name "Dallas E." "Webster"))
            #:location (journal-location "Commun. ACM"
                                         #:pages '(72 82)
                                         #:volume "37"
                                         #:number "5")
            #:date "1994"))

(define gprof
  (make-bib #:title "Gprof: a call graph execution profiler"
            #:author (authors (author-name "Susan L." "Graham")
                              (author-name "Peter B." "Kessler")
                              (author-name "Marshall K." "McKusick"))
            #:location (proceedings-location "Symp. on Compiler Construction"
                                             #:pages '(120 126))
            #:date "1982"
            ))
(define ghc-profiler
  (make-bib #:title "Time and space profiling for non-strict, higher-order functional languages"
            #:author (authors (author-name "Patrick M." "Sansom")
                              (author-name "Simon L." "Peyton Jones"))
            #:location (proceedings-location "Symp. on Principles of Programming Languages"
                                             #:pages '(355 366))
            #:date "1995"))
(define jikes
  (make-bib #:title "The Jikes research virtual machine project: building an open-source research community"
            #:author (authors "Bowen Alpern" "Steven Augart" (author-name "Stephen M." "Blackburn")
                              "Maria Butrico" "Anthony Cocchi" "Perry Cheng"
                              "Julian Dolby" "Stephen Fink" "David Grove"
                              "Michael Hind" (author-name "Kathryn S." "McKinley")
                              "Mark Mergen" (author-name "J. Eliot B." "Moss")
                              "Ton Ngo" "Vivek Sarkar" "Martin Trapp")
            #:location (journal-location "IBM Systems Journal"
                                         #:pages '(399 417)
                                         #:number 2
                                         #:volume 44)
            #:date "2005"))

(define db-profiling
  (make-bib #:title "Understanding the behavior of database operations under program control"
            #:author (authors (author-name "Juan M." "Tamayo") "Alex Aiken"
                              "Nathan Bronson" "Mooly Sagiv")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications"
                                             #:pages '(983 996))
            #:date "2012"))

(define storage-strategies
  (make-bib #:title "Storage strategies for collections in dynamically typed languages"
            #:author (authors (author-name "Carl Friedrich" "Bolz")
                              "Lukas Diekmann" "Laurence Tratt")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications" #:pages '(167 182))
            #:date "2013"))
(define jit-unfriendly
  (make-bib #:title "JITProf: Pinpointing JIT-unfriendly JavaScript code"
            #:author (authors "Liang Gong" "Michael Pradel" "Koushik Sen")
            #:location (techrpt-location #:institution "University of California at Berkeley"
                                         #:number "UCB/EECS-2014-144")
            #:date "2014"))

(define es-5.1
  (make-bib #:title "ECMAScript® Language Specification"
            #:author (org-author-name "ECMA International")
            #:location "Standard ECMA-262"
            #:is-book? #t
            #:date "2011"))

(define self-type-feedback-pldi
  (make-bib #:title "Iterative type analysis and extended message splitting"
            #:author (authors "Craig Chambers" "David Ungar")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation" #:pages '(150 164))
            #:date "1990"))
(define self-type-feedback
  (make-bib #:title "Iterative type analysis and extended message splitting"
            #:author (authors "Craig Chambers" "David Ungar")
            #:location (journal-location "Lisp and Symbolic Computation"
                                         #:pages '(283 310)
                                         #:number "3"
                                         #:volume "4")
            #:date "1990"))
(define self-jit
  (make-bib #:title "An efficient implementation of SELF" ; , a dynamically-typed object-oriented language based on prototypes
            #:author (authors "Craig Chambers" "David Ungar" "Elgin Lee")
            #:location (proceedings-location "Conf. Object-Oriented Programming Systems, Languages, and Applications" #:pages '(49 70))
            #:date "1989"))
(define self-deoptimization
  (make-bib #:title "Debugging optimized code with dynamic deoptimization"
            #:author (authors "Urs Hölzle" "Craig Chambers" "David Ungar")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation" #:pages '(32 43))
            #:date "1992"))
(define self-pic
  (make-bib #:title "Optimizing dynamically-typed object-oriented languages with polymorphic inline caches"
            #:author (authors "Urs Hölzle" "Craig Chambers" "David Ungar")
            #:location (proceedings-location "European Conf. on Object-Oriented Programming" #:pages '(21 38))
            #:date "1991"))

(define ssa
  (make-bib #:title "Efficiently computing static single assignment form and the control dependence graph"
            #:author (authors "Ron Cytron" "Jeanne Ferrante"
                              (author-name "Barry K." "Rosen")
                              (author-name "Mark N." "Wegman")
                              (author-name "F. Kenneth" "Zadeck"))
            #:location (journal-location "Transactions of Programming Languages and Systems"
                                         #:pages '(451 490)
                                         #:number "4"
                                         #:volume "13")
            #:date "1991"))

(define spidermonkey
  (make-bib #:title "SpiderMonkey 24 Documentation"
            #:date "2013"
            #:is-book? #t
            #:author (org-author-name "Mozilla Developer Network")
            #:url "https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey"))
(define v8
  (make-bib #:title "V8 Documentation"
            #:date "2012"
            #:is-book? #t
            #:author (org-author-name "Google Inc.")
            #:url "https://developers.google.com/v8/intro"))
(define jsc
  (make-bib #:title "JavaScriptCore Documentation"
            #:date "2014"
            #:is-book? #t
            #:author (org-author-name "Apple Inc.")
            #:url "https://www.webkit.org/projects/javascript/"))
;; (define chakra
;;   (make-bib #:title "The new JavaScript engine in Internet Explorer 9"
;;             #:date "2010"
;;             #:is-book? #f
;;             #:author "Shanku Niyogi"
;;             #:url "http://blogs.msdn.com/b/ie/archive/2010/03/18/the-new-javascript-engine-in-internet-explorer-9.aspx"))
(define chakra ; best I could find
  (make-bib #:title "JavaScript"
            #:date "2014"
            #:is-book? #t
            #:author (org-author-name "Microsoft")
            #:url "http://msdn.microsoft.com/en-us/library/aa902517.aspx"))
(define irhydra
  (make-bib #:title "IRHydra Documentation"
            #:date "2014"
            #:is-book? #t
            #:author "Vyacheslav Egorov"
            #:url "http://mrale.ph/irhydra/"))
(define jit-inspector
  (make-bib #:title "JIT Inspector Add-on for Firefox"
            #:date "2013"
            #:is-book? #t
            #:author "Brian Hackett"
            #:url "https://addons.mozilla.org/en-US/firefox/addon/jit-inspector/"))


;; auto-tuning stuff
(define atlas
  (make-bib #:title "Automatically tuned linear algebra software"
            #:author (authors (author-name "R. Clint" "Whaley")
                              (author-name "Jack J." "Dongarra"))
            #:location (proceedings-location "High Performance Networking and Computing"
                                             #:pages '(1 27))
            #:date "1998"))
(define spiral
  (make-bib #:title "Spiral: A generator for platform-adapted libraries of signal processing applications"
            #:author (authors "Markus Püschel"
                              (author-name "José M. F." "Moura")
                              "Bryan Singer" "Jianxin Xiong" "Jeremy Johnson"
                              "David Padua" "Manuela Veloso"
                              (author-name "Robert W." "Johnson"))
            #:location (journal-location "J. of High Performance Computing Applications"
                                         #:pages '(21 45)
                                         #:number "1"
                                         #:volume "18")
            #:date "2004"))
(define fftw
  (make-bib #:title "The design and implementation of FFTW3"
            #:author (authors "Matteo Frigo" (author-name "Steven G." "Johnson"))
            #:location (journal-location "Proc. of the IEEE, Special issue on ``Program Generation, Optimization, and Platform Adaptation''"
                                         #:pages '(216 231)
                                         #:number "2"
                                         #:volume "93")
            #:date "2005"))


(define barbara-steele-ms
  (make-bib #:title "An Accountable Source-to-Source Transformation System"
            #:author (author-name "Barbara Sue Kerne" "Steele")
            #:is-book? #t
            #:location (dissertation-location #:institution "Massachusetts Institute of Technology"
                                              #:degree "MS")
            #:date "1981"))
(define dylan-ide
  (make-bib #:title "Getting Started with the Open Dylan IDE"
            #:author (org-author-name "Dylan Hackers")
            #:is-book? #t
            #:url "http://opendylan.org/documentation/getting-started-ide/GettingStartedWithTheOpenDylanIDE.pdf"
            #:date "2015"))

(define precimonious
  (make-bib #:title "Precimonious: Tuning assistant for floating-point precision"
            #:author (authors "Cindy Rubio-González" "Cuong Nguyen"
                              (author-name "Hong Diep" "Nguyen")
                              "James Demmel" "William Kahan" "Koushik Sen"
                              (author-name "David H." "Bailey") "Costin Iancu"
                              "David Hough")
            #:location (proceedings-location "Conf. for High Performance Computing, Networking, Storage and Analysis" #:pages '(1 12))
            #:date "2013"))
(define orm-anti-patterns
  (make-bib #:title "Detecting performance anti-patterns for applications developed using object-relational mapping"
            #:author (authors "Tse-Hun Chen" "Weiyi Shang"
                              (author-name "Zhen Ming" "Jiang")
                              (author-name "Ahmed E." "Hassan")
                              "Mohammed Nasser" "Parminder Flora")
            #:location (proceedings-location "International Conf. on Software Engineering" #:pages '(1001 1012))
            #:date "2014"))


;; refactoring tools
(define pr-miner ; not actually a refactoring tool
  (make-bib #:title "PR-Miner: Automatically extracting implicit programming rules and detecting violations in large software code"
            #:author (authors "Zhenmin Li" "Yuanyuan Zhou")
            #:location (proceedings-location "ESEC/FSE"
                                             #:pages '(306 315))
            #:date "2005"))
(define relooper
  (make-bib #:title "ReLooper: Refactoring for loop parallelism"
            #:author (authors "Danny Dig" "Cosmin Radoi" "Mihai Tarce"
                              "Marius Minea" "Ralph Johnson")
            #:location (techrpt-location #:institution "University of Illinois"
                                         #:number "2142/14536")
            #:date "2009"
            ;; #:url "http://hdl.handle.net/2142/14536"
            ))
(define mapo
  (make-bib #:title "MAPO: Mining and recommending API usage pattterns"
            #:author (authors "Hao Zhong" "Tao Xie" "Lu Zhang" "Jian Pei" "Hong Mei")
            #:location (proceedings-location "European Conf. on Object-Oriented Programming" #:pages '(318 343))
            #:date "2009"))
(define strathcona
  (make-bib #:title "Using structural context to recommend source code examples"
            #:author (authors "Reid Holmes" (author-name "Gail C." "Murphy"))
            #:location (proceedings-location "International Conf. on Software Engineering" #:pages '(117 125))
            #:date "2005"))
(define fixmeup
  (make-bib #:title "Fix me up: Repairing access-control bugs in web applications"
            #:author (authors "Sooel Son" (author-name "Kathryn S." "McKinley")
                              "Vitaly Shmatikov")
            #:location (proceedings-location "Symp. on Network and Distributed System Security") ; can't find page numbers
            #:date "2013"))
(define nongpong-diss ; http://dc.uwm.edu/etd/13/
  (make-bib #:title "Integrating \"Code Smells\" Detection with Refactoring Tool Support"
            #:author "Kwankamol Nongpong"
            #:is-book? #t
            #:location (dissertation-location
                        #:institution "University of Wisconsin-Milwaukee")
            #:date "2012"))


(define suif-explorer
  (make-bib #:title "SUIF Explorer: An interactive and interprocedural parallelizer"
            #:author (authors "Shih-Wei Liao" "Amer Diwan"
                              (author-name "Robert P." "Bosch Jr.")
                              "Anwar Ghuloum" (author-name "Monica S." "Lam"))
            #:location (proceedings-location "Symp. on Principles and Practice of Parallel Programming" #:pages '(37 48))
            #:date "1999"))
(define slicing
  (make-bib #:title "Program slicing"
            #:author "Mark Weiser"
            #:location (proceedings-location "International Conf. on Software Engineering" #:pages '(439 449))
            #:date "1981"))
(define vista
  (make-bib #:title "VISTA: A system for interactive code improvement"
            #:author (authors "Wankang Zhao" "Baosheng Cai" "David Whalley"
                              (author-name "Mark W." "Bailey")
                              (author-name "Robert" "van Engelen")
                              "Xin Yuan" (author-name "Jason D." "Hiser")
                              (author-name "Jack W." "Davidson")
                              "Kyle Gallivan" (author-name "Douglas L." "Jones"))
            #:location (proceedings-location "Languages, Compilers, and Tools for Embedded Systems and Software and Compilers for Embedded Systems" #:pages '(155 164))
            #:date "2002"))

(define evaluating-R
  (make-bib #:title "Evaluating the design of the R language"
            #:author (authors "Floréal Morandat" "Brandon Hill" "Leo Osvald" "Jan Vitek")
            #:location (proceedings-location "European Conf. on Object-Oriented Programming" #:pages '(104 131))
            #:date "2012"))

(define fsp
  (make-bib #:title "Feature-specific profiling"
            #:author (authors "Vincent St-Amour" "Leif Andersen" "Matthias Felleisen")
            #:location (proceedings-location "Conf. on Compiler Construction"
                                             #:pages '(49 68))
            #:date "2015"))

(define low-utility-data-structures
  (make-bib #:title "Finding low-utility data structures"
            #:author (authors "Guoqing Xu" "Nick Mitchell" "Matthew Arnold"
                              "Atanas Rountev" "Edith Schonberg" "Gary Sevitsky")
            #:location (proceedings-location "Conf. on Programming Language Design and Implementation" #:pages '(174 186))
            #:date "2010"))

(define asumu:typed-impl
  (make-bib #:title "Towards practical gradual typing"
            #:author (authors "Asumu Takikawa" "Daniel Feltey" "Earl Dean"
                              (author-name "Robert Bruce" "Findler")
                              "Matthew Flatt" "Sam Tobin-Hochstadt"
                              "Matthias Felleisen")
            #:location (proceedings-location ecoop)
	    #:note "to appear"
            #:date "2015"))


(define kde-domain-specific-debugging
  (make-bib #:title "Domain specific debugging tools"
            #:author "Volker Krause"
            #:location "Qt Developer Days"
            #:date "2012"
            #:url "http://www.kdab.com/~volker/devdays/2012/QtDD2012-DomainSpecificDebuggingTools.pdf"))
(define moldable-debugging
  (make-bib #:title "The moldable debugger: A framework for developing domain-specific debuggers"
            #:author (authors "Andrei Chiş" "Tudor Gîrba" "Oscar Nierstrasz")
            #:location (proceedings-location "Conf. on Software Language Engineering" #:pages '(102 121))
            #:date "2014"))

(define shill
  (make-bib #:title "SHILL: a secure shell scripting language"
            #:author (authors "Scott Moore" "Christos Dimoulas" "Dan King" "Stephen Chong")
            #:location (proceedings-location "SOSP"
			 ; "Symp. on Operating Systems Design and Implementation"
                                             #:pages '(183 199))
            #:date "2014"))

(define lambda-lifting
  (make-bib #:title "Lambda lifting: Transforming programs to recursive equations"
            #:author "Thomas Johnsson"
            #:location (proceedings-location "Functional Programming Languages and Computer Architecture"
                                             #:pages '(190 203))
            #:date "1985"))

;; -----------------------------------------------------------------------------
;; from Asumu

(define ffkf:mred 
  (make-bib
   #:author (authors "Matthew Flatt" "Robert Bruce Findler"
                     "Shriram Krishnamurthi" "Matthias Felleisen")
   #:title "Programming languages as operating systems (or revenge of the son of the Lisp machine)"
   #:location (proceedings-location icfp #:pages '(138 147))
   #:date 1999))

(define ff:kill-safe
  (make-bib
   #:author (authors "Matthew Flatt" "Robert Bruce Findler")
   #:title "Kill-safe synchronization abstractions"
   #:location (proceedings-location pldi #:pages '(47 58))
   #:date "2004"))

(define redex
  (make-bib
    #:author (authors "Matthias Felleisen" "Robert Bruce Findler" "Matthew Flatt")
    #:title "Semantics Engineering with PLT Redex"
    #:location (book-location #:publisher "MIT Press")
    #:is-book? #t
    #:date "2010"))

(define ass:sicp
  (make-bib
    #:author (authors "Harold Abelson" "Gerald Jay Sussman" "Julie Sussman")
    #:title "Structure and Interpretation of Computer Programs"
    #:location (book-location #:publisher "MIT Press")
    #:is-book? #t
    #:date "1985"))

(define fffk:htdp
  (make-bib
    #:author (authors "Matthias Felleisen" "Robert Bruce Findler" "Matthew Flatt" "Shriram Krishnamurthi")
    #:title "How to Design Programs"
    #:location (book-location #:publisher "MIT Press")
    #:is-book? #t
    #:date 2001))

(define mf:interop
  (make-bib
   #:title "Operational semantics for multi-language programs"
   #:author (authors "Jacob Matthews" "Robert Bruce Findler")
   #:date "2009"
   #:location
   (journal-location a:toplas
     #:volume 31
     #:number 3
     #:pages '("12:1" "12:44"))))

(define asumu:typed-classes
  (make-bib
   #:author (authors "Asumu Takikawa" "T. Stephen Strickland"
                     "Christos Dimoulas" "Sam Tobin-Hochstadt"
                     "Matthias Felleisen")
   #:title "Gradual typing for first-class classes"
   #:location (proceedings-location oopsla #:pages '(793 810))
   #:date 2012))

(define ff:slideshow
  (make-bib
   #:title "Slideshow: functional presentations"
   #:author (authors "Robert Bruce Findler" "Matthew Flatt")
   #:location (journal-location jfp #:volume 16 #:number "4-5")
   #:date 2006))

(define sf:contracts-modules
  (make-bib
    #:author (authors "T. Stephen Strickland" "Matthias Felleisen")
    #:title "Contracts for first-class modules"
    #:location (proceedings-location dls  #:pages '(27 38))
    #:date 2009))

(define fffk:htdp-vs-sicp
  (make-bib
    #:author (authors "Matthias Felleisen" "Robert Bruce Findler" "Matthew Flatt" "Shriram Krishnamurthi")
    #:title "The structure and interpretation of the computer science curriculum"
    #:location (journal-location jfp #:volume 14 #:number 4  #:pages '(365 378))
    #:date 2004))

(define kfd:macro-to-gen-prog
  (make-bib
    #:title "From macros to reusable generative programming"
    #:author (authors "Shriram Krishnamurthi" "Matthias Felleisen" "Bruce F. Duba")
    #:location (proceedings-location gpce #:pages '(105 120))
    #:date "1999"))

(define ck:frtime
  (make-bib
    #:title "Embedding dynamic dataflow in a call-by-value language"
    #:author (authors "Gregory H. Cooper" "Shriram Krishnamurthi")
    #:location (proceedings-location esop #:pages '(294 308))
    #:date "2006"))

(define kd:nanopass
  (make-bib
   #:author (authors "Andrew W. Keep" "Kent R. Dybvig")
   #:title "A nanopass framework for commercial compiler development"
   #:location (proceedings-location icfp #:pages '(343 350))
   #:date 2013))

(define fffk:fffk
  (make-bib
    #:author (authors "Matthias Felleisen" "Robert Bruce Findler" "Matthew Flatt" "Shriram Krishnamurthi")
    #:title "A functional I/O system"
    #:location (proceedings-location icfp #:pages '(47 58))
    #:date 2009))

(define fkf:mixins-popl
  (make-bib
    #:author (authors "Matthew Flatt" "Shriram Krishnamurthi" "Matthias Felleisen")
    #:title "Classes and mixins"
    #:location (proceedings-location popl #:pages '(171 183))
    #:date 1998))

(define mfk:error2
  (make-bib
    #:author (authors "Guillaume Marceau" "Kathi Fisler" "Shriram Krishnamurthi")
    #:title "Measuring the effectiveness of error messages designed for novice programmers"
    #:location (proceedings-location
		 "Technical Symposium on Computer Science Education"
		 #:pages '(499 504))
    #:date 2011))

(define spoofax
  (make-bib
    #:author (authors "Kats C.L. Lennart" "Eelco Visser")
    #:title "The Spoofax language workbench"
    #:location (proceedings-location oopsla #:pages '(444 463))
    #:date 2010))

(define xp:dml
  (make-bib
    #:author (authors "Hongwei Xi" "Frank Pfenning")
    #:title "Eliminating array bound checking through dependent types" 
    #:location (proceedings-location pldi #:pages '(249 257))
    #:date 1998))

(define ofsm:lex
  (make-bib
    #:author (authors "Scott Owens" "Matthew Flatt" "Olin Shivers" "Benjamin Mcmullan")
    #:title "Lexer and parser generators in Scheme"
    #:location (proceedings-location sfp #:pages '(41 52))
    #:date 2004))

(define hardening
  (make-bib
    #:author (authors "Tobias Wrigstad" "Patrick Eugster" "John Field" "Nate Nystrom" "Jan Vitek")
    #:title "Software hardening: a research agenda"
    #:location (proceedings-location scripts #:pages '(58 70))
    #:date 2009))

(define f:dls
  (make-bib
    #:author (authors "Martin Fowler")
    #:title "Domain-specific languages"
    #:location (book-location #:publisher "Addison-Wesley")
    #:is-book? #t
    #:date "2010"))

(define mm:proxy
  (make-bib #:title "Robust composition: towards a unified approach to access control and concurrency control"
            #:author "Mark Samuel Miller"
            #:is-book? #t
            #:location (dissertation-location #:institution "Johns Hopkins University")
            #:date "2006"))

(define m:design-by-contract-article
  (make-bib
   #:title "Applying design by contract"
   #:author (authors "Bertrand Meyer")
   #:date "1992"
   #:location
   (journal-location ieee-computer
     #:volume 25
     #:number 10
     #:pages '(40 51))))

(define sf:class-contracts
  (make-bib
   #:title "Contracts for first-class classes"
   #:author (authors "T. Stephen Strickland" "Christos Dimoulas" "Asumu Takikawa" "Matthias Felleisen")
   #:date "2013"
   #:location
   (journal-location a:toplas
     #:volume 35
     #:number 3
     #:pages '("11:1" "11:58"))))

(define swd:nanopass
  (make-bib
   #:title "A nanopass framework for compiler education"
   #:author (authors "Dipanwita Sarkar" "Oscar Waddell" "R. Kent Dybvig")
   #:location (journal-location jfp #:volume 15 #:number "5" #:pages '(653 667))
   #:date 2005))

(define hudak:ultimate
  (make-bib
   #:title "Domain-specific languages"
   #:author (authors "Paul Hudak")
   #:location @(compose splice list){In @emph{Handbook of Programming Languages}. MacMillan. pp 39--60}
   #:date 1998))

(define mfff:rta
  (make-bib
   #:title "A visual environment for developing context-sensitive term rewriting systems"
   #:author (authors "Jacob Matthews" "Robert Bruce Findler" "Matthew Flatt" "Matthias Felleisen")
   #:location (proceedings-location rta #:pages '(2 16))
   #:date 2004))

(define lwc15
  (make-bib
    #:title "Evaluating and comparing language workbenches: Existing results and benchmarks for the future"
    #:location (journal-location "Computer Languages, Systems and Structures"
		 #:pages '(24 47)
		 #:number ""
		 #:volume "44, Part A")
    #:date  "2015"
    #:author (authors
	       "Sebastian Erdweg"
	       "Tijs van der Storm"
	       "Markus Völter"
	       "Laurence Tratt"
	       "Remi Bosman"
	       "William R. Cook"
	       "Albert Gerritsen"
	       "Angelo Hulshout"
	       "Steven Kelly"
	       "Alex Loh"
	       "Gabriël Konat"
	       "Pedro J. Molina"
	       "Martin Palatnik"
	       "Risto Pohjonen"
	       "Eugen Schindler"
	       "Klemens Schindler"
	       "Riccardo Solmi"
	       "Vlad Vergu"
	       "Eelco Visser"
	       "Kevin van der Vlist"
	       "Guido Wachsmuth"
	       "Jimi van der Woning")))
