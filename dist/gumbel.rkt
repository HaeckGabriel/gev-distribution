;; Gumbel Distribution

#lang typed/racket

(require racket/flonum)

(provide gumbel-cdf
         gumbel-pdf
         gumbel-quantile
         gumbel-random)

;; CDF of gumbel distribution: $F(x) = \exp \left \{ - \exp \left \{- \frac{x - \mu}{\theta}  \right \} \right \} $
;; for $\theta > 0$ and $\mu \in \mathbb{R}$
(: gumbel-cdf (-> Flonum Positive-Flonum Flonum Flonum))
(define (gumbel-cdf x mu theta)
            (let* ([y (fl/ (fl- x mu) theta)]
                   [exp_y (flexp (- y))])
              (flexp (- exp_y))))

;; test
;;(gumbel-cdf 1.77 0.5 2.0)

;; to be able to do (fl*3 a b c)... for some reason it only takes 2 arguments (not updated version?)
(define-syntax-rule (fl*3 a b c)
  (fl* a (fl* b c)))

;; PDF of the Gumbel distribution.
;; $f(x) = \frac{1}{\theta} \exp \left \{- \frac{x - \mu}{\theta} \right \} \exp \left \{- \exp \left \{ - \frac{x - \mu}{\theta} \right \} \right \}$
(: gumbel-pdf (-> Flonum Positive-Flonum Flonum Flonum))
(define (gumbel-pdf x mu theta)
  (let* ([y (fl/ (fl- x mu) theta)]
         [exp_y (flexp (- y))])
    (fl*3 (/ 1 theta) exp_y (flexp (- exp_y)))))

;; test
;;(gumbel-pdf 0.6 0.5 2.0)

;; Quantile function of the Gumbel Distributions.
;; $F^{-1}(x) = \mu - \theta \log \left ( - \log \left ( - \frac{x - \mu }{ \theta } \right ) \right )$
(: gumbel-quantile (-> Flonum Positive-Flonum Flonum Flonum))
(define (gumbel-quantile x mu theta)
  (if (or (fl< x 0.0) (fl> x 1.0)) (error "error Must consider a value between 0 and 1 for the quantile function.")
    (let* ([log_x (fllog x)]
           [mult_log (fl* theta (fllog (- log_x)))])
        (fl- mu mult_log))))

;; test
;;(gumbel-quantile 0.1 0.5 2.0)

;; generate ONE random value of the gumbel distribution
;; basically feed a random value from Uniform(0,1) in the quantile function.
;; can always set a seed with (random-seed k) to test for consistency in results.
;; (see https://docs.racket-lang.org/reference/generic-numbers.html#%28def._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._random%29%29)
(: gumbel-random (-> Positive-Flonum Flonum Flonum))
(define (gumbel-random mu theta)
  (gumbel-quantile (random) mu theta))

;; test
;;(gumbel-random 0.5 2.0)
