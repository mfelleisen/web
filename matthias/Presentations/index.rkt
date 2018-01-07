#lang racket

(provide presentations)
  
(define PD "Presentations")
  
; presentation : String[title] String[abstract] String[ppt] String[comments] *-> XHTML[tr]
(define (presentation title abstract:url ppt:url . comments)
  `(tr
    (td
     (p
      (div ,title
           " ("
           (a ([href ,(path->string (build-path PD abstract:url))]) "abstract")
           ", "
           ,(if (boolean? ppt:url)
                "slides available on request"
                `(a ([href ,(path->string (build-path PD ppt:url))]) 
                    ,(format "slides (~a)" (cadr (regexp-match ".([a-z]*)$" ppt:url)))))
           ")"
           ,@(foldr (lambda (x r) (cons '(br) (cons x r))) '() comments))))))
  
(define presentations
  (list
   (presentation
    "The Racket Manifesto"
    "manifesto.html" "Manifesto/manifesto16.pdf"
    '(div (i "CurryOn") " Rome, Italy; July 2016")
    )

   (presentation
    "Twentyeight Years of Adding Types to Untyped Languages"
    "rome-summer-school-16.html" "STOP/rome-summer-school-16.pdf"
    '(div (i "ECOOP Summer School") " Rome, Italy; July 2016")
    )

   (presentation
    "Love, Marriage, and Happiness"
    "16-plmw.html" "16-plmw.pdf"
    '(div (i "PLMW")
          " Santa Barbara, CA; June 2016")
    )

   (presentation
    "Developing Developers"
    "16-tfp-e.html" "16-tfp-e.pdf"
    '(div (i "Trends in Functional Programming---Education")
          " College Park, MD, June 2016")
    )

   (presentation
    "Types are like the Weater, Type Systems are like Weatermen"
    "16-west.html" "16West/16west.pdf"
    '(div (i "Clojure West")
          " Seattle, WA; April 2016")
    )

   (presentation
    "How do I do Reserch"
    "15-plmw.html" "15-plmw.pdf"
    '(div (i "Programming Language Mentoring Workshop")
          " Vancouver, Canada; September 2015")
    )

   (presentation
    "Contracts: Semantics and Pragmatics"
    "13plc.html" "13PLC/contracts.pdf" 
    '(div (i "Workshop in Honor of Pierre-Louis Curien")
          " Venice, Italy; September 2013")
    )

   (presentation
    "Multilingual Component Programming in Racket"
    "11gpce.html" "11GPCE/gpce11.pdf" 
    '(div "Keynote: " (i "Tenth International Conference on Generative Programming and Component Engineering (GPCE)")
          " Portland, OR; October 2011")
    )

   (presentation
    "Functional Programming is Easy, and Good for You"
    "fp.html" "11GS/gs.pdf" 
    '(a ([href "11GS/gs.zip"]) "slides (gs.zip)")
    '(a ([href "11GS/gs.key.gz"]) "slides (gs.key.gz)"))

   (presentation
    "The TeachScheme! Project"
    "11sigcse.html"
    #false ; "11SIGCSE/11sigcse.pdf"
    '(div "Keynote: " (i "The Annual Conference of the Special Interest Group on Computer Science Education (SIGCSE)")
          " Dallas, TX; March 2011"))

   (presentation
    "TeachScheme! -- A Checkpoint"
    "10icfp.html"
    #false ; "10ICFP/10icfp.pdf"
    '(div "Keynote: " (i "International Conference on Functional Programming (ICFP)")
          " Baltimore, MD; September 2010"))
	 
   (presentation
    "Many Macros, Tons of Types"
    "els2010.html"
    #false ; "ELS2010/els.pdf"
    '(div "Keynote: " (i "European Lisp Symposium") " Lisbon, Portugal; May 2010"))

   (presentation
    "Adding Types to Untyped Languages"
    "10tldi.html"
    #false ; "10TLDI/tldi.pdf"
    '(div "Keynote: "
          (i "Types in Language Design and Implementation (TLDI),")
          " Madrid, Spain; January 2010"))

   (presentation
    "Fun For Freshman Kids and a Functional I/O System"
    "09icfp.html"
    #false ; "09ICFP/09icfp.pdf"
    '(div (a ([href "Presentations/io-video.html"]) "the video version")))

   (presentation
    "From Soft Scheme to Typed Scheme: Experiences from 20 Years of
       Script Evolution, and Some Ideas on What Works"
    "stop.html"
    #false ; "STOP/stop.pdf"
    '(div "Keynote: "
          (i "Scripts to Programs (STOP),")
          " Genova, Italy; July 2009"))

   (presentation
    "How to Design Class Hierarchies"
    "FDPE2005.html"
    #false ; "FDPE2005/htdch.pdf"
    '(div "Keynote: "
          (i "Functional and Declarative Programming in Education (FDPE),")
          " Tallin, Estonia; Spetmeber 2005"
          (br)
          "(delivered by Matthew Flatt)"))
   
   (presentation 
    "Functional Objects"
    "ecoop2004.html"
    #false ; "ecoop2004.pdf"
    '(div
      (a ([href "Presentations/ecoop2004.tar.gz"]) "Keynote: ")
      (i "European Conference on Object-Oriented Programming Languages,")
      " Oslo, Norway, 2004"))

   (presentation
    "The Human Language Interface"
    "HLI.html"
    #false ; "Mexico.ppt"
    '(div (i "3a Semana de Computacion en Ciencias") " Mexico City, 2003"))

   #;
   (presentation
    "The Structure and Interpretation of the Computer Science Curriculum"
    "FDPE2002.html"
    "FDPE2002.ppt")

   (presentation
    "From POPL to the Classroom and Back"
    "POPL2002.html"
    #false ; "POPL2002.ppt"
    '(div "Keynote: "
          (i "Symposium on the Principles of Programming Languages, ") 
          "Portland, OR, 2002"))

   (presentation
    "Program Analyses: A Consumer's Perspective"
    "sas.html"
    #false ; "SAS.ppt"
    '(div "Keynote: " (i "Static Analysis Symposium, ") "Santa Barbara, CA, July 2000"))))
  
