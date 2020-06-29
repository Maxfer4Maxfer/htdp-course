;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

#| Problem: Design a function that pluralizes a given word. |# 
#| (Pluralize means to convert the word to its plural form.) |# 
#| For simplicity you may assume that just adding s is enough |# 
#| to pluralize a word. |#

(check-expect (plural "apple") "apples")
(check-expect (plural "cat") "cats")

; String -> String
; returns a pluralize of a given word
(define (plural w) 
  (string-append w "s"))

