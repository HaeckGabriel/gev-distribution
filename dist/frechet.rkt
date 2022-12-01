;; Fréchet Distribution

#lang typed/racket

(require racket/flonum)

(provide frechet-cdf
         frechet-pdf
         frechet-quantile
         frechet-random)

;; CDF of the Fréchet distribution:
;; $$ F(x) = \exp \left \{ - \left ( \frac{x - loc}{scale} \right)^{-\alpha} \right \} $$,
;; for shape > 0, $scale > 0$, $loc \in \mathbb{R}$ and $x > loc$ (default $loc = 0$)
(: frechet-cdf (-> Flonum Positive-Flonum Positive-Flonum Flonum Flonum))
(define (frechet-cdf x loc scale shape)
  (if (fl< x loc) (error "x must be larger than the location parameter at all times.")
   (let* ([y (fl/ (fl- x loc) scale)]
          [y_pow (flexpt y (- shape))])
     (flexp (- y_pow)))))

;; test
;(frechet-cdf 2.0 1.0 0.1 1.0)

;; Fréchet PDF
;; $$ f(x) = \frac{shape}{scale} \left(\frac{ x - loc }{scale}\right)^{-1 - shape} \exp \left \{ - \left( \frac{x - loc}{scale} \right)^{- shape}  \right \} $$
(: frechet-pdf (-> Flonum Positive-Flonum Positive-Flonum Flonum Flonum))
(define (frechet-pdf x loc scale shape)
  (if (fl< x loc) (error "x must be large than the location parameter at all times.")
    (let* ([y (fl/ (fl- x loc) scale)]
           [y_pow_one (flexp (- (flexpt y (- shape))))]
           [y_pow_two (flexpt y (- (+ 1 shape)))]
           [loc_scale (fl/ loc scale)])
      (fl* (fl* loc_scale y_pow_two) y_pow_one)))) ;; write macro to consider fl* on a list instead of having to break it down into two fl*..

;; test
;;(frechet-pdf 2.0 1.0 0.1 1.0)
;;
;; Fréchet quantile function.
;; $$ F^{-1}(x) = loc + scale \left(- \log x \right )^{- \frac{2}{shape}} $$
(: frechet-quantile (-> Flonum Positive-Flonum Positive-Flonum Flonum Flonum))
(define (frechet-quantile x loc scale shape)
  (if (or (fl< x 0.0) (fl> x 1.0)) (error "error Must consider a value between 0 and 1 for the quantile function.")
    (let* ([log_x (- (fllog x))]
           [pow_shape (- (/ 1 shape))]
           [expo (flexpt log_x pow_shape)])
      (fl+ (fl* scale expo) loc))))

;; test
;;(frechet-quantile 0.7 1.0 0.1 1.0)

;; random value of Fréchet distribution.
(: frechet-random (-> Positive-Flonum Positive-Flonum Flonum Flonum))
(define (frechet-random loc scale shape)
  (frechet-quantile (random) loc scale shape))

;; test
;;(frechet-random 1.0 0.1 1.0)
