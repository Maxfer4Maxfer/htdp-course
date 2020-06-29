;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;
; PROBLEM:
;
; DESIGN function that consumes a string and determines whether its length is
; less than 5.  Follow the HtDF recipe and leave behind commented out versions
; of the stub and template.
;

; String -> Boolean
; produce true if length of str is less than 
; determins is the given string less than 5.
; return true if less and false if greater or equal

(check-expect (less5? "max") true)
(check-expect (less5? "maximim") false)
(check-expect (less5? "12345") false)


(define (less5? str) 
  (< (string-length str) 5))


