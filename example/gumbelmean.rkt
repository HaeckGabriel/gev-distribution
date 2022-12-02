;; Generating 100 values from a Gumbel distribution and get empirical mean.

#lang racket

(require gev-distribution)

;; set seed
(random-seed 10)


;; generates a vector of size n with each element a random gumbel-distribution value.
(define (rand-gumbel-vec n mu theta)
  (for/vector ((i n))
    (gumbel-random mu theta)))

(define test-vec (rand-gumbel-vec 100 0.5 2.0))

;; foldl version for vectors, used in predict() 
(define (vector-foldl f acc vec) ;; foldl for a vector
  (if (vector-empty? vec)
    acc
    (vector-foldl f
                  (f acc (vector-ref vec 0))
                  (vector-drop vec 1))))

;; get average
(define (average vec)
  (let ([lgt (vector-length vec)]
        [sum (vector-foldl + 0 vec)])
    (/ sum lgt)))

(average test-vec)
