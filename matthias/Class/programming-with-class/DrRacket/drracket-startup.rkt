#lang racket

;; this module represents DrRacket's startup sequence
;; -----------------------------------------------------------------------------

(require "drracket-plugin.rkt")

;;; ----------------------------------------------------------
; for proper compilation you want something like these lines: 
; (require racket/runtime-path)
; (define-runtime-path info.rkt "info.rkt")
; (define plugins (list info.rkt))
;;; ----------------------------------------------------------

;; collect all plugins from the info.rkt files in tool directories
(define plugins (list "info.rkt"))

;; dynamically load the plugins so that they can register themselves 
(for ([plugin (in-list plugins)])
  (dynamic-require plugin #f))

(define the-top-level-frame% 
  (send mixin-registry get-drr-frame%))

(define the-top-level-frame 
  (new the-top-level-frame% [label "DrRacket"]))

(send the-top-level-frame show #t)
