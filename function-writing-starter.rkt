;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

#| PROBLEM: |#
#| Write a function that consumes two numbers and produces the larger of the two. |# 

(define (mymax a b)
  (if (> a b)
      a
      b))

(mymax 1 2)
(mymax 2 1)
(mymax 3 3)
