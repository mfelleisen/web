#lang racket

(provide server% client%)

(define server%
  (class object% (init-field client)
    (super-new)

    (define/public (go)
      (ping)
      (define x (pong))
      (when (< x 10) (go)))

    (define/public (ping)
      (send client ding 'ping))

    (define/public (pong)
      (send client dong 'pong))))

(define client%
  (class object%
    (super-new)

    (field [counter 0])

    (define/public (ding x)
      (displayln `[ding received ,x])
      (set! counter (+ counter 1))
      counter)

    (define/public (dong y)
      (displayln `[dong received ,y])
      (set! counter (+ counter 1))
      counter)))
      
(define (mono-launch)
  (define client (new client%))
  (define server (new server% [client client]))

  (send server go)

  "all done")

