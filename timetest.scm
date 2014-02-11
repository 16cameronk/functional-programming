;;; 
;;; timetest.scm
;;;
;;; Simple timing tests for two different multiplication algorithms
;;; The timing function (time-test) relies on some DrScheme extensions
;;; to capture time in millisconds.
;;;
;;;

;; Multiplication by repeated addition
(define multiply-1
  (lambda ((a <number>) (b <integer>))
    (if (zero? b)
        0
        (+ a (multiply-1 a (- b 1))))))

;; Russian peasant's algorithm for multiplication
(define multiply-2
  (lambda ((a <number>) (b <integer>))
    (cond ((zero? b) 0)
          ((odd? b)
           (+ a (multiply-2 (* 2 a) (- b 1))))
          (else
           (multiply-2 (* 2 a) (quotient b 2))))))

;; A simple timing test driver for whatever...
;; Returns "real" time (in seconds) for a single multiply,
;; averaged over all the test runs.
(define time-test
  (lambda ((f <function>) (num-tests <integer>) &rest args)
    (let-values (((result cpu real gc)
                  (time-apply 
                   (lambda () 
                     (let loop ((n num-tests))
                       (if (zero? n)
                           (void)
                           (begin (apply f args)
                                  (loop (- n 1))))))
                   '())))
      (/ real num-tests 1000.0))))