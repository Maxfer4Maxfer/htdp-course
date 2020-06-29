;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname image-area-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;
; PROBLEM:
;
; DESIGN a function called image-area that consumes an image and produces the
; area of that image. For the area it is sufficient to just multiple the image's
; width by its height.  Follow the HtDF recipe and leave behind commented
; out versions of the stub and template.
;

; Image -> Number  BAD
; Image -> Natural GOOD
; produce area of the given image. 
; area is calculated as multiplication width and height of the image.
(check-expect (image-area (rectangle 10 10 "solid" "blue")) 100)
(check-expect (image-area (circle 2 "solid" "green")) 16)

(define (image-area img)
   (* (image-height img)
      (image-width img)))
