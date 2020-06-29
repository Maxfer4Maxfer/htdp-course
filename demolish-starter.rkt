;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; demolish-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; You are assigned to develop a system that will classify 
; buildings in downtown Vancouver based on how old they are. 
; According to city guidelines, there are three different classification levels:
; new, old, and heritage.
; 
; Design a data definition to represent these classification levels. 
; Call it BuildingStatus.
; 
;; BuildingStatus is one of:
;; - "new"
;; - "old"
;; - "heritage"
;; interp. the classification of buildings age in downtown Vancouver based on
;; the city guidelines
;
;; <example are redundant for enumerations>

#;
(define (fn-for-building-status bs)
  (cond [(string=? "new" bs) (...)]
        [(string=? "old" bs) (...)]
        [(string=? "heritage" bs) (...)]))

;; Template rules used:
;;  - one of: 3 cases
;;  - atomic distinct: "new"
;;  - atomic distinct: "old"
;;  - atomic distinct: "heritage"

;; =================
;; Functions:

; 
; PROBLEM B:
; 
; The city wants to demolish all buildings classified as "old". 
; You are hired to design a function called demolish? 
; that determines whether a building should be torn down or not.
; 

;; BuildingStatus -> Boolean
;; determine should be bulding be demolished 
;; produce true if the given buildingstatus is equal to "old"

(check-expect (demolish? "new") false)
(check-expect (demolish? "old") true)
(check-expect (demolish? "heritage") false)

;; (define (demolish? bs) false) |#
(define (demolish? bs)
  (string=? "old" bs))
