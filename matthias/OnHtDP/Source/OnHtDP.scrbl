#lang scribble/manual

@(require "shared.ss")

@title*[#:style 'toc]{On HtDP}

@author{Matthias Felleisen}

@; -----------------------------------------------------------------------------

This site collects the design rationale for @link["http://www.htdp.org/"]{How
to Design Programs} in the form or essays and memos. For now, they respond to
questions that come up repeatedly in public postings or private
emails. Eventually, I hope to compile a systematic record of my decisions, a
meta-theory of @link["http://www.htdp.org/"]{HtDP} so to speak. 

@include-section{turing.scrbl}

@include-section{alternatived.scrbl}
@include-section{datatype.scrbl}

@; -----------------------------------------------------------------------------
@include-section{teach.scrbl}
@include-section{htdp-and-colleagues.scrbl}
@include-section{coop-ts.scrbl}
@include-section{faq.scrbl}
