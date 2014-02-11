(require racket/base)

;;;
;;; Example problems for practise in recitation
;;;
;;; Sample solutions
;;; See: s00.0-scheme.txt
;;;

;; Define 'square' to be a procedure that takes any number and returns
;; the square of it.

(define square
  (lambda ((n <number>))
    (* n n)))

;; Define 'foo' to be a procedure that takes a string, and appends the
;; string "wibble" to the end of it.
;;
;; The built-in procedure string-append will help:
;;   (string-append a b) ==> [a concatenated with b]

(define foo
  (lambda ((s <string>))
    (string-append s "wibble")))

;; Define safe-div to take two numbers a and b, and return a / b,
;; unless b = 0, in which case #f should be returned.

(define safe-div
  (lambda ((a <number>) (b <number>))
    (if (zero? b)  ;; zero? is built in; (= b 0) also works
	#f
	(/ a b))))


;; Define divisible? to take two integers, and return #t iff the first
;; is evenly divisible by the second.

(define divisible?
  (lambda ((a <integer>) (b <integer>))
    (zero? (modulo a b))))

;; Define leap-year? to take an integer year and return #t if it is a
;; leap year, #f otherwise.
;;
;; Rules for leap years:
;; 1. n is a leap year if n is divisible by 4, except
;; 2. if n is divisible by 100 it is not, except
;; 3. if n is divisible by 400 it is.

;; One solution...
(define leap-year?
  (lambda ((year <integer>))
    (if (divisible? year 4)
	(if (divisible? year 100)
	    (if (divisible? year 400)
		#t
		#f)
	    #t)
	#f)))

;; Alternate solution...
(define leap-year?
  (lambda ((year <integer>))
    (and (divisible? year 4)
	 (or (not (divisible? year 100))
	     (divisible? year 400)))))

;; Here there be dragons
