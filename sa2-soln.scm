;;;
;;; sa2-soln.scm
;;;
;;; Solutions to Short Assignment #2 of CS 230
;;;

;; Here is a tail-recursive version of multiply that uses a
;; helper function defined with letrec
(define multiply
  (lambda ((a <number>) (b <integer>))
    (letrec ((loop
              (lambda ((m <number>) (n <integer>) (output <number>))
                (cond ((zero? n) output)
                      ((odd? n)
                       (loop (+ m m) (quotient n 2) (+ output m)))
                      (else
                       (loop (+ m m) (quotient n 2) output))))))
      (loop a b 0))))

;; Here is the same idea, but using named let
(define multiply
  (lambda ((a <number>) (b <integer>))
    (let loop ((m a) (n b) (output 0))
      (cond ((zero? n) output)
            ((odd? n)
             (loop (+ m m) (quotient n 2) (+ output m)))
            (else
             (loop (+ m m) (quotient n 2) output))))))
