(require racket/base)

(define multiply
  (lambda ((a <number>) (b <integer>))
    (cond ((zero? b) 0)
          ((odd? b)
           (+ a (multiply (+ a a) (quotient b 2))))
          (else
           (multiply (+ a a) (quotient b 2))))))

(define m
    (lambda ((a <number>) (b <integer>))
      (cond ((zero? b) 0)
            ((odd? b)
             (letrec ((iter 
                (lambda ((c <integer>) (result <number>))
                  (if (zero? c)
                      result
                      (iter (quotient c 2) (+ result a a))))))
                (iter b a)))
            (else
             (letrec ((iter 
                (lambda ((c <integer>) (result <number>))
                  (if (zero? c)
                      result
                      (iter (quotient c 2) (+ result a a))))))
                (iter b 0))))))   