#lang racket
(require parser-tools/lex
         parser-tools/lex-sre
         parser-tools/yacc)

(provide parse make-tokenizer)

;; like network-lang-lexed-parser, but with generated parser

(define-lex-abbrev comment (: ";" (* (& any-char (~ "\n"))) "\n"))
(define-lex-abbrev id (+ (~ whitespace)))
(define-lex-abbrev num (+ numeric))

;; A Token is ...
(define-tokens toks (ID NUM))
(define-empty-tokens delim-toks (EOF PROBLEM FROM TO NODE -- -->)) ; symbols

;; Q: Can I use lexer without parser?
;; A: lexer can't handle multiple matches, eg (: problem var from var to var)
;; 
;; make-tokenizer : Port -> (-> Token)
(define (make-tokenizer port)
  (define (next-token)
    (define lx
      (lexer
       [(eof) 'EOF]
       ["--" '--]
       ["-->" '-->]
       ["problem:" 'PROBLEM]
       ["node" 'NODE]
       ["from" 'FROM]
       ["to" 'TO]
       [whitespace (next-token)]
       [comment (next-token)]
       [num (token-NUM (string->number lexeme))]
       [id (token-ID (string->symbol lexeme))]))
    (lx port))
  next-token)

;; parse : (-> Token) -> StxObj
;; - Consumes a token stream.
;; - *does not* wrap result with `module`
(define parse
  (parser
   (tokens toks delim-toks)
   (error (λ args (apply printf "parse error ~a ~a ~a ~a ~a" args)))
   (start <prog>)
   (end EOF)
   (grammar
    (<prog> [(<problem> <nodes>) (cons $1 $2)])
    (<problem> [(PROBLEM <id> FROM <id> TO <id>) `(solve-problem ,$4 ,$6 ,$2)])
    (<nodes> [(<node>) (list $1)]
             [(<node> <nodes>) (cons $1 $2)])
    (<node> [(NODE <id> -- <wgt> --> <id>) `(node ,$2 (,$6 ,$4))])
    (<id> [(ID) $1])
    (<wgt> [(NUM) $1]))))
    

#;(define TEST-PROG
  (string-join
   (list
    ";; uses network-lang.rkt, but has syntax of network-syn-lang.rkt\n"
    ";; sample graph\n"
    "problem: argmax from a to d \n"
    "node a -- 10 --> b"
    "node a -- 20 --> c"
    "node b -- 30 --> d"
    "node c -- 30 --> d")
   "\n"))

#;(with-input-from-string TEST-PROG
  (λ ()
;    (println (parse (make-tokenizer (current-input-port))))
    (define next (make-tokenizer (current-input-port)))
    (let L ([tok (next)])
      (unless (equal? 'EOF tok)
        (println tok)
        (L (next))))
    ))
