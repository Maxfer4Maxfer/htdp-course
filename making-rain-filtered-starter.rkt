;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname making-rain-filtered-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; making-rain-filtered-starter.rkt

;
; PROBLEM:
;
; Design a simple interactive animation of rain falling down a screen. Wherever we click,
; a rain drop should be created and as time goes by it should fall. Over time the drops
; will reach the bottom of the screen and "fall off". You should filter these excess
; drops out of the world state - otherwise your program is continuing to tick and
; and draw them long after they are invisible.
;
; In your design pay particular attention to the helper rules. In our solution we use
; these rules to split out helpers:
;   - function composition
;   - reference
;   - knowledge domain shift
;
;
; NOTE: This is a fairly long problem.  While you should be getting more comfortable with
; world problems there is still a fair amount of work to do here. Our solution has 9
; functions including main. If you find it is taking you too long then jump ahead to the
; next homework problem and finish this later.
;
;


;; Make it rain where we want it to.

;; =================
;; Constants:

(define WIDTH  300)
(define HEIGHT 300)

(define SPEED 1)

(define DROP (ellipse 4 8 "solid" "blue"))

(define MTS (rectangle WIDTH HEIGHT "solid" "light blue"))

;; =================
;; Data definitions:

(define-struct drop (x y))
;; Drop is (make-drop Integer Integer)
;; interp. A raindrop on the screen, with x and y coordinates.

(define D1 (make-drop 10 30))

#;
(define (fn-for-drop d)
  (... (drop-x d)
       (drop-y d)))

;; Template Rules used:
;; - compound: 2 fields


;; ListOfDrop is one of:
;;  - empty
;;  - (cons Drop ListOfDrop)
;; interp. a list of drops

(define LOD1 empty)
(define LOD2 (cons (make-drop 10 20) (cons (make-drop 3 6) empty)))

#;
(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-drop (first lod))
              (fn-for-lod (rest lod)))]))

;; Template Rules used:
;; - one-of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Drop ListOfDrop)
;; - reference: (first lod) is Drop
;; - self reference: (rest lod) is ListOfDrop

;; =================
;; Functions:

;; ListOfDrop -> ListOfDrop
;; start rain program by evaluating (main empty)
(define (main lod)
  (big-bang lod
            (on-mouse handle-mouse)   ; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
            (on-tick  next-drops)     ; ListOfDrop -> ListOfDrop
            (to-draw  render-drops))) ; ListOfDrop -> Image


;; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
;; if mevt is "button-down" add a new drop at that position
(check-expect (handle-mouse empty 10 10 "button-down")  
              (cons (make-drop 10 10) empty))

(check-expect (handle-mouse (cons (make-drop 2 2) empty) 10 10 "button-down")  
              (cons (make-drop 10 10) (cons (make-drop 2 2) empty)))

(check-expect (handle-mouse (cons (make-drop 2 2) empty) 10 10 "button-up")  
              (cons (make-drop 2 2) empty))

#| (define (handle-mouse lod x y mevt) empty) ; stub |#
(define (handle-mouse lod x y mevt)
  (cond [(mouse=? mevt "button-down") (cons (make-drop x y) lod)]
        [else
         lod]))


;; ListOfDrop -> ListOfDrop
;; produce filtered and ticked list of drops
(check-expect (next-drops empty) empty)
(check-expect (next-drops (cons (make-drop 2 2) empty))  
              (cons (make-drop 2 (+ 2 SPEED)) empty))
(check-expect (next-drops (cons (make-drop 10 10) (cons (make-drop 2 2) empty)))
              (cons (make-drop 10 (+ 10 SPEED)) (cons (make-drop 2 (+ 2 SPEED)) empty)))
(check-expect (next-drops (cons (make-drop 2 2) (cons (make-drop 10 HEIGHT) empty)))
              (cons (make-drop 2 (+ 2 SPEED)) empty))
(check-expect (next-drops (cons (make-drop 2 HEIGHT) (cons (make-drop 10 HEIGHT) empty)))
              empty)

#| (define (next-drops lod) empty) ; stub |#

(define (next-drops lod) 
  (remove-empty (move-drops lod)))

;; ListOfDrop -> ListOfDrop
;; Move drops to the botton 
(check-expect (move-drops empty) empty)
(check-expect (move-drops (cons (make-drop 2 2) empty))  
              (cons (make-drop 2 (+ 2 SPEED)) empty))
(check-expect (move-drops (cons (make-drop 10 10) (cons (make-drop 2 2) empty)))
              (cons (make-drop 10 (+ 10 SPEED)) (cons (make-drop 2 (+ 2 SPEED)) empty)))

#| (define (move-drops lod) empty) ; stub |#

(define (move-drops lod)
  (cond [(empty? lod) empty]
        [else
         (cons (move-drop (first lod))
              (move-drops (rest lod)))]))

;; Drop -> Drop
;; Move drop to the botton with SPEED
(check-expect (move-drop (make-drop 2 2)) (make-drop 2 (+ 2 SPEED)))

#| (define move-drop d) empty) ; stub |#

(define (move-drop d)
  (make-drop (drop-x d)
       (+ (drop-y d) SPEED)))

;; ListOfDrop -> ListOfDrop
;; Remove drops that y parameter more when HEIGHT (a drop goes beyond the screen) 
(check-expect (remove-empty empty) empty)
(check-expect (remove-empty (cons (make-drop 2 2) empty))  
              (cons (make-drop 2 2) empty))
(check-expect (remove-empty (cons (make-drop 10 10) (cons (make-drop 2 (+ HEIGHT 1)) empty)))
              (cons (make-drop 10 10) empty))
(check-expect (remove-empty (cons (make-drop 2 (+ HEIGHT 1)) (cons (make-drop 10 (+ HEIGHT 1)) empty)))
               empty)

#| (define (remove-empty lod) empty) ; stub |#

(define (remove-empty lod)
  (cond [(empty? lod) empty]
        [else
         (if (beyond? (first lod))
             (remove-empty (rest lod))
             (cons (first lod) (remove-empty (rest lod)))
              )]))

;; Drop -> Boolean
;; Check if the drop's height more the HEIGHT 
(check-expect (beyond? (make-drop 2 2)) false)
(check-expect (beyond? (make-drop 2 (+ HEIGHT 1))) true)

#| (define beyond? d) false) ; stub |#

(define (beyond? d)
   (> (drop-y d) HEIGHT))


;; ListOfDrop -> Image
;; Render the drops onto MTS
(check-expect (render-drops empty) MTS)
(check-expect (render-drops (cons (make-drop 2 4) empty))  
              (place-image DROP 2 4 MTS))
(check-expect (render-drops (cons (make-drop 10 20) (cons (make-drop 2 2) empty)))
              (place-image DROP 10 20 (place-image DROP 2 2 MTS)))

;;(define (render-drops lod) MTS) ; stub

(define (render-drops lod)
  (cond [(empty? lod) MTS]
        [else
         (place-image
          DROP (drop-x (first lod)) (drop-y (first lod))
          (render-drops (rest lod)))]))

(main empty)