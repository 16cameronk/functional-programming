;;;
;;;cs230.ps3.scm
;;;
;;; For this problem set, when defining functions do not use types in 
;;; the lambda expressions. Instead, you should add a comment as to what 
;;; the type should be.

;;; Do not use (require racket/base) for this problem set.
;; ----- Useful functions -----

;; Define a predicate member? that returns #t if obj is a member of
;; lst and #f otherwise.

;; Contrast with the builtin member function, which returns the
;; sublist of lst starting with obj if obj is in the list.
(require racket/class)

(define member?
  (lambda (obj lst)
    (not (not (member obj lst)))))

;;foldr and foldl are provided in scheme                                                

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Note these functions are the same
;;
;;(define foldl accumulate)
;;accumulate was defined in class as well as in SICP                             
                                                                                      
;;Note: (accumulate  '() cons '(1 2 3 4)) => '(1 2 3 4)
;;(define foldr (lambda (op init lst) (accumulate init op lst)))                        
;;Note: (foldr cons '() '(1 2 3 4)) => '(1 2 3 4)                                       
;;Whereas: (foldl cons '() '(1 2 3 4) => '(4 3 2 1)  

;; ------ Data type definitions -----

;; Directed graph class definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;(vertices <graph>) => list of vertices
;;(edges <graph>) => list of edges 
;;
(defclass <graph> ()
  (vertices :initarg :vertices :accessor vertices) 
  (edges :initarg :edges :accessor edges))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;(name <vertex>) => the name of the vertex
;;ex: (name (make-vertex 'a)) => a
;;
(defclass <vertex> ()
  (name :initarg :name :accessor name))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;(start <directed-edge>) => first vertex of directed-edge
;;ex: (start (v1 v2)) => v1
;;(finish <directed-edge>) => second vertex of directed-edge
;;ex: (finish (v1 v2)) => v2
;;
(defclass <directed-edge> ()
  (start :initarg :start :accessor start)
  (finish :initarg :finish :accessor finish))

(define make-vertex
  (lambda (name)
    (make <vertex> :name name)))

(define make-edge
  (lambda (a b) ;a <vertex> b <vertex>
    (make <directed-edge> :start a :finish b)))

;; Two vertices are considered equal if their names are equal

(define equal-vertex?
  (lambda (v1 v2)
    (eq? (name v1) (name v2))))

;; lookup-vertex takes a name and a list of vertices, and finds a vertex
;; with that name.  Useful when you have the name of a vertex and need
;; the vertex itself.

(define lookup-vertex
  (lambda (vname vlist)
    (cond ((null? vlist) #f)
          ((equal? vname (name (first vlist))) (first vlist)) 
          ;replaced car with first
          (else (lookup-vertex vname (rest vlist)))))) 
;replaced cdr with rest

;; make-graph takes two lists whose atoms are symbols, one of the form
;;   (v1 v2 v3 ...) 
;; which becomes the list of vertices and the other of the form
;;   ((u1 u2) (u3 u4) ...) 
;; which becomes the list of edges.

(define make-graph
  (lambda (v-names e-list)
    (let* ((v (map make-vertex v-names))
           (create-edge 
              (lambda (name1 name2)
                (make-edge (lookup-vertex name1 v)
                           (lookup-vertex name2 v)))))
        (make <graph>
              :vertices v        
              :edges (map create-edge
                          (map first e-list)
                          (map second e-list))))))

;; Convert a list of vertices to a list of names of vertices

(define name-vertices
  (lambda (vlist)
    (map name vlist)))

;;;Same as standard member function but works with vertices
(define member-vertices 
  (lambda (a lat) 
    (cond ((null? lat) #f) 
          ((equal-vertex? a (car lat)) lat) 
          (else (member-vertices a (cdr lat))))))

;; Find the set difference of two sets represented as lists.  That is,
;; return a list consisting of everything in list1 that is not in
;; list2

(define set-diff-vertices
  (lambda (list1 list2)
    (cond ((null? list1) '()) 
          ((member-vertices 
            (car list1) list2) 
           (set-diff-vertices (cdr list1) list2))
          (#t (cons (car list1) 
                    (set-diff-vertices (cdr list1) list2))))))

;; Take the union of two sets represented as lists -- no duplicates

(define union
  (lambda (list1 list2)
    (cond ((null? list1) list2) 
          ((member (car list1) list2) (union (cdr list1) list2))
          (else (cons (car list1) (union (cdr list1) list2))))))
          

;; Take the intersection of two sets represented as lists 

(define intersection
  (lambda (list1 list2)
    (cond ((null? list1) '()) 
          ((member (car list1) list2) 
             (cons (car list1) (intersection (cdr list1) list2)))
          (else (intersection (cdr list1) list2)))))

;;; ----- TESTING EXAMPLES -----

;; ----- Problem 1 -----
(define exits
  (lambda (vertex graph)
    (letrec 
      ((loop
        (lambda (edges-lst exit-lst)
               (cond ((null? edges-lst) exit-lst)
                     ((equal? vertex (start (car edges-lst)))
                      (loop (cdr edges-lst)
                            (union exit-lst 
                                   (list (finish (car edges-lst))))))
                     (else 
                      (loop (cdr edges-lst) exit-lst))))))
      (loop (edges graph) '()))))
             
(define g1 (make-graph '(a b c d e) 
		       '((a b) (a c) (b c) (b e) (c d) (d b))))

;(name-vertices (exits (lookup-vertex 'b (vertices g1)) g1))
; ==> (c e)

;(name-vertices (exits (lookup-vertex 'e (vertices g1)) g1))
; ==> ()

(define verify-path
  (lambda (g lst)
    (letrec
        ((loop
          (lambda (lst1 lst2)
            (cond ((null? lst2) #t)
                  ((member? (car lst2) (exits (car lst1) g))
                   (loop (cdr lst1) (cdr lst2)))
                  (else #f)))))
      (loop lst (cdr lst)))))
                   
; In the worst-case scenario, we can assume that
; the entire list of vertices is traversed. 
; In such a case, verify-path would find a connection
; from one vertice to the next. 
; This ensures that verify-path would be O(n).
; However, note that verify-path queries exits 
; for the connections that can be made at each vertice. 
; Since there would be n such queries for a 
; list of n vertices, the operation would be O(n).  
; Since this is a nested loop inside verify-path, 
; it would be O(n^(1+1)).
; As such O(n^k) for some k >= 0.

;(define tl
; (map (lambda (x) (lookup-vertex x (vertices g1))) '(a b c d b e)))

;(verify-path g1 
;   (map (lambda (x) (lookup-vertex x (vertices g1))) '(a b c d b e)))
; ==> #t

;(member? (car (cdr tl)) (exits (car tl) g1))
;(cdr (cdr (cdr (cdr (cdr (cdr tl))))))
  
;(verify-path g1 
;   (map (lambda (x) (lookup-vertex x (vertices g1))) '(a b c d e)))
; ==> #f
  
;; ----- Problem 2 -----
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;(label <labeled-edge>) => label of labeled-edge
;;ex: (label (make-labeled-edge a b l)) => l
;;
(defclass <labeled-edge> (<directed-edge>)
  (label :initarg :label :accessor label))

(define make-labeled-edge
  (lambda (a b l) ;a <vertex> b <vertex> l <obj>
    (make <labeled-edge> :start a :finish b :label l)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;(start-state <automaton>) => start-state of automaton
;;(final-states <automaton>) => list of final-states of automaton
;;    
(defclass <automaton> (<graph>)
  (start-state :initarg :start-state :accessor start-state)
  (final-states :initarg :final-states :accessor final-states)) 
;start-state <symbol> final-states <list>
;;note: all accessors that apply to graph apply to automaton
  
;; make-automaton takes four parameters.  
;; The first is a list of symbols of the form (v1 v2 v3 ...) which 
;;   becomes the list of vertices.
;; The second is a list of triples of the form 
;;   ((u1 u2 l1) (u3 u4 l2) ...) which becomes the list of labeled
;;   edges (with the u's symbols which represent vertices and the l's 
;;   objects which become the labels).
;; The third is a single symbol for the start state.
;; The fourth is a list of symbols that represent final states.

(define make-automaton
  (lambda (v-names e-list s-state f-states) 
    ;v-names <list>, e-list <list>, s-state <symbol>, f-states <list>
    (let* ((v (map make-vertex v-names))
           (create-labeled-edge 
              (lambda (name1 name2 label)
                (make-labeled-edge (lookup-vertex name1 v) 
                                   (lookup-vertex name2 v) 
                                   label))))
      (make <automaton>
            :vertices v
            :edges (map create-labeled-edge
                        (map first e-list)
                        (map second e-list)
                        (map third e-list))
            :start-state s-state
            :final-states f-states))))

(define dfa1
  (make-automaton '(a b c) 
	    '((a a 0) (a b 1) (b a 1) (b c 0) (c b 0) (c c 1))
            'a '(a)))

;;; ----- Problem 3 -----

(define has-state
  (lambda (state dfa)
    (if (member? state (name-vertices (vertices dfa)))
        #t
        #f)))

(define get-edges
  (lambda (state dfa)
    (filter
     (lambda (edge)
       (equal? state (name (start edge))))
     (edges dfa))))

(define get-symbol
  (lambda (state dfa symbol)
    (filter
     (lambda (weight)
       (equal? symbol (label weight)))
     (get-edges state dfa))))

(define one-symbol
  (lambda (state dfa symbol)
    (if (= 1 (length (get-symbol state dfa symbol)))
        #t
        #f)))

(define name-state
  (lambda (state dfa symbol)
    (name (finish (car (get-symbol state dfa symbol))))))
  

(define step-dfa
  (lambda (dfa state symbol)
    (if (has-state state dfa)
        (if (one-symbol state dfa symbol)
            (name-state state dfa symbol)
            #f)
        #f)))

    
(define step-dfa-2
  (lambda (dfa state-name symbol)
    (letrec
        ((loop
          (lambda (edges-lst exits-lst)
            (cond 
              ((not 
                (member? state-name 
                         (name-vertices (vertices dfa)))) #f)
              ((and 
                (equal? state-name (name (start (car edges-lst))))
                    (equal? symbol (label (car edges-lst))))
               (loop 
                (cdr edges-lst)
                (union exits-lst (list (finish (car edges-lst))))))
              (else
               (loop (cdr edges-lst) exits-lst))))))
      (loop (edges dfa) '()))))

(define step-dfa-3
  (lambda (dfa state-name symbol)
    (if (member? state-name (name-vertices (vertices dfa)))
        (letrec
            ((loop
              (lambda (edges-lst exits-lst)
                (if (equal? state-name 
                            (name (start (car edges-lst))))
                    (if (equal? symbol (label (car edges-lst)))
                        (loop 
                         (cdr edges-lst) 
                         (union exits-lst 
                                (list (finish (car edges-lst)))))
                        (loop (cdr edges-lst) exits-lst))
                    (loop (cdr edges-lst) exits-lst)))))
          (loop (edges dfa) '()))
        #f)))

(define step-dfa-4
  (lambda (dfa state-name symbol)
    (if (member? state-name (name-vertices (vertices dfa)))
        (let loop ((edges-lst (edges dfa)) (exits-lst '()))
          (if (equal? state-name (name (start (car edges-lst))))
              (if (equal? symbol (label (car edges-lst)))
                  (loop 
                   (cdr edges-lst) 
                   (union exits-lst 
                          (list (finish (car edges-lst)))))
                  (loop (cdr edges-lst) exits-lst))
              (loop (cdr edges-lst) exits-lst))))
    #f))
        

;(step-dfa dfa1 'd 0) 
;==> #f
;(step-dfa dfa1 'c 1)
;==> c
;(step-dfa dfa1 'a 0)
;==> a
;(step-dfa dfa1 'a 1)
;==> b
;(step-dfa dfa1 'a 2)
;==> #f

(define bad-dfa
  (make-automaton '(a b c) 
 	    '((a a 0) (a b 0) (b a 1) (b c 0) (c b 0) (c c 1))
            'a '(a)))

;(step-dfa bad-dfa 'a 0)
;==> #f

;; ----- Problem 4 -----

(define simulate-dfa
  (lambda (dfa lst)
    (letrec
        ((loop
          (lambda (state trip)
            (cond 
              ((null? trip)
               (member? state (final-states dfa)))
              (else
               (loop 
                (step-dfa dfa state (car trip)) 
                (cdr trip)))))))
      (loop (start-state dfa) lst))))

;(simulate-dfa dfa1 '(1 0 0 1)) 
;==> #t
;(simulate-dfa dfa1 '(1 0 1 1))
;==> #f

(define integer->binary
  (lambda (n)
    (cond ((eq? n 0) '())
	  (else (append (integer->binary (quotient n 2)) 
                        (list (if (even? n) 0 1)))))))
          
;(simulate-dfa dfa1 (integer->binary 12))
;==> #t
;(simulate-dfa dfa1 (integer->binary 10))
;==> #f

;; ----- Problem 5 -----

(define some-symbol
  (lambda (state dfa symbol)
    (if (< 0 (length (get-symbol state dfa symbol)))
        #t
        #f)))

(define name-states
  (lambda (state dfa symbol)
    (map
     (lambda (x)
       (name (finish x))) 
     (get-symbol state dfa symbol))))

(define step-nfa
  (lambda (nfa state symbol)
    (if (has-state state nfa)
        (if (some-symbol state nfa symbol)
            (name-states state nfa symbol)
            #f)
        #f)))

(define nfa1
  (make-automaton '(a b c d e)
	    '((a a 0) (a a 1) (a b 1) (a c 0) (b d 1) (c e 0)
	      (d d 0) (d d 1) (e e 0) (e e 1))
	    'a
	    '(d e)))
            
;(step-nfa nfa1 'f 0) 
;==> #f
;(step-nfa nfa1 'c 0)
;==> (e)
;(step-nfa nfa1 'a 0)
;==> (a c)
;(step-nfa nfa1 'a 1)
;==> (a b)
;(step-nfa nfa1 'a 2)
;==> #f

(define accumulate                                                                    
 (lambda (initial op l)                                                               
    (cond ((null? l) initial)                                                         
      (else                                                                           
        (op (car l) (accumulate initial op (cdr l)))))))  

(define nfa-next
  (lambda (nfa state symbol)
    (map
     (lambda (state1)
      (if (not (eq? #f (step-nfa nfa state1 symbol)))
          (step-nfa nfa state1 symbol)
          '()))
     state)))

(define (flatten lst)
  (cond 
    ((null? lst)
      empty) ; or '()
    ((list? (car lst))
      (append (flatten (car lst)) (flatten (cdr lst))))
    (else
      (cons (car lst) (flatten (cdr lst))))))

(define in-final-states
  (lambda (states-lst final-states)
    (letrec
        ((loop
          (lambda (score states)
            (cond
              ((null? states)
               (if (< 0 score)
                   #t
                   #f))
              (else
               (loop
                (+ score 
                   (if (member? (car states) final-states)
                     1
                     0))
                (cdr states)))))))
      (loop 0 states-lst))))
                 

(define simulate-nfa
  (lambda (dfa lst)
    (letrec
        ((loop
          (lambda (state trip)
            (cond 
              ((null? trip)
               (in-final-states state (final-states dfa)))
               ;display state)
              (else
               ;display state)))))
               (loop
                (flatten (nfa-next dfa state (car trip)))
                (cdr trip)))))))
      (loop 
       (step-nfa dfa 
                 (start-state dfa) 
                 (car lst)) 
       (cdr lst)))))

;(simulate-nfa nfa1 '(0 1))
;==> #f
;(simulate-nfa nfa1 '(1 0))
;==> #f
;(simulate-nfa nfa1 '(0 0))
;==> #t
;(simulate-nfa nfa1 '(1 1))
;==> #t
;(simulate-nfa nfa1 '(0 0 0))
;==> #t
;(simulate-nfa nfa1 '(1 1 1))
;==> #t


;; ----- Problem 6 -----

(define g2 (make-graph 
            '(a b c) 
            '((a b) (b a) (a c) (c a) (b c))))
(define g3 (make-graph 
            '(a b c d) 
            '((a b) (b c) (a c) (c b) (d b))))
(define g4 (make-graph 
            '(a b c d) 
            '((a b) (a c) (b a) (c a) (a d) (b c) (c b))))

(define path?
  (lambda (start end g)
    (letrec
        ((loop
          (lambda (visited visits)
            (cond
              ((eq? start end)
               #t)
              ((= 0 visits)
               ;display visited)
               (if (member? end visited)
                   #t
                   #f))
              ;((= visits (- (length (vertices g)) 1))
               ;display visited)
              (else
               (loop
                (flatten
                 (map
                  (lambda (entry)
                    (name-vertices 
                     (exits 
                      (lookup-vertex entry 
                                     (vertices g)) g)))
                  visited))
                (- visits 1)))))))
      (loop
       (list (append '() start))
       (+ (length (vertices g)) 2)))))
                  

;(path? 'a 'e g1) ;==> #t
;(path? 'd 'a g1) ;==> #f
;(path? 'a 'c g2) ;==> #t
;(path? 'c 'b g2) ;==> #t
;(path? 'd 'd g3) ;==> #t
;(path? 'a 'd g3) ;==> #f
;(path? 'b 'd g4) ;==> #t

;; ----- Problem 7 -----

;; there? checks if a journey e.g., '(a b c) fulfills
;; the start and end requirements. If the start is 'a
;; and end is 'c, it returns #t. If the start and/or
;; end is anything else, it returns #f.

(define there?
  (lambda (start end journey)
    (cond
      ;((= 1 (length journey))
      ; #f)
      ((not 
        (eq? start (car journey))) 
       #f)
      ((not 
        (eq? end 
             (list-ref journey 
                       (- (length journey) 1)))) 
       #f)
      (else #t))))

;; is-there? inspects multiple routes and returns #t
;; if there is at least one route among the routes that
;; meet the start and end requirements.
       
(define is-there?
  (lambda (start end lst g)
    (letrec
        ((loop
          (lambda (found lst)
            (cond
              ((eq? found #t)
               #t)
              ((null? lst)
               #f)
              ((not (list? (car lst)))
               #f)
              (else
               (loop 
                (there? start end (car lst)) 
                (cdr lst)))))))
      (loop #f lst))))
    
;; Given a journey e.g. '(a b c), last-exit takes the last vertice 
;; and finds the exits for it. For the case of g1, that would be 'd.

(define last-exit
  (lambda (lst g)
    ;(display lst)))
    (name-vertices 
     (exits 
      (lookup-vertex 
       (list-ref lst 
                 (- (length lst) 1)) 
       (vertices g)) g))))

;; Given a journey e.g., '(a b c), ride creates the possible routes
;; that the journey could take. So, in the case of g1, '(a b c)
;; returns '(a b c d).
;; In the case where there are multiple outcomes for one route e.g., '(a b),
;; ride returns multiple routes '(a b c) and '(a b e).
;; ride can also take in multiple routes and return the total routes
;; that are possible outcomes.(find-path 'a 'e g1)(find-path 'a 'e g1)
            
(define ride
  (lambda (lst g)
    (cond
      ;((= (length lst) 1)
      ; 
      ;((list? lst)
      ; (display (car lst)))
      ;((list? (car lst))
       ;(append (ride (car lst) g) (ride (cdr lst) g)))
      ((< (length (last-exit lst g)) 2)
       append lst (last-exit lst g))
      ((> (length (last-exit lst g)) 1)
       (map
        (lambda (destination)
          (append lst (list destination)))
        (last-exit lst g))))))

(define find-path
  (lambda (start end g)
    (letrec
        ((loop
          (lambda (check journey distance)
            (cond
              ((eq? check #f)
               (if (path? start end g)
                   (loop #t journey distance)
                   #f))
              ((is-there? start end journey g)
                (car (filter (is-there? start end journey g) journey)))
              ((= 0 distance)
               #f)
              (else
               ;(display check) (display journey) (display distance))))))
               (loop
                check
                (ride journey g)
                (- distance 1)))))))
      (loop 
       #f 
       (list start) 
       (+ (length (vertices g)) 10)))))
       
                
               
;(find-path 'a 'e g1)
;(name-vertices (find-path 'a 'e g1)) ==> (a b e)
; (find-path 'd 'a  g1)                   ==> #f
; (name-vertices (find-path 'a 'c g2)) ==> (a c) or (a b c)
; (name-vertices (find-path 'c 'b g2)) ==> (c a b)
; (name-vertices (find-path 'd 'd g3)) ==> (d)
; (find-path 'a 'd g3)                    ==> #f
; (name-vertices (find-path 'b 'd g4)) ==> (b a d)
