;;;
;;; sa1-soln.scm
;;;
;;; Sample solutions for Short Assignment #1 of CS 230
;;;

#| General notes

   It is okay to run together multiple EVAL steps in a single
   expression, if they are all identifiers and/or primitives.

   It is _not_ okay to fold together multiple APPLY steps.

   It is okay to elide procedure bodies with ellipses (...) if it is
   obvious which procedure is intended.
 |#

;; This is the original function
(define mystery
  (lambda ((a <number>) (b <integer>))
    (cond ((zero? b) 0)
          ((odd? b)
           (+ a (mystery (+ a a) (quotient b 2))))
          (else
           (mystery (+ a a) (quotient b 2))))))

;; This is the call you evaluated
(mystery 7 2)

;; Here is the substitution model trace of the call
[{proc ((a <number>) (b <number>))
       (cond ((zero? b) 0) 
             ((odd? b) (+ a (mystery (+ a a) (quotient b 2))))
             (else (mystery (+ a a) (quotient b 2))))} 
 {7} {2}]

(cond ((zero? {2}) 0)
      ((odd? {2}) (+ {7} (mystery (+ {7} {7}) (quotient {2} 2))))
      (else (mystery (+ {7} {7}) (quotient {2} 2))))

[{zero?} {2}] ==> #f, evaluate next test

[{odd?} {2}] ==> #f, evaluate else clause

(mystery (+ {7} {7}) (quotient {2} 2))

(mystery [{add} {7} {7}] [{quotient} {2} {2}])

(mystery {14} {1})

[{proc ((a <number>) (b <number>))
       (cond ((zero? b) 0)
             ((odd? b) (+ a (mystery (+ a a) (quotient b 2))))
             (else (mystery (+ a a) (quotient b 2))))} 
 {14} {1}]

(cond ((zero? {1}) 0)
      ((odd? {1}) (+ {14} (mystery (+ {14} {14}) (quotient {1} 2))))
      (else (mystery (+ {14} {14}) (quotient {1} 2))))

[{zero?} {1}] ==> #f, evaluate next test

[{odd?} {1}] ==> #t, evaluate corresponding expression

(+ {14} (mystery (+ {14} {14}) (quotient {1} 2)))

(+ {14} (mystery [{add} {14} {14}] [{quotient} {1} {2}]))

(+ {14} (mystery {28} {0}))

(+ {14} [{proc ((a <number>) (b <integer>))
               (cond ((zero? b) 0)
                     ((odd? b) (+ a (mystery (* 2 a) (quotient b 2))))
                     (else (mystery (* 2 a) (quotient b 2))))} 
         {28} {0}])

(+ {14} (cond ((zero? {0}) 0)
              ((odd? {0}) (+ {28} (mystery (+ {28} {28}) (quotient {0} 2))))
              (else (mystery (+ {28} {28}) (quotient {0} 2)))))

[{zero?} {0}] ==> #t, evaluate 0 ==> {0}

(+ {14} {0})

[{add} {14} {0}]

{14}  ;; evaluation complete
