;;; eval-series.scm

;;; Class example to illustrate functions passed as parameters.

;; Evaluates the terms 0 through n of an infinite series at the value
;; x.  The coefficients and powers of x are determined by passing
;; functions to compute them for the kth term.

(define eval-series
  (lambda ((x <number>)        ; Value at which the sequence is evaluated
           (n <integer>)       ; Number of highest term in the series
           (coef <function>)   ; Returns the coefficient of the kth term
           (power <function>)) ; Returns exponent of x in the kth term
    (if (negative? n)
        0.0
        (+ (* (coef n) (expt x (power n)))
           (eval-series x (- n 1) coef power)))))


;; computes an approximation for e^x, using a series expansion
(define e^x
  (lambda ((x <number>))
    (eval-series x 50 one/factorial identity)))

;; Tail-recursive version of factorial.  
;; Returns floating point number instead of an integer
(define factorial
  (lambda ((n <integer>))
    (letrec ((loop (lambda (k result)
		     (if (zero? k)
			 result
			 (loop (- k 1) (* k result))))))
      (loop n 1.0))))

;; computes 1/n! 
(define one/factorial
  (lambda ((n <integer>))
    (/ (factorial n))))

;; A different way to compute reciprocal of factorial
;; Demonstrates the "named LET" construct
;;
(define one/factorial-alternate
  (lambda ((n <integer>))
    (let loop ((k n) (result 1.0))
      (if (zero? k)
	  result
	  (loop (- k 1) (/ result k))))))

(define identity
  (lambda (x) x))

;; computes sin(x) using a series expansion
;; Note use of anonymous functions!
(define my-sin
  (lambda ((x <number>))
    (eval-series x 
                 50
                 (lambda ((k <integer>)) 
                   (/ (expt -1 k)          ; The more obvious way to do it
                      (factorial (+ (* 2 k) 1))))
                 (lambda ((k <integer>)) 
                   (+ (* 2 k) 1)))))

;; computes cos(x) using a series expansion
;; Note that we've simplified (-1)^k by noting that this is -1 when k
;; is odd, 1 when k is even.
(define my-cos
  (lambda ((x <number>))
    (eval-series x 
                 50
                 (lambda ((k <integer>))
                   (/ (if (odd? k) -1 1)   ; every expression has a value!
                      (factorial (* 2 k))))
                 (lambda ((k <integer>)) 
                   (* 2 k)))))


;; Returns a constant function that always returns x
(define constantly
  (lambda (x)
    (lambda (y) x)))

;; Computes the value of terms 0 through n of a geometric series
(define geometric
  (lambda ((x <number>) (n <integer>))
    (eval-series x n (constantly 1) identity)))

;; Convert degrees to radians (since all the examples work in radians)
(define deg->rad
  (let* ((pi     (* 4 (atan 1)))
         (pi/180 (/ pi 180)))
    (lambda ((degrees <number>))
      (* degrees pi/180))))

(define my-sin-deg
  (lambda ((degrees <number>))
    (my-sin (deg->rad degrees))))

(define my-cos-deg
  (lambda ((degrees <number>))
    (my-cos (deg->rad degrees))))

;; Here there be dragons
