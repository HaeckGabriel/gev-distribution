#lang info

(define name "gev-distribution")

;; version
(define version "1.0")

(define deps '("base"
               "typed-racket"))

 ;; build-dependencies
(define build-deps '("scribble-lib"
                     "racket-doc"))

;; Documentation               
(define scribblings
  '(("scribblings/gev-distribution.scrbl" ())))
