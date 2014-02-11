;; Keng Low

(require racket/base)

(define simple-reverse
  (lambda ((lst <list>))
    (if (null? lst)
        '()
        (append (simple-reverse (cdr lst)) (list (car lst))))))

;; T(n) = T(n - 1) + O(n)
;;        --------  -----
;;        append    recursive
;; T(n) = O(n - 1) + T(n - 2) + O(n)
;;        -------------------
;;              T(n - 1)
;; T(n) = O(n + (n - 1) + (n - 2) + ... + 1)
;;      = O(n^2)

    
(define tail-reverse
  (lambda ((lst <list>))
    (let loop ((lst lst) (lst2 '()))
      (if (null? lst)
        lst2
        (loop (cdr lst) (cons (car lst) lst2))))))

;; T(n) = T(n - 1) + O(1)
;;      = T(n - 2) + O(1 + 1)
;;      = O(n)

;; Trying tail-reverse with letrec

(define tail-reverse-2
  (lambda ((lst <list>))
    (letrec 
        ((loop 
              (lambda (lst lst2)
                (if (null? lst)
                    lst2
                    (loop (cdr lst) (cons (car lst) lst2))))))
      (loop lst '()))))

(simple-reverse '())
(tail-reverse '())
(tail-reverse-2 '())
;; ()

(simple-reverse '(1))
(tail-reverse '(1))
(tail-reverse-2 '(1))
;; (1)

(simple-reverse '(1 2 3 4 5))
(tail-reverse '(1 2 3 4 5))
(tail-reverse-2 '(1 2 3 4 5))
;; (5 4 3 2 1)

(simple-reverse '(1 (2 3) 4 5))
(tail-reverse '(1 (2 3) 4 5))
(tail-reverse-2 '(1 (2 3) 4 5))
;; (5 4 (2 3) 1)