#lang racket

(require SwDev/Testing/communication)
(require "server-client.rkt")

(define proxy-server%
  (class object% [init-field client in out]
    (super-new)

    (define/private (serialize l) l)
    (define/private (deserialize x) (string->symbol x))

    (define/public (go)
      (define result
        (match (read-message in)
          [`("ding" ,x) (send client ding (deserialize x))]
          [`("dong" ,y) (send client dong (deserialize y))]
          [v (error "something bad happened: ~e" v)]))
      (send-message (serialize result) out)
      (go))))

(define (client-launch)
  (define-values (in out) (tcp-connect "127.0.0.1" 12345))
  (define client (new client%))
  (define server (new proxy-server% [client client] [in in] [out out]))
  (send server go))

