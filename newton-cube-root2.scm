(require racket/base)

;;; newton-cube-root2.scm
;;;
;;; Uses Newton's method for computing cube root.
;;; Solves Exercise 1.8 in SCIP
;;; This version uses letrec to nest helper functions.
;;;

;; Compute the cube root of n
(define newton-cube-root
  (lambda ((n <number>))
    (letrec
      ((try    ;; Try a candidate for cube-root(n)
        (lambda ((guess <number>))
          (if (good-enough? guess) 
              guess
              (try (improve guess)))))  ; If no, try to refine the guess
       
       ;; Test whether guess is "close enough" to cube-root(n)
       (good-enough?    
        (lambda ((guess <number>))
          (in-tolerance? n (cube guess) 0.00001)))
       
       ;; Given a guess, compute a "better" guess, using Newton's method
       (improve   
        (lambda ((guess <number>))
          (/ (+ (/ n (square guess)) (* 2 guess)) 3))))

      (try 1.0))))           ; Initially guess that cube-root(n) = 1

    
;; Test whether x and y are within relative tolerance.
(define in-tolerance?
  (lambda ((x <number>) (y <number>) (tolerance <number>))
    (< (/ (abs (- x y))
          (average (abs x) (abs y)))
       tolerance)))
          
;; Take the arithmetic mean of two numbers
(define average
  (lambda ((a <number>) (b <number>))
    (/ (+ a b) 2.0)))

;; Compute x cubed
(define cube
  (lambda ((x <number>))
    (* x x x)))

;; Define square
(define square
  (lambda ((x <number>))
    (* x x)))