;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-light-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; traffic-light-starter.rkt

;; LightState is one of:
;;  - "red"
;;  - "yellow"
;;  - "green"
;; interp. the color of a traffic light

;; <examples are redundant for enumerations>
 
#;
(define (fn-for-light-state ls)
  (cond [(string=? "red" ls) (...)]
        [(string=? "yellow" ls) (...)]
        [(string=? "green" ls) (...)]))
;; Template rules used:
;;  - one of: 3 cases
;;  - atomic distinct: "red"
;;  - atomic distinct: "yellow"
;;  - atomic distinct: "green"


;; =================
;; Functions:

;; WS -> WS
;; start the world with ...
;; 
(define (main ws)
  (big-bang ws                   ; WS
            (on-tick   tock)     ; WS -> WS
            (to-draw   render)   ; WS -> Image
            (on-mouse  change-ls-by-mouse)      ; WS Integer Integer MouseEvent -> WS
            (on-key   change-ls-by-key)))    ; WS KeyEvent -> WS

;; WS -> WS
;; produce the next ...
(define (tock ws)
  ws)


;; WS -> Image
;; render ... 
(define (render ls)
  (cond [(string=? "red" ls) (circle 10 "solid" "red" )]
        [(string=? "yellow" ls) (circle 10  "solid" "yellow")]
        [(string=? "green" ls) (circle 10 "solid"  "green")]))

;; WS KeyEvent -> WS
(define (change-ls-by-key ws ke)
  (cond [(key=? ke " ")
        (change-ls ws)]
        [else 
         ws]))

; WS Integer Integer MouseEvent -> WS
(define (change-ls-by-mouse ws x y me)
  (cond [(mouse=? me "button-down") (change-ls ws)]
        [else
         ws]))

(define (change-ls ls)
  (cond [(string=? "red" ls) "yellow"]
        [(string=? "yellow" ls) "green"]
        [(string=? "green" ls) "red"]))


(main "red")