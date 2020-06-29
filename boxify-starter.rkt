;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;
; PROBLEM:
;
; Use the How to Design Functions (HtDF) recipe to design a function that consumes an image,
; and appears to put a box around it. Note that you can do this by creating an "outline"
; rectangle that is bigger than the image, and then using overlay to put it on top of the image.
; For example:
;
; (boxify (ellipse 60 30 "solid" "red")) should produce .
;
; Remember, when we say DESIGN, we mean follow the recipe.
;
; Leave behind commented out versions of the stub and template.
;

; Image -> Image
; Produce an image with the given image with a box around it.

(check-expect (boxify (ellipse 60 30 "solid" "red")) 
              (overlay (ellipse 60 30 "solid" "red")
                      (rectangle 60 30 "outline" "black")))

(define (boxify img)
        (overlay img
                 (rectangle 
                   (image-width img)
                   (image-height img)
                   "outline"
                   "black")))
