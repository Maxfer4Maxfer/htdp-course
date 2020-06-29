;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; rocket-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; You are designing a program to track a rocket's journey as it descends 
; 100 kilometers to Earth. You are only interested in the descent from 
; 100 kilometers to touchdown. Once the rocket has landed it is done.
; 
; Design a data definition to represent the rocket's remaining descent. 
; Call it RocketDescent.
; 
;; RocketDescent is one of:
;;  - Boolean
;;  - Number[100..0)
;; interp. Boolean(false) means the rocket has not landed yet,
;; Number means distination from the ground.

(define RD1 false)
(define RD2 30)
(define RD3 true)

;#
(define (fn-for-rocket-descent rd)
  (cond [(false? rd) (...)]
        [(and (number? rd) (and (<= rd 100) (> rd 0))) (... rd)]
        [(not (false? rd)) (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct: false
;; - atomic not-distinct: Number
;; - atomic distinct: true

;; =================
;; Functions:

; 
; PROBLEM B:
; 
; Design a function that will output the rocket's remaining descent distance 
; in a short string that can be broadcast on Twitter. 
; When the descent is over, the message should be "The rocket has landed!".
; Call your function rocket-descent-to-msg.
; 

;; RocketDescent -> String
;; output the rocket's remaining descent distance in a short string 
;; that cat be broadcast on Twitter.
(check-expect (rocket-descent-to-msg false) "The rocket is very high.")
(check-expect (rocket-descent-to-msg 100) "The rocket is 100 km above the ground.")
(check-expect (rocket-descent-to-msg 1) "The rocket is 1 km above the ground.")
(check-expect (rocket-descent-to-msg true) "The rocket has landed!")

;(define (rocket-descent-to-msg rd) "")

(define (rocket-descent-to-msg rd)
  (cond [(false? rd) "The rocket is very high."]
        [(and (number? rd) (and (<= rd 100) (> rd 0)))
           (string-append 
                   (string-append "The rocket is " (number->string rd)) 
                   " km above the ground.")]
        [(not (false? rd)) "The rocket has landed!"]))
