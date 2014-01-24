;; Keng Low

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
      (if (zero? b)
          0
          (letrec ((iter 
                (lambda ((c <integer>) (result <number>))
                  (cond ((zero? c) 
                         result)
                        ((= 1 c)
                         (+ result (+ a a)))
                        ((odd? c)
                         (iter (quotient c 2) (+ result (* (+ a a)))))
                        (else
                         (iter (quotient c 2) (+ result (* (quotient c 2) (+ a a)))))))))
            (if (odd? b)
                (iter (quotient b 2) a)
                (iter (quotient b 2) 0))))))
 