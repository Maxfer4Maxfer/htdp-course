;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(sqrt (+ (sqr 3) (sqr 4)))

(sqrt 2)

; the same
(/ (+ 4 6.2 -12) 3)
(/ (+ -8 6.2) 3)
-0.6

; string
"apple"
(string-append "Ada" " " "Lovelace")
(string-length "apple")
(substring "Caribou" 2 4)
(substring "0123456789" 2 4)

; image
(require 2htdp/image)

(circle 10 "solid" "red")
(rectangle 30 60 "outline" "blue")
(text "hello" 24 "orange")

(above (circle 10 "solid" "red")
       (circle 20 "solid" "yellow")
       (circle 30 "solid" "green"))

(beside (circle 10 "solid" "red")
        (circle 20 "solid" "yellow")
        (circle 30 "solid" "green"))

(overlay (circle 10 "solid" "red")
         (circle 20 "solid" "yellow")
         (circle 30 "solid" "green"))

; constant
(define WIDTH 400)
(define HEIGHT 400)

(* WIDTH HEIGHT)

; function
(define (bulb c)
  (circle 40 "solid" c))

(bulb "purple")
(bulb (string-append "re" "d"))

(above (bulb "red")
       (bulb "yellow")
       (bulb "green"))

(> WIDTH HEIGHT)
(>= WIDTH HEIGHT)
(= 1 1)
(< 1 1)
(<= 1 1)
(string=? "foo" "bar")

(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 10 20 "solid" "blue"))

(<= (image-width I1)
   (image-width I2))

(if (< (image-width I1)
       (image-height I1))
    "tail"
    "wide")

(and (> (image-height I1) (image-height I2))
     (< (image-width I1) (image-width I2)))
