;;;
;;;
;;;
;;; Example solutions for Problem Set 1 of CS 230, Spring 2014
;;; Pull in the definitions for the drawing window and stuff
(require racket/base)
(require (file "cs230-graphics.scm"))

;; These are the original definitions of "side" and "snowflake"
;; provided with the assignment.
(define side
  (lambda ((length <real>) (heading <real>) (level <integer>))
    (if (zero? level)
        (drawto heading length)
        (let ((len/3 (/ length 3))
              (lvl-1 (- level 1)))
          (side len/3 heading lvl-1)
          (side len/3 (- heading pi/3) lvl-1)
          (side len/3 (+ heading pi/3) lvl-1)
          (side len/3 heading lvl-1)))))

(define snowflake:0
  (lambda ((length <real>) (level <integer>))
    (side length 0.0 level)
    (side length (* 2 pi/3) level)
    (side length (- (* 2 pi/3)) level)))

;; ----- Problem 1 -----
(define flip-side
  (lambda ((length <real>) (heading <real>) (level <integer>))
    (if (zero? level)
        (drawto heading length)
        (let ((dist (/ length (* 2 (sqrt 2))))
              (lvl-1 (- level 1)))
          (flip-side dist (- heading pi/4) lvl-1)
          (flip-side (* 2 dist) (+ heading pi/4) lvl-1)
          (flip-side dist (-  heading pi/4) lvl-1)))))

(define square-snowflake:1
  (lambda ((length <real>) (level <integer>))
    (flip-side length 0 level)
    (flip-side length pi/2 level)
    (flip-side length (- pi) level)
    (flip-side length (- pi/2) level)))

;; ----- Problem 2 -----
(define snowflake:2
  (lambda ((length <real>) (level <integer>) (generator <function>))
    (generator length 0.0 level)
    (generator length (* 2 pi/3) level)
    (generator length (- (* 2 pi/3)) level)))

(define square-snowflake:2
  (lambda ((length <real>) (level <integer>) (generator <function>))
    (generator length 0 level)
    (generator length pi/2 level)
    (generator length (- pi) level)
    (generator length (- pi/2) level)))

;; ----- Problem 3 -----
(define side-inv
  (lambda ((length <real>) (heading <real>) 
           (level <integer>) (inverter <function>))
    (if (zero? level)
        (drawto heading length)
        (let ((len/3 (/ length 3))
              (lvl-1 (- level 1))
              (inv (inverter level)))
          (side-inv len/3 heading lvl-1 inverter)
          (side-inv len/3 (- heading (* inv pi/3)) lvl-1 inverter)
          (side-inv len/3 (+ heading (* inv pi/3)) lvl-1 inverter)
          (side-inv len/3 heading lvl-1 inverter)))))

(define snowflake-inv
  (lambda ((length <real>) (level <integer>) 
           (generator <function>) (inverter <function>))
    (generator length 0.0 level inverter)
    (generator length (* 2 pi/3) level inverter)
    (generator length (- (* 2 pi/3)) level inverter)))


;; ----- Problem 4 -----

;; This is the naive translation of the original, basically we just
;; return the length instead of drawing for the base case, and then
;; add up all the recursive cases.
(define side-length
  (lambda ((length <real>) (heading <real>)
           (level <integer>) (inverter <function>))
    (if (zero? level)
        length
        (let ((len/3 (/ length 3))
              (lvl-1 (- level 1))
              (inv (inverter level)))
          (+ (side-length len/3 heading lvl-1 inverter)
             (side-length len/3 (- heading (* inv pi/3)) lvl-1 inverter)
             (side-length len/3 (+ heading (* inv pi/3)) lvl-1 inverter)
             (side-length len/3 heading lvl-1 inverter))))))

;; This is moderately more clever, taking advantage of the fact 
;; that the sides are always the same length.  So, we compute 
;; one recursive call, and just multiply that value by 4 to get
;; the value for the whole level.
(define side-length-2
  (lambda ((length <real>) (heading <real>)
           (level <integer>) (inverter <function>))
    (if (zero? level)
        length
        (* 4 (side-length-2 (/ length 3) heading 
                            (- level 1) inverter)))))

;; This is just a driver for the above...again, the naive strategy
;; does the same thing as the original, except it adds up the results
;; too.
(define snowflake-length
  (lambda ((length <real>) (level <integer>)
           (generator <function>) (inverter <function>))
    (+ (generator length 0 level inverter)
       (generator length (* 2 pi/3) level inverter)
       (generator length (- (* 2 pi/3)) level inverter))))

;; Again, we can be more clever, knowing that the figure is symmetric
(define snowflake-length-2
  (lambda ((length <real>) (level <integer>)
           (generator <function>) (inverter <function>))
    (* 3 (generator length 0 level inverter))))

;; ----- end of solutions -----

;; Make the graphics window visible, and move the pen to the
;; center of the visible area...
(init-graphics 640 480)

;; Here there be dragons
