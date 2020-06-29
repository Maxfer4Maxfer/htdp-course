;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname countdown-animation-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; 
; PROBLEM:
; 
; Design an animation of a simple countdown. 
; 
; Your program should display a simple countdown, that starts at ten, and
; decreases by one each clock tick until it reaches zero, and stays there.
; 
; To make your countdown progress at a reasonable speed, you can use the 
; rate option to on-tick. If you say, for example, 
; (on-tick advance-countdown 1) then big-bang will wait 1 second between 
; calls to advance-countdown.
; 
; Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; Once you are finished the simple version of the program, you can improve
; it by reseting the countdown to ten when you press the spacebar.
; 

(require 2htdp/image)
(require 2htdp/universe)

;; Countdown application

;; =================
;; Constants:
(define START-FROM 10)
(define INERVAL-BETWEEN-STEPS 1) ; in second

;; =================
;; Data definitions:

;; Counter is Natural
;; interp. counter determines how manu things remein before 0
(define C1 4)
(define C2 33)

#;
(define (fn-for-counter c)
  (... c))

;; Template rules used:
;; - atomic non-distinct: Natural


;; =================
;; Functions:

;; Counter -> Counter
;; start the world with counter  
;; 
(define (main c)
  (big-bang c                    ; c
            (on-tick   tock INERVAL-BETWEEN-STEPS)     ; Counter -> Counter
            (to-draw   render)))   ; Counter -> Image

;; Counter -> Counter
;; produce the next counter value
(check-expect tock 10) 9)
(check-expect tock 0) 0)

(define (tock c) 
  (if (> c 0)
       (- c 1)
       0))

;; Counter -> Image
;; render draw the user screen
(define (render c) 
  (text (number->string c) 36 "indigo"))

(main START-FROM)
