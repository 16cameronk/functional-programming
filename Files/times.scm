(require racket/base)

;;;
;;; times.scm
;;;
;;; Various methods for multiplying two numbers using recursion, and
;;; without using the primitive '*' function.  The method is simple
;;; repeated addition and is O(b).
;;;
;;; (multiply a b)
;;; 'a' may be any number, 'b' must be a non-negative integer
;;;

;; A recursive method, but not tail-recursive
(define multiply-1
  (lambda ((a <number>) (b <integer>))
    (if (zero? b)
        0
        (+ a (multiply-1 
	      a 
	      (- b 1))))))




;; A tail-recursive method, using a helper function
(define multiply-2-helper
  (lambda ((a <number>) (b <integer>) (result <number>))
    (if (zero? b)
	result
	(multiply-2-helper a (- b 1) (+ result a)))))

(define multiply-2
  (lambda ((a <number>) (b <integer>))
    (multiply-2-helper a b 0)))




;; The same method, using letrec instead of an external function.
;; It's not really necessary to bind the helper externally!
(define multiply-2a
  (lambda ((a <number>) (b <integer>))
    (letrec ((iterate 
              (lambda ((c <integer>) (result <number>))
                (if (zero? c)
                    result
                    (iterate (- c 1) (+ result a))))))
      (iterate b 0))))



;; A tail-recursive method, using named let
(define multiply-3
  (lambda ((a <number>) (b <integer>))
    (let iterate ((c b)         ; c is initially b
                  (result 0))   ; result is initially zero
      (if (zero? c)
          result
          (iterate (- c 1) (+ result a))))))

;; Here there be dragons
