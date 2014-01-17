(require racket/base)

;; 
;; prove-mult.scm
;;
;; This is a recursive program that generates an entire proof that
;; that the program mult in the Induction handout does multiplication,
;; assuming the second parameter is an non-negative integer.  That is,
;; (mult A B) returns AB.
;;
;;

(define prove-mult
  (lambda ((A <number>) (B <integer>))
    (if (zero? B)
        (begin
          (printf "~a * ~a = 0, and (multiply ~a 0) returns 0~n" A B A)
          (printf "Therefore, (multiply ~a 0) returns ~a * 0~n~n" A A))

        (begin
          (prove-mult A (- B 1))
          (printf "~a * ~a = ~a.  (multiply ~a ~a) returns ~a + (multiply ~a ~a)~n"
                  A B (* A B) A B A A (- B 1))
          (printf "By the previous step, (multiply ~a ~a) = ~a~n"
                  A (- B 1) (* A (- B 1)))
          (printf "Substituting gives ~a + ~a = ~a~n"
                  A (* A (- B 1)) (+ A (* A (- B 1))))
          (printf "Therefore (multiply ~a ~a) returns ~a * ~a~n~n" A B A B)))))
