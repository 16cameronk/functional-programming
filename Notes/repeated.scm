;;;
;;; repeated.scm
;;;
;;; Functions which return single and repeated compositions of a
;;; function
;;;
;;;

;; Composes the functions f and g
(define compose
  (lambda ((f <function>) (g <function>))
    (lambda (x)
      (f (g x)))))

;; Unary (single-argument) identity function
(define identity
  (lambda (x) x))

;; Unary negation
(define negation-1
  (lambda ((f <function>))
    (lambda (x)
      (not (f x)))))

;; Binary negation (later in the course, we will look at a more
;; elegant solution)
(define negation-2
  (lambda ((f <function>))
    (lambda (x y)
      (not (f x y)))))

;; composes the function f with itself n times
(define repeated
  (lambda ((f <function>) (n <integer>))
    (if (zero? n)
        identity
        (compose f (repeated f (- n 1))))))

;; composes the function f with itself n times. Tail recursive.
(define repeated-t
  (lambda ((f <function>) (n <integer>))
    (let loop ((count n) (result identity))
      (if (zero? count)
          result
          (loop (- count 1)
                (compose f result))))
    ))

;; The following functions all compose f with itself n-1 times,
;; without calling the function `compose'.
;;
;; You should try to understand how these work; if you can do so, you
;; will be a long way toward really apprehending higher-order
;; functions.
;;
;; What are the similarities between these?  The differences?  
;; Which ones are tail recursive?  Which are not?

(define repeated-1
  (lambda ((f <function>) (n <integer>))
    (lambda ((x <obj>))
      (if (zero? n)
          x
          (f ((repeated-1 f (- n 1)) x)))
      )))

(define repeated-2
  (lambda ((f <function>) (n <integer>))
    (lambda ((x <obj>))
      (if (zero? n)
          x
          ((repeated-2 f (- n 1)) (f x)))
      )))

(define repeated-3
  (lambda ((f <function>) (n <integer>))
    (if (zero? n)
        identity
        (lambda ((x <obj>))
          ((repeated-3 f (- n 1)) (f x))))
    ))

(define repeated-4
  (lambda ((f <function>) (n <integer>))
    (if (zero? n)
        identity
        (lambda ((x <obj>))
          (f ((repeated-4 f (- n 1)) x))))
    ))

;; Here there be dragons
