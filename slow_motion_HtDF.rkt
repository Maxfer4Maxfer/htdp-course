;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; STEP 1
; signature
;; Number -> Number

; purpose
;; produce 2 times the given number

; stub
; (define (double n) 0) |#

; STEP 2
; examples
(check-expect (double 3) 6)
(check-expect (double 4.2) 8.4)

; STEP 3
; template
; (define (double n) 
;  (... n))

; STEP 4
(define (double n) 
  (* 2 n))
