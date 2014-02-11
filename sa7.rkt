;; Keng Low

(require racket/base)

;; Test if an object is an atom (not a pair)
(define atom?
  (lambda ((x <obj>))
    (not (pair? x))))

;; Trying tail-reverse with letrec

(define deep-reverse
  (lambda ((lst <list>))
    (cond ((null? lst) '())
          ((atom? (car lst)) 
           (append (deep-reverse (cdr lst)) (list (car lst))))
          (else
           (append (deep-reverse (cdr lst)) (list (deep-reverse (car lst))))))))

;; T(n) = O(n) + T(n - 1)
;; or
;; T(n) = O(n) + T(n - 1) + T(m)
;;      = O(n^2) + T(m)
;;      = O(n^2 + m^2)

(reverse '()) ;; ()

(deep-reverse '()) ;; ()

(reverse '(1 (2 3) 4 5)) ;; (5 4 (2 3) 1)

(deep-reverse '(1 (2 3) 4 5)) ;; (5 4 (3 2) 1)

(reverse '(1 (2 3) (4 (5 6) 7) (8 9 (10 11 (12)))))
;; ((8 9 (10 11 (12))) (4 (5 6) 7) (2 3) 1)

(deep-reverse '(1 (2 3) (4 (5 6) 7) (8 9 (10 11 (12)))))
;; ((((12) 11 10) 9 8) (7 (6 5) 4) (3 2) 1)