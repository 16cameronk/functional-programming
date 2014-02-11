;;;
;;; lists.scm
;;;
;;; Introduction to Lists.
;;; Code examples from Lecture 6, CS 230
;;;

;; (length lst) Return the number of elements in the list
;; This is actually built-in, but this illustrates a simple
;; recursion on lists, which we will use a lot!
(define length
  (lambda ((lst <list>))
    (if (null? lst)
        0
        (+ 1 (length (cdr lst))))))


;; A tail-recursive version of length
(define length
  (lambda ((lst <list>))
    (let loop ((len 0) (lst lst))
      (if (null? lst) 
          len
          (loop (+ len 1) (cdr lst))))))


;; Append two lists together, returning the appended list
;; This is also built in, but this illustrates list recursion
(define append
  (lambda ((lst1 <list>) (lst2 <list>))
    (if (null? lst1)
        lst2
        (cons (car lst1)
              (append (cdr lst1) lst2)))))


;; A very simplified version of 'map'.  A more sophisticated
;; version is available in Scheme, which can take any number
;; of lists as parameters.
(define simple-map
  (lambda ((f <function>) (lst <list>))
    (if (null? lst)
        '()
        (cons (f (car lst))
              (simple-map f (cdr lst))))))


;; Make a copy of the specified list (same elements, different boxes)
(define copy
  (lambda ((lst <list>))
    (simple-map (lambda (x) x) lst)))

;; Test if an object is an atom (not a pair)
(define atom?
  (lambda ((x <obj>))
    (not (pair? x))))


;; Counts the number of non-nil atoms in a list structure
(define count-prim
  (lambda ((l <obj>))
    (cond
      ((null? l) 0)
      ((atom? l) 1)
      (else (+ (count-prim (car l))
               (count-prim (cdr l)))))))


;; Counts the number of non-nil atoms in a list structure.
;; This version uses higher-order functions
(define count-prim-2
  (lambda ((l <obj>))
    (cond
      ((null? l) 0)
      ((atom? l) 1)
      (else (foldr + 0 (map count-prim-2 l))))))


;; This is like "map", but it works on simple trees formed
;; of conses
(define tree-map
  (lambda ((f <function>) (tree <obj>))
    (cond
      ((null? tree) '())
      ((atom? tree) (f tree))
      (else (cons (tree-map f (car tree))
                  (tree-map f (cdr tree)))))))


;; This is like "map", but it works on simple trees formed
;; of conses.  This version uses higher-order functions.
(define tree-map-2
  (lambda ((f <function>) tree)
    (cond ((null? tree) '())
          ((atom? tree) (f tree))
          (else
           (map (lambda (t) (tree-map-2 f t)) tree)))))



;; A simple tree to experiment with
;;
;;                         *
;;               +---------|-------+
;;               |                 |
;;         +-----*-----+    +----+-*--+----+
;;         |     |     |    |    |    |    |
;;      +--*--+  4     5    6    7  +-*-+  10
;;      |  |  |                     |   |
;;      1  2  3                     8   9
                       (define test-tree
                         '(((1 2 3) 4 5) (6 7 (8 9) 10)))
                       
