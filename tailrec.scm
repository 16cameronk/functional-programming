;; Here is a tail-recursive version of multiply that uses a
;; helper function defined with letrec
(define multiply
  (lambda ((a <number>) (b <integer>))
    (letrec ((loop
              (lambda ((m <number>) (n <integer>) (output <number>))
                (cond ((zero? n) output)
                      ((odd? n)
                       (loop (* 2 m) (quotient n 2) (+ output m)))
                      (else
                       (loop (* 2 m) (quotient n 2) output))))))
      (loop a b 0))))

;; Here is the same idea, but using named let
(define multiply
  (lambda ((a <number>) (b <integer>))
    (let loop ((m a) (n b) (output 0))
      (cond ((zero? n) output)
            ((odd? n)
             (loop (* 2 m) (quotient n 2) (+ output m)))
            (else
             (loop (* 2 m) (quotient n 2) output))))))


;; Another example ... factorials:

(define fact
  (lambda ((z <integer>))
    (let loop ((n z) (total 1))
      (if (zero? n)
          total
          (loop (- n 1) (* total n))))))

;; Another example ... Fibonacci:

(define fib-tr
  (lambda ((n <integer>))
    (let loop ((prev 0) (cur 1) (n n))
      (if (zero? n)
          prev
          (loop cur (+ prev cur) (- n 1))))))
