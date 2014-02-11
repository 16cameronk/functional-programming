(require racket/base)

;;;
;;; newton-cube-root.scm
;;;
;;; Uses Newton's method for computing cube root.
;;; Solves Exercise 1.8 in SICP, top-down approach
;;;
;;;

;; Try a candidate for cube-root(n)
(define try
  (lambda ((guess <number>)
           (n <number>))
    (if (good-enough? guess n)  ;; Is guess close enough?
        guess
        (try (improve guess n)  ;; If not, try to refine it
             n))))

;; Compute the cube root of n, initially guessing 1.0
(define newton-cube-root
  (lambda ((n <number>))
    (try 1.0 n)))


;; Improve a guess that isn't good enough by Newton's method:
;; xnew = x - f(x)/f'(x) = (n/x^2 + 2x)/3 [via some algebra]
(define improve
  (lambda ((guess <number>)
           (n <number>))
    (/ (+ (/ n (square guess))
          (* 2 guess))
       3)))

;; Test whether guess is "close enough" to cube-root(n)
(define good-enough?
  (lambda ((guess <number>)
           (n <number>))
    (in-tolerance? n 
                   (cube guess)
                   0.00001)))

;; Test whether x and y are within relative tolerance.
(define in-tolerance?
  (lambda ((x <number>) 
           (y <number>) 
           (tolerance <number>))
    (< (/ (abs (- x y))              ;; absolute value of difference
          (average (abs x) (abs y))) ;; average of the two values
       tolerance)))

;;; Here's the same thing with absolute tolerance, if you want 
;;; to play with the difference...
;(define in-tolerance?
;  (lambda ((x <number>) (y <number>) (tol <number>))
;    (< (abs (- x y)) tol)))

          
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

;; Here there be dragons
