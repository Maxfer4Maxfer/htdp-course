;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

#| PROBLEM: |#

#| Use the DrRacket square, beside and above functions to create an image like this one: |#

#| If you prefer to be more creative feel free to do so. You can use other DrRacket image |#
#| functions to make a more interesting or more attractive image. |#

(define YC (rectangle 20 20 "solid" "yellow"))
(define BC (rectangle 20 20 "solid" "blue"))

(above (beside BC YC)
       (beside YC BC))
