;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; =================
;; Constant
(define WIDTH 500)
(define HEIGHT 500)
(define ALIAN-ZONE-OF-APPEARENCE 50)
(define ALIAN-MAX-COUNT 8)
(define ALIAN-APPEARENCE-RATE 50)
(define FONT-SIZE-STAT 12)
(define STAT-PADDING 10)
(define SCREEN (empty-scene WIDTH HEIGHT))
(define GUARD-IMAGE (overlay/align "center" "bottom"
                                   (rectangle 10 5 "solid" "black")
                                   (rectangle 4 10 "solid" "black")))
(define ALIAN-IMAGE (rectangle 10 10 "solid" "black"))
(define MISSLE-IMAGE (rectangle 2 2 "solid" "black"))
(define GUARD-SPEED 5)
(define MISSLE-SPEED 10)
(define ALIAN-HORISONTAL-SPEED 2)
(define ALIAN-VERTICAL-SPEED 2)

;; =================
;; Data defenition

;; ----------------------Guard-----------------------------
;; Guard is Number 
;; interp. the guard position on the bottom of the SCREEN

(define GUARD-1 (/ WIDTH 4))
(define GUARD-2 (/ WIDTH 8)) 
(define GUARD-CENTER (/ WIDTH 2)) 

#;
(define (fn-for-guard g)
  (... g))

;; Template rules used:
;;  - atomic non-distinct: Natural

;; ----------------------Alian-----------------------------
(define-struct alian (x y d))
;; Alian is (make-alian Number Number Number)
;; interp. a alian at position x, y on the SCREEN 
;; with d as direction of movement. Possitive d shows that alian moving right
;; Negative d shows that alian moving left

(define ALIAN-1 (make-alian (/ WIDTH 2) 0 1))
(define ALIAN-2 (make-alian (/ WIDTH 4) (/ HEIGHT 4) -1))

#;
(define (fn-for-alian a)
  (... (alian-x a)     ;Number
       (alian-y a)
       (alian-d a)))   ;Number

;; Template rules used:
;;  - compound: 2 fields

;; ----------------------List of Alians-----------------------------
;; ListOfAlians if one of:
;; - empty
;; - (cons (make-alian Number Number) ListOfAlians)
;; interp. a list of alians

(define LOA-EMPTY empty)
(define LOA-1 (cons ALIAN-1 empty))
(define LOA-2 (list ALIAN-1 ALIAN-2))

#;
(define (fn-for-loa loa)
  (cond [(empty? loa) (...)]                   
        [else (... (first loa)                 
                   (fn-for-loa (rest loa)))])) 

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons (make-alian Number Number Number) ListOfAlians)
;;  - self-reference: (rest loa) is ListOfAlians

;; ----------------------Missle-----------------------------
(define-struct missle (x y))
;; Missle is (make-missle Number Number)
;; interp. a missle at position x, y on the SCREEN

(define MISSLE-1 (make-missle (/ WIDTH 2) (/ HEIGHT 4)))
(define MISSLE-2 (make-missle (/ WIDTH 4) (/ HEIGHT 2)))

#;
(define (fn-for-missle a)
  (... (missle-x a)     ;Number
       (missle-y a)))   ;Number

;; Template rules used:
;;  - compound: 2 fields

;; ----------------------List of Missles-----------------------------
;; ListOfMissles if one of:
;; - empty
;; - (cons (make-alian Number Number) ListOfMissles)
;; interp. a list of missles

(define LOM-EMPTY empty)
(define LOM-1 (cons MISSLE-1 empty))
(define LOM-2 (list MISSLE-2 MISSLE-2))

#;
(define (fn-for-lom lom)
  (cond [(empty? lom) (...)]                   
        [else (... (first lom)                 
                   (fn-for-lom (rest lom)))]))

;; Template rules used
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons (make-missle Number Number) ListOfMissles)
;;  - self-reference: (rest lom) is ListOfMissles

;; ----------------------List of Images-----------------------------
;; ListOfImages if one of:
;; - empty
;; - (cons Image ListOfImage)
;; interp. a list of images

(define LOI-EMPTY empty)
(define LOI-1 (cons GUARD-IMAGE empty))
(define LOI-2 (list MISSLE-IMAGE MISSLE-IMAGE))

#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]                   
        [else (... (first loi)                 
                   (fn-for-lom (rest loi)))])) 

;; Template rules used
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Image ListOfMissles)
;;  - self-reference: (rest loi) is ListOfImages

;; ----------------------Battlefield-----------------------------
(define-struct battlefield (g loa lom))
;; Battlefield is (make-battlefield Number ListOfAlians ListOfMissles)
;; interp. represens the battlefield with the guard, alians and missles

(define BATTLEFIELD-EMPTY (make-battlefield (/ WIDTH 2) empty empty))
(define BATTLEFIELD-1 (make-battlefield GUARD-1 
                                        (list 
                                          ALIAN-1 
                                          ALIAN-2) 
                                        (list 
                                          MISSLE-1
                                          MISSLE-2)))
(define BATTLEFIELD-2 (make-battlefield GUARD-CENTER
                                        (list 
                                          ALIAN-1 
                                          ALIAN-2) 
                                        empty))
(define BATTLEFIELD-3 (make-battlefield GUARD-2 
                                       empty
                                        (list 
                                          MISSLE-1
                                          MISSLE-2)))

#;
(define (fn-for-battlefield bf )
  (... (battlefield-g bf)     ;Number
       (battlefield-loa bf)   ;ListOfAlians
       (battlefield-lom bf))) ;ListOfMissles

;; Template rules used:
;;  - compound: 2 fields
;; =================
;; Functions:

;; big-bang options
;
;; on-tick
;       - add alians randomly on top of the screen
;       - calculate new positions of alians
;       - calculate new positions of missles
;       - check if any missles hit alians; if so delete the alian
;       - check if one of the aliases reach the bottom of the SCREEN
;; to-draw
;       - render the guard
;       - render allians
;       - render missles
;; on-key
;       - right arrow - move the guard right
;       - left arrow - move the guard left
;       - space - shot
;       - r - replay
;       - q - quite the game

;; Battlefield -> Battlefield
;; start the battlefield with the guard at the bottom of the SCREEN 
;;
(define (main bf)
  (big-bang bf                             ; Battlefield
            (on-tick   tock)               ; Battlefield -> Battlefield
            (to-draw   render-battlefield) ; Battlefield -> Image
            (on-key    handle-key)))       ; Battlefield KeyEvent -> Battlefield

;; Battlefield -> Battlefield
;; calculete next state of the battlefiled

;; there is no check-expect functions becouse there is a random part in the cheked function

;(define (tock bf) bf) ; stub

(define (tock bf )
  (make-battlefield 
   (battlefield-g bf)
   (add-alian-at-random-position-at-the-alian-zone
    (move-loa (battlefield-loa bf) (battlefield-lom bf)) )  
   (move-lom (battlefield-loa bf) (battlefield-lom bf))))

;; ListOfAlias -> ListOfAlias
;; if total count of alians less then ALIAN-MAX-COUNT add an alian to a random position somethere between the top of the screen and ALIAN-ZONE-APPEARENCE

;; there is no check-expect functions becouse there is a random part in the cheked function
  
;; (add-alian-at-random-position-at-the-alian-zone loa) loa)

(define (add-alian-at-random-position-at-the-alian-zone loa)
  (if (and (< (length loa) ALIAN-MAX-COUNT) (= (random ALIAN-APPEARENCE-RATE) 1))
      (cons
        (make-alian (random WIDTH) (random ALIAN-ZONE-OF-APPEARENCE) (if (= (random 2) 1) 1 -1))
        loa)
      loa))

;; ListOfAlias ListOfMissles -> ListOfAlias 
;; calculate next position of alians
;; if missles hit alias delete it and if an alians goes boyond the SCREEN also delete it
(check-expect (move-loa empty empty) empty)
(check-expect (move-loa 
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1) 
                (make-alian  (/ WIDTH 4) (/ HEIGHT 4) -1)) 
               (list 
                (make-missle (/ WIDTH 2) (+ (/ HEIGHT 2) MISSLE-SPEED))))
              (list 
               (make-alian (-  (/ WIDTH 4) ALIAN-HORISONTAL-SPEED) (+ (/ HEIGHT 4) ALIAN-VERTICAL-SPEED) -1)))
(check-expect (move-loa  
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1) 
                (make-alian  (/ WIDTH 4) (/ HEIGHT 4) -1)) 
               (list
                (make-missle (/ WIDTH 8) (+ (/ HEIGHT 8) MISSLE-SPEED))
                (make-missle (/ WIDTH 2) (+ (/ HEIGHT 2) MISSLE-SPEED))))
              (list 
               (make-alian (-  (/ WIDTH 4) ALIAN-HORISONTAL-SPEED) (+ (/ HEIGHT 4) ALIAN-VERTICAL-SPEED) -1)))
;(define (move-loa loa lom) loa); stub

(define (move-loa loa lom)
  (drop-loa-dead-or-beyond-screen (next-loa loa) (next-lom lom)))

;; ListOfAlians -> ListOfAlians
;; next position of alians
(check-expect (next-loa empty) empty) 
(check-expect (next-loa 
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1) 
                (make-alian  (/ WIDTH 4) (/ HEIGHT 4) -1)) ) 
              (list 
               (make-alian (+ (/ WIDTH 2) ALIAN-HORISONTAL-SPEED) (+ (/ HEIGHT 2)  ALIAN-VERTICAL-SPEED) 1)
               (make-alian (- (/ WIDTH 4) ALIAN-HORISONTAL-SPEED) (+ (/ HEIGHT 4) ALIAN-VERTICAL-SPEED) -1))) 
(check-expect (next-loa 
               (list 
                (make-alian (- WIDTH (+ 1 (/ (image-width ALIAN-IMAGE) 2))) (/ HEIGHT 2) 1)))
              (list 
               (make-alian (- (- WIDTH  (/ (image-width ALIAN-IMAGE) 2)) (- ALIAN-HORISONTAL-SPEED 1))  (+ (/ HEIGHT 2) ALIAN-VERTICAL-SPEED) -1)))
               
;(define (next-loa loa) loa) ;stub

(define (next-loa loa)
  (cond [(empty? loa) empty]                   
        [else (cons (move-alian (first loa))                 
                    (next-loa (rest loa)))]))

;; Alian -> Alian
;; Move an alian to the next position
(check-expect (move-alian (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1))
              (make-alian (+ (/ WIDTH 2) ALIAN-HORISONTAL-SPEED) (+ (/ HEIGHT 2)  ALIAN-VERTICAL-SPEED) 1))
(check-expect (move-alian (make-alian  (/ WIDTH 4) (/ HEIGHT 4) -1))
              (make-alian (- (/ WIDTH 4) ALIAN-HORISONTAL-SPEED) (+ (/ HEIGHT 4) ALIAN-VERTICAL-SPEED) -1))
(check-expect (move-alian (make-alian (- WIDTH (+ 1 (/ (image-width ALIAN-IMAGE) 2))) 0 1))
              (make-alian (- (- WIDTH  (/ (image-width ALIAN-IMAGE) 2)) (- ALIAN-HORISONTAL-SPEED 1))  (+ 0 ALIAN-VERTICAL-SPEED) -1))
(check-expect (move-alian (make-alian (+ (/ ALIAN-HORISONTAL-SPEED 2) (/ (image-width ALIAN-IMAGE) 2)) 0 -1)) 
              (make-alian (+ (/ ALIAN-HORISONTAL-SPEED 2) (/ (image-width ALIAN-IMAGE) 2)) (+ 0 ALIAN-VERTICAL-SPEED) 1))

;; (define (move-alian a) a) ;stub

(define (move-alian a)
    (if (= (alian-d a) 1)   ;; if moving right
        (if (> (+ (+ (alian-x a) (/ (image-width ALIAN-IMAGE) 2)) ALIAN-HORISONTAL-SPEED) WIDTH) ;check the right part of the SCREEN
            (make-alian (- (* WIDTH 2) (+ (+ (alian-x a) (* 2 (/ (image-width ALIAN-IMAGE) 2))) ALIAN-HORISONTAL-SPEED)) 
                        (+ (alian-y a) ALIAN-VERTICAL-SPEED)
                        -1)
            (make-alian (+ (alian-x a) ALIAN-HORISONTAL-SPEED) 
                        (+ (alian-y a) ALIAN-VERTICAL-SPEED)
                        1)
            )
        (if (< (- (- (alian-x a) (/ (image-width ALIAN-IMAGE) 2)) ALIAN-HORISONTAL-SPEED) 0) ;check the left part of the SCREEN
            (make-alian (+ ALIAN-HORISONTAL-SPEED (- (* 2 (/ (image-width ALIAN-IMAGE) 2)) (alian-x a))) 
                        (+ (alian-y a) ALIAN-VERTICAL-SPEED) 
                        1)
            (make-alian (-(alian-x a) ALIAN-HORISONTAL-SPEED)
                        (+ (alian-y a) ALIAN-VERTICAL-SPEED)
                        -1)
            )))

;; ListOfMissles -> ListOfMissles
;; next position of missles
(check-expect (next-lom empty) empty)
(check-expect (next-lom
               (list 
                (make-missle (/ WIDTH 2) (/ HEIGHT 2))
                (make-missle (/ WIDTH 4) (/ HEIGHT 4))))
              (list 
               (make-missle (/ WIDTH 2) (- (/ HEIGHT 2) MISSLE-SPEED ))
               (make-missle (/ WIDTH 4) (- (/ HEIGHT 4) MISSLE-SPEED ))))

;; (define (next-lom lom) lom) ;stub

(define (next-lom lom)
  (cond [(empty? lom) empty]                   
        [else (cons (move-missle (first lom))                 
                    (next-lom (rest lom)))]))

;; Missle -> Missle
;; next position of missle
(check-expect (move-missle (make-missle (/ WIDTH 2) (/ HEIGHT 2)))
              (make-missle (/ WIDTH 2) (- (/ HEIGHT 2) MISSLE-SPEED )))

;; (define (move-missle m) m) ;stub

(define (move-missle m)
  (make-missle  (missle-x m)    
                (- (missle-y m) MISSLE-SPEED)))  

;; ListOfAlians ListOfMissles -> ListOfAlians
;; intersect all missles and alians
;; if missles hit alias delete it and if an alians goes boyond the SCREEN also delete it
(check-expect (drop-loa-dead-or-beyond-screen   
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1) 
                (make-alian (/ WIDTH 4) (/ HEIGHT 4) -1)) 
               (list 
                (make-missle (/ WIDTH 8) (/ HEIGHT 8))
                (make-missle (/ WIDTH 2) (/ HEIGHT 2))))
              (list 
               (make-alian  (/ WIDTH 4) (/ HEIGHT 4) -1)))
(check-expect (drop-loa-dead-or-beyond-screen   
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1) 
                (make-alian (/ WIDTH 4) (/ HEIGHT 4) -1)) 
               (list 
                (make-missle (/ WIDTH 2) (/ HEIGHT 2))
                (make-missle (/ WIDTH 4) (/ HEIGHT 4))))
              empty)

;; (define (drop-loa-dead-or-beyond-screen loa lom) loa) ; stub

(define (drop-loa-dead-or-beyond-screen loa lom)
  (cond [(empty? loa) empty]                   
        [else 
         (if (drop-alian-dead-or-beyond-screen lom (first loa))
             (drop-loa-dead-or-beyond-screen (rest loa) lom)
             (cons (first loa) (drop-loa-dead-or-beyond-screen (rest loa) lom))
             )])) 

;; ListOfMissles Alian -> Boolean
;; returns True if the alian beyond the screen or one of the missles hit it
(check-expect (drop-alian-dead-or-beyond-screen   
               (list 
                (make-missle (/ WIDTH 2) (/ HEIGHT 2))) 
               (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1))
              true)
(check-expect (drop-alian-dead-or-beyond-screen   
               (list 
                (make-missle (/ WIDTH 8) (/ HEIGHT 8))
                (make-missle (/ WIDTH 2) (/ HEIGHT 2)))
               (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1))
              true)
(check-expect (drop-alian-dead-or-beyond-screen   
               empty
              (make-alian (/ WIDTH 2) (+ HEIGHT 1) 1)) 
              true)

;; (define (drop-alian-dead-or-beyond-screen lom a) false) ; stub
              
(define (drop-alian-dead-or-beyond-screen lom a)
  (cond [(> (alian-y a) HEIGHT) true]
        [(empty? lom) false]
        [else (if (missle-hits-alian-? a (first lom))
                  true
                  (drop-alian-dead-or-beyond-screen (rest lom) a))]))

;; ListOfAlias ListOfMissles -> ListOfMissles
;; calculate next position of missles
;; if missles hit alias delete it and if an missles goes boyond the SCREEN also delete it
(check-expect (move-lom empty empty) empty)
(check-expect (move-lom 
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1) 
                (make-alian  (/ WIDTH 4) (/ HEIGHT 4) -1)) 
               (list 
                (make-missle (/ WIDTH 2) (+ (/ HEIGHT 2) MISSLE-SPEED))
                (make-missle (/ WIDTH 8) (/ HEIGHT 8))))
              (list 
               (make-missle (/ WIDTH 8) (- (/ HEIGHT 8) MISSLE-SPEED))))
(check-expect (move-lom  
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1)) 
               empty)
              empty)

;(define (move-lom loa lom) lom); stub

(define (move-lom loa lom)
  (drop-lom-hit-or-beyond-screen (next-lom lom) (next-loa loa)))

;; ListOfMissles ListOfAlians -> ListOfMissles
;; intersect all missles and alians
;; if missles hit alias delete it
(check-expect (drop-lom-hit-or-beyond-screen
               (list 
                (make-missle (/ WIDTH 2) (/ HEIGHT 2))
                (make-missle (/ WIDTH 8) (/ HEIGHT 8)))
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1) 
                (make-alian  (/ WIDTH 4) (/ HEIGHT 4) -1)))
              (list 
               (make-missle (/ WIDTH 8) (/ HEIGHT 8))))
(check-expect (drop-lom-hit-or-beyond-screen
               empty
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1)))
              empty)

;;(define (drop-lom-hit-or-beyond-screen lom loa) lom) ; stub

(define (drop-lom-hit-or-beyond-screen lom loa)
  (cond [(empty? lom) empty]                   
        [else 
         (if (drop-missle-hit-or-beyond-screen loa (first lom))
             (drop-lom-hit-or-beyond-screen (rest lom) loa)
             (cons (first lom ) (drop-lom-hit-or-beyond-screen (rest lom) loa))
             )]))

;; ListOfAlians Missle -> Boolean
;; returns True if the missle beyond the screen or one of the alians hited
(check-expect (drop-missle-hit-or-beyond-screen   
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1))
               (make-missle (/ WIDTH 2) (/ HEIGHT 2))) true)
(check-expect (drop-missle-hit-or-beyond-screen   
               (list 
               (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1))
               (make-missle (/ WIDTH 4) (/ HEIGHT 4))) false)
(check-expect (drop-missle-hit-or-beyond-screen   
               (list 
                (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1))
               (make-missle (/ WIDTH 4) -1)) true)

;; (define (drop-missle-hit-or-beyond-screen loa m) false) ; stub
              
(define (drop-missle-hit-or-beyond-screen loa m)
  (cond [(< (missle-y m) 0) true]
        [(empty? loa) false]
        [else (if (missle-hits-alian-? (first loa) m)
                  true
                  (drop-missle-hit-or-beyond-screen (rest loa) m))]))


;; Alian Missle -> Boolean
;; return true if the missle hits the alian
(check-expect (missle-hits-alian-?
               (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1)
               (make-missle (/ WIDTH 2) (/ HEIGHT 2)))
              true)
(check-expect (missle-hits-alian-?
               (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1)
               (make-missle (/ WIDTH 4) (/ HEIGHT 2)))
              false)
                      
;; (define (missle-hits-alian-? a m) false)

(define (missle-hits-alian-? a m)
  (and
   (>  (missle-y m)   (- (alian-y a) (/ (image-height ALIAN-IMAGE) 2)))
   (<  (missle-y m)   (+ (alian-y a) (/ (image-height ALIAN-IMAGE) 2))) 
   (>  (missle-x m)   (- (alian-x a) (/ (image-width ALIAN-IMAGE) 2)))
   (<  (missle-x m)   (+ (alian-x a) (/ (image-width ALIAN-IMAGE) 2)))))

;; Battlefield -> Image
;; render Battlefiled

(check-expect (render-battlefield BATTLEFIELD-EMPTY) 
              (place-images
               (list
                (text (string-append "alians: " "0" " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black")
                GUARD-IMAGE)
               (list
                (make-posn (+ (/ (image-width  (text (string-append "alians: " "0" " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black")) 2) STAT-PADDING)
                           (+ (/ (image-height  (text (string-append "alians: " "0" " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black")) 2) STAT-PADDING)) 
                (make-posn (/ WIDTH 2) (+ (- HEIGHT (image-height GUARD-IMAGE)) 2)))
               SCREEN))
(check-expect (render-battlefield BATTLEFIELD-1) 
              (place-images
               (list
                (text (string-append "alians: " "2" " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black")
                ALIAN-IMAGE
                ALIAN-IMAGE
                MISSLE-IMAGE
                MISSLE-IMAGE
                GUARD-IMAGE)
               (list
                (make-posn (+ (/ (image-width  (text (string-append "alians: " "0" " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black")) 2) STAT-PADDING)
                           (+ (/ (image-height  (text (string-append "alians: " "0" " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black")) 2) STAT-PADDING)) 
                (make-posn (/ WIDTH 2) 0)
                (make-posn (/ WIDTH 4) (/ HEIGHT 4))
                (make-posn  (/ WIDTH 2) (/ HEIGHT 4))
                (make-posn  (/ WIDTH 4) (/ HEIGHT 2))
                (make-posn (/ WIDTH 4) (+ (- HEIGHT (image-height GUARD-IMAGE)) 2)))
               SCREEN))
(check-expect (render-battlefield BATTLEFIELD-2)
              (place-images
               (list
                (text (string-append "alians: " "2" " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black")
                ALIAN-IMAGE
                ALIAN-IMAGE
                GUARD-IMAGE)
               (list
                (make-posn (+ (/ (image-width  (text (string-append "alians: " "0" " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black")) 2) STAT-PADDING)
                           (+ (/ (image-height  (text (string-append "alians: " "0" " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black")) 2) STAT-PADDING)) 
                (make-posn (/ WIDTH 2) 0)
                (make-posn (/ WIDTH 4) (/ HEIGHT 4))
                (make-posn (/ WIDTH 2) (+ (- HEIGHT (image-height GUARD-IMAGE)) 2)))
               SCREEN))

; (define (render-battlefield bf) SCREEN) ;#stab

(define (render-battlefield bf)
  (place-images
   (cons (alian-stat-image (battlefield-loa bf))
         (list-images
          (battlefield-loa bf)
          (battlefield-lom bf)
          (battlefield-g bf)  
          ))
   (cons (make-posn
          (+ (/ (image-width (alian-stat-image (battlefield-loa bf))) 2) STAT-PADDING)
          (+ (/ (image-height (alian-stat-image (battlefield-loa bf))) 2) STAT-PADDING)) 
    (list-positions
    (battlefield-loa bf)
    (battlefield-lom bf)
    (battlefield-g bf)  
    )) 
   SCREEN))


;; ListOfAlians -> Image
;; return current count and max count of alians on the screen
(check-expect (alian-stat-image (list ALIAN-1 ALIAN-2)) 
                                (text (string-append "alians: " "2" " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black"))
                                
;(define (alian-stat-image loa) (rectangle 10 10 "solid" "black")) ; stub

(define (alian-stat-image loa)
  (text (string-append "alians: " (number->string (length loa)) " / " (number->string ALIAN-MAX-COUNT)) FONT-SIZE-STAT "black"))
  
;; ListOfAlians ListOfMissles Number -> ListOfImages
;; return list of images based on income list of different type of actors on the battlefield

(check-expect (list-images empty empty (/ WIDTH 2)) (list GUARD-IMAGE))
(check-expect (list-images empty (list MISSLE-1 MISSLE-2) (/ WIDTH 2)) (list MISSLE-IMAGE MISSLE-IMAGE GUARD-IMAGE))
(check-expect (list-images (list ALIAN-1 ALIAN-2) empty  (/ WIDTH 2)) (list ALIAN-IMAGE ALIAN-IMAGE GUARD-IMAGE))
(check-expect (list-images (list ALIAN-1 ALIAN-2) (list MISSLE-1 MISSLE-2) (/ WIDTH 2))
              (list ALIAN-IMAGE ALIAN-IMAGE MISSLE-IMAGE MISSLE-IMAGE GUARD-IMAGE))

;(define (list-images loa lom g) (list GUARD-IMAGE)) ;stub

(define (list-images loa lom g)
(append
 (alian-images loa)
 (missle-images lom)
 (list GUARD-IMAGE)
 ))

;; ListOfAlians -> ListOfImages
;; returs list with Alian's images for each alian in income ListOfAlians 

(check-expect (alian-images empty) empty)
(check-expect (alian-images (list ALIAN-1 ALIAN-2)) (list ALIAN-IMAGE ALIAN-IMAGE))

;; (define (alian-images loa) empty) ; stub

(define (alian-images loa)
  (cond [(empty? loa) empty]                   
        [else (cons ALIAN-IMAGE                 
                   (alian-images (rest loa)))])) 

;; ListOfMissles -> ListOfImages
;; returs list with Missle's images for each missle in income ListOfMissles

(check-expect (missle-images empty) empty)
(check-expect (missle-images (list MISSLE-1 MISSLE-2)) (list MISSLE-IMAGE MISSLE-IMAGE))

;; (define (missle-images lom) empty) ; stub

(define (missle-images lom)
  (cond [(empty? lom) empty]                   
        [else (cons MISSLE-IMAGE                 
                   (missle-images (rest lom)))])) 


;; ListOfAlians ListOfMissles Guard -> ListOfPositions
;; return list of positions based on income list of different type of actors on the battlefield
(check-expect (list-positions empty empty (/ WIDTH 2)) (list (make-posn (/ WIDTH 2) (+ (- HEIGHT (image-height GUARD-IMAGE)) 2))))
(check-expect (list-positions empty (list (make-missle 20 30) (make-missle 30 40)) (/ WIDTH 2))
              (list
               (make-posn 20 30) (make-posn 30 40)
               (make-posn (/ WIDTH 2) (+ (- HEIGHT (image-height GUARD-IMAGE)) 2))))
(check-expect (list-positions (list (make-alian 50 60 1) (make-alian 70 80 1)) empty  (/ WIDTH 2)) 
              (list
               (make-posn 50 60) (make-posn 70 80)
               (make-posn   (/ WIDTH 2) (+ (- HEIGHT (image-height GUARD-IMAGE)) 2))))
(check-expect (list-positions
               (list (make-alian 50 60 1) (make-alian 70 80 1))
               (list (make-missle 20 30) (make-missle 30 40)) (/ WIDTH 2)) 
              (list
               (make-posn 50 60) (make-posn 70 80)
               (make-posn 20 30) (make-posn 30 40)
               (make-posn (/ WIDTH 2) (+ (- HEIGHT (image-height GUARD-IMAGE)) 2))))

;(define (list-positions loa lom g) empty) ;stub

(define (list-positions loa lom g)
(append
 (alian-positions loa)
 (missle-positions lom)
 (list (make-posn  g (+ (- HEIGHT (image-height GUARD-IMAGE)) 2)))
 ))

;; ListOfAlians -> ListOfPositions
;; returs list with Alian's positions for each alian in income ListOfAlians
(check-expect (alian-positions empty) empty)
(check-expect (alian-positions (list (make-alian (/ WIDTH 2) (/ HEIGHT 2) 1) (make-alian (/ WIDTH 4) (/ HEIGHT 4) 1)))
              (list (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-posn (/ WIDTH 4) (/ HEIGHT 4))))

;; (define (alian-positions loa) empty) ; stub

(define (alian-positions loa)
  (cond [(empty? loa) empty]                   
        [else (cons (make-posn
                     (alian-x (first loa))
                     (alian-y (first loa)))
                    (alian-positions (rest loa)))])) 

;; ListOfMissles -> ListOfPositions
;; returs list with Missle's positions for each missle in income ListOfMissles

(check-expect (missle-positions empty) empty)
(check-expect (missle-positions (list (make-missle (/ WIDTH 2) (/ HEIGHT 2)) (make-missle (/ WIDTH 4) (/ HEIGHT 4))))
              (list (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-posn (/ WIDTH 4) (/ HEIGHT 4))))

;; (define (missle-positions lom) empty) ; stub

(define (missle-positions lom)
  (cond [(empty? lom) empty]                   
        [else (cons (make-posn 
                     (missle-x (first lom))
                     (missle-y (first lom)))
                    (missle-positions (rest lom)))]))


;; Battlefield KeyEvent -> Battlefield
;; handle keyboard key pressing

;;(define (handle-key bf kevt) BATTLEFIELD-EMPTY)

(define (handle-key bf kevt)
  (cond [(key=? "right" kevt) (guard-move-right bf)]
        [(key=? "left" kevt) (guard-move-left bf)]
        [(key=? " " kevt) (shoot-missle bf)]
        [else
         bf]))

;; Battlefield -> Battlefield
;; move the defender to the right
(check-expect (guard-move-right
               (make-battlefield (/ WIDTH 2) empty empty))
              (make-battlefield (+ (/ WIDTH 2) GUARD-SPEED) empty empty))
(check-expect (guard-move-right(make-battlefield (- WIDTH (/ (image-width GUARD-IMAGE) 2))empty empty))
              (make-battlefield (- WIDTH (/ (image-width GUARD-IMAGE) 2)) empty empty))

;; (define (guard-move-right bf) bf) 
 
(define (guard-move-right bf )
  (make-battlefield
        (if (> (+ (+ (battlefield-g bf) (/ (image-width GUARD-IMAGE) 2)) GUARD-SPEED) WIDTH)
            (- WIDTH GUARD-SPEED)   
            (+ (battlefield-g bf) GUARD-SPEED))
        (battlefield-loa bf)  
        (battlefield-lom bf)))

;; Battlefield -> Battlefield
;; move the defender to the left
(check-expect (guard-move-left
               (make-battlefield (/ WIDTH 2) empty empty))
              (make-battlefield (- (/ WIDTH 2) GUARD-SPEED) empty empty))
(check-expect (guard-move-left
               (make-battlefield (/ (image-width GUARD-IMAGE) 2) empty empty))
              (make-battlefield (/ (image-width GUARD-IMAGE) 2) empty empty))

;; (define (guard-move-left bf) bf) 
 
(define (guard-move-left bf )
  (make-battlefield
        (if (< (- (- (battlefield-g bf) (/ (image-width GUARD-IMAGE) 2)) GUARD-SPEED) 0)
            (+ 0 (/ (image-width GUARD-IMAGE) 2))
            (- (battlefield-g bf) GUARD-SPEED))
        (battlefield-loa bf)  
        (battlefield-lom bf)))

;; Battlefield -> Battlefield
;; add new a new missle at the guard position
(check-expect (shoot-missle
               (make-battlefield (/ WIDTH 2) empty (list MISSLE-1)))
               (make-battlefield (/ WIDTH 2) empty (cons (make-missle (/ WIDTH 2) (- HEIGHT (image-height GUARD-IMAGE))) (list MISSLE-1))))
               
;; (define (shoot-missle bf) bf) ;stub

(define (shoot-missle bf )
  (make-battlefield
        (battlefield-g bf)
        (battlefield-loa bf)  
        (cons (make-missle (battlefield-g bf) (- HEIGHT (image-height GUARD-IMAGE))) (battlefield-lom bf))))


(main BATTLEFIELD-EMPTY)