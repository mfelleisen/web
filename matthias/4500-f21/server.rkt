#lang racket

(require SwDev/Testing/communication)
(require "server-client.rkt")

(define (server-launch)
  (define listener (tcp-listen 12345 30 #true))
  (define-values (client-in client-out) (tcp-accept listener))
  (define client (new proxy-client% [in client-in] [out client-out]))
  (define server (new server% [client client]))
  (send server go)
  "all done")

(define proxy-client%
  (class object% (init-field in out)
    (super-new)

    (define/private (serialize l) (~a l))
    (define/private (deserialize x) x)
      
    (define/public (ding x)
      (send-message `["ding" ,(serialize x)] out)
      (deserialize (read-message in)))

    (define/public (dong y)
      (send-message `["dong" ,(serialize y)] out)
      (deserialize (read-message in)))))