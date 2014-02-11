;;;
;;; Recursive functions to compute Fibonacci numbers
;;;
;;; Precondition:  k >= 0

;; Simple recursion, not tail-recursive
;; VERY inefficient, too, due to the double recursion.
;; (more on this later in the course!)
;;
(define fib1
  (lambda ((k <integer>))
    (if (< k 2)
	k
	(+ (fib1 (- k 1))
	   (fib1 (- k 2))))))

;; Tail-recursive:  Using a helper function
(define fib2-hf
  (lambda ((k <integer>))
    (letrec ((loop (lambda (count last prev)
		     (if (= count k)
			 last
			 (loop (+ count 1)
			       prev
			       (+ last prev))))))
      (loop 0 0 1))))

;; Tail-recursive:  Using named LET
(define fib2-nl
  (lambda ((k <integer>))
    (let loop ((count 0) (last 0) (prev 1))
      (if (= count k)
	  last
	  (loop (+ count 1)
		prev
		(+ last prev))))))
