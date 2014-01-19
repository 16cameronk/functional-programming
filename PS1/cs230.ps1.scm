;;; Go to Language, Choose Language, Other Languages, Swindle, Full Swindle
;;; This may have to be done in cs230-graphics.scm as well
;;; cs230.ps1.scm


(require racket/base) ;;This allows the type system to work.
(require (file "cs230-graphics.scm")) 
;;Pull in the definitions for the drawing window and stuff. 
;; Assumes the file is in the same directory. 

;; Here are the procedures you will modify in the problem set
(define side
  (lambda ((length <real>) (heading <real>) (level <integer>))
    (if (zero? level)
        (drawto heading length)
        (let ((len/3 (/ length 3))
              (lvl-1 (- level 1)))
          (side len/3 heading lvl-1)
          (side len/3 (- heading PI/3) lvl-1)
          (side len/3 (+ heading PI/3) lvl-1)
          (side len/3 heading lvl-1)))))

(define snowflake:0
  (lambda ((length <real>) (level <integer>))
    (side length 0.0 level)
    (side length (* 2 PI/3) level)
    (side length (- (* 2 PI/3)) level)))

;; Problem 1
(define flip-side
  (lambda ((length <real>) (heading <real>) (level <integer>))
    (if (zero? level)
        (drawto heading length)
        (let ((len/sq2 (/ length (sqrt 2)))
              (2len/sq2 (* 2(/ length (sqrt 2))))
              (lvl-1 (- level 1)))
          (side len/sq2 (- heading PI/4) lvl-1)
          (side 2len/sq2 (+ heading 1) lvl-1)
          (side len/sq2 (- heading PI/4) lvl-1)))))

(define square-snowflake:1
  (lambda ((length <real>) (level <integer>))
    (side length 0.0 level)
    (side length PI/2 level)
    (side length (- PI) level)
    (side length (- PI/2) level)))

;; Problem 2

(define snowflake:2
  (lambda ((length <real>) (level <integer>) (fn <function>))
    (fn length 0.0 level)
    (fn length (* 2 PI/3) level)
    (fn length (- (* 2 PI/3)) level)))

(define square-snowflake:2
  (lambda ((length <real>) (level <integer>) (fn <function>))
    (fn length 0.0 level)
    (fn length PI/2 level)
    (fn length (- PI) level)
    (fn length (- PI/2) level)))

;; Problem 3

(define side-inv
  (lambda ((length <real>) (heading <real>) (level <integer>) (in <number>))
    (if (zero? level)
        (drawto heading length)
        (let ((len/3 (/ length 3))
              (lvl-1 (- level 1))
              (int (in))
          (= int 1)
          (if (positive? in)
              ((side-inv len/3 heading lvl-1)
               (side-inv len/3 (- heading PI/3) lvl-1)
               (side-inv len/3 (+ heading PI/3) lvl-1)
               (side-inv len/3 heading lvl-1))
              ((side-inv len/3 heading lvl-1)
               (side-inv len/3 (+ heading PI/3) lvl-1)
               (side-inv len/3 (- heading PI/3) lvl-1)
               (side-inv len/3 heading lvl-1)))))))

(define snowflake-inv
  (lambda ((length <real>) (level <integer>) (fn <function>) (inv <function>))
    ;(class-of (inv level))))
    ;(zero? (inv level))))
    ;(= 1 (inv level))))
    (fn length 0.0 level (inv level))
    (fn length (* 2 PI/3) level (inv level))
    (fn length (- (* 2 PI/3)) level (inv level))))

;; Make the graphics window visible, and put the pen somewhere useful
(init-graphics 500 500)
(clear)
(moveto 100 100)

;; Problem 1
;; (square-snowflake:1 150 3)

;; Problem 2
;; van Koch initiator with van Koch generator
;; (snowflake:2 200 3 side)
;; (snowflake:0 200 3)
;; van Koch initiator with flip-side generator
;; (snowflake:2 150 3 flip-side)
;; square initiator with van Koch generator
;; (square-snowflake:2 200 3 side)
;; square initiator with flip-side generator
;; (square-snowflake:2 150 3 flip-side)

;; Problem 3
;; Test, it should look like the original snowflake
(snowflake-inv 150 3 side-inv
               (lambda ((level <integer>)) 
	         (if (odd? level) 1 -1)))


