(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))
        
(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

(define (abs3 x)
  (if (< x 0)
      (- x)
      x))

;;(and (> x 5) (< x 10))

;;(define (>= x y)
;;  (or (> x y) (= x y)))

;;(define (>= x y)
;;  (not (< x y)))

;; Exercise 1.1

;;(+ 5 3 4)

;; Exercise 1.2

(/ (+ 5 4 (- 2 (- 3 (+ 6 4)))) (* 3 (- 6 2) (- 2 7)))

;; Exercise 1.3

;;(define (foo a b c)
;;  if


;; Exercise 1.4

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(define a 3)
(define b 4)
(a-plus-abs-b a b)

;; Exercise 1.5

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))
(test 0 (p))
;; define: expected at least one variable after the function name, but found none