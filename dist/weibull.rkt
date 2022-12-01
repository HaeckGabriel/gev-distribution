;; Weibull Distribution (technically the Inverse Weibull Distribution)

#lang typed/racket

(require racket/flonum)

(provide inv-weibull-cdf
         inv-weibull-pdf
         inv-weibull-quantile
         inv-weibull-random)

;; CDF of (inverse) Weibull
;; $$ F(x) = \exp \left \{ - \left (  - \left ( \frac{x - loc}{ scale } \right) \right)^{shape}  \right \} $$,
;; for $x < loc$, $loc \in \mathbb{R}$, $scale > 0$ and $shape > 0$.
(: inv-weibull-cdf (-> Flonum Flonum Positive-Flonum Positive-Flonum Flonum))
(define (inv-weibull-cdf x loc scale shape)
  (if (fl> x loc) (error "x value must be lower than location value.")
    (let* ([y (fl/ (fl- x loc) scale)]
           [y_pow (flexpt (- y) shape)])
      (flexp (- y_pow)))))

;; test
;;(inv-weibull-cdf 1.0 2.0 2.0 2.0)

;; PDF of (inverse) Weibull
;; $$ f(x) = \frac{shape}{scale} \left ( - \frac{x - loc}{scale} \right)^{shape -1} \cdot F(x) $$
(: inv-weibull-pdf (-> Flonum Flonum Positive-Flonum Positive-Flonum Flonum))
(define (inv-weibull-pdf x loc scale shape)
  (if (fl> x loc) (error "x value must be lower than location value.")
    (let* ([y (- (fl/ (fl- x loc) scale))]
           [y_pow (flexpt y (- shape 1))]
           [sh-sc (fl/ shape scale)]
           [y-sh-sc (fl* y_pow sh-sc)])
      (fl* y-sh-sc (inv-weibull-cdf x loc scale shape)))))

;; test
;;(inv-weibull-pdf 1.0 2.0 2.0 2.0)

;; Quantile function of the (inverse) Weibull
;; $$ F^{-1}(x) = - scale \cdot \left(\log x  \right)^{\frac{1}{shape}} + loc $$
(: inv-weibull-quantile (-> Flonum Flonum Positive-Flonum Positive-Flonum Flonum))
(define (inv-weibull-quantile x loc scale shape)
   (if (or (fl< x 0.0) (fl> x 1.0)) (error "error Must consider a value between 0 and 1 for the quantile function.")
     (let* ([log_x (- (fllog x))]
            [pow_shape (/ 1 shape)]
            [expo (flexpt log_x pow_shape)]
            [mult_expo (fl* (- scale) expo)])
       (fl+ mult_expo loc))))

;; test
;;(inv-weibull-quantile 0.5 2.0 2.0 2.0)

;; random value of (inverse) Weibull distribution.
(: inv-weibull-random (-> Flonum Positive-Flonum Positive-Flonum Flonum))
(define (inv-weibull-random loc scale shape)
  (inv-weibull-quantile (random) loc scale shape))

;; test
;;(inv-weibull-random 2.0 2.0 2.0)
