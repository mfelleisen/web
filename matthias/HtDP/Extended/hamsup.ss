(module hamsup mzscheme
  (require (lib "etc.ss"))

  (provide
    install-listener ;; Number (Sexpr -> true) -> true
    send-message ;; String Number Sexpr -> true
    )
  
  (define (install-listener port receiver)
    (local [(define listener (tcp-listen port))
            (define (server-loop)
              (local [(define-values (client->me me->client)
                        (tcp-accept listener))]
                (begin
                  (close-output-port me->client)
                  (let ([the-value (read client->me)])
                    (begin
                      (close-input-port client->me)
                      (receiver the-value)
                      (server-loop))))))]
      (thread server-loop)
      #t))

  (define (send-message mach port packet)
    (let-values ([(server->me me->server) (tcp-connect mach port)])
      (write packet me->server)
      (close-output-port me->server)
      (close-input-port server->me)
      #t))
  )
