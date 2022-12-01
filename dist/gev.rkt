;; GEV Distribution (technically the Inverse Weibull Distribution)

#lang typed/racket

(require racket/flonum)

(provide gev-cdf
         gev-pdf
         gev-quantile
         gev-random)

;; $$ t(x) = \left( 1 + \zeta \left( \frac{x - loc}{ scale} \right) \right)^{- \frac{1}{\zeta}}$$ if $\zeta \neq 0$,
;; or $t(x) = \exp \left \{ - \frac{x - loc}{ scale}  \right \}$ if $\zeta = 0$.
(define-syntax-rule (t_func x loc scale zeta)
  (if (fl= 0.0 zeta)
    (let ([y (- (fl/ (fl- x loc) scale))])
      (flexp y))
    (let* ([y (fl/ (fl- x loc) scale)]
           [pow (- (fl/ 1.0 zeta))]
           [expr (fl+ 1.0 (fl* zeta y))])
      (flexpt expr pow))))

;; macro to check if $ 1 + \zeta \left( \frac{x - loc}{ scale} \leq 0$ (returns true) or not (returns false)
(define-syntax-rule (check_bound x loc scale zeta)
  (let* ([y (fl/ (fl- x loc) scale)]
         [expr (fl+ 1.0 (fl* zeta y))])
    (fl<= expr 0.0)))


;; CDF of GEV distribution.
;; $$ F(x) = \exp \left \{ - t_func(x) \right \} $$
(: gev-cdf (-> Flonum Flonum Positive-Flonum Flonum Flonum))
(define (gev-cdf x loc scale zeta)
  (if (check_bound x loc scale zeta) (error "Domain not respected.")
    (let ([val (t_func x loc scale zeta)])
       (flexp (- val)))))

;; test 
;;(gev-cdf 3.0 2.0 2.0 2.0)
;;(gev-cdf 3.0 2.0 2.0 0.0)

;; pdf of the GEV Distribution
;; $$ f(x) = \frac{1}{ scale } t_func(x)^{\zeta + 1} \cdot F(x) $$
(: gev-pdf (-> Flonum Flonum Positive-Flonum Flonum Flonum))
(define (gev-pdf x loc scale zeta)
  (if (check_bound x loc scale zeta) (error "Domain not respected.")
    (let* ([sc (fl/ 1.0 scale)]
           [t_val (t_func x loc scale zeta)]
           [pow (flexpt t_val (fl+ 1.0 zeta))])
      (fl* (fl* sc pow) (gev-cdf x loc scale zeta)))))


;; test 
;;(gev-pdf 3.0 2.0 2.0 2.0)
;;(gev-pdf 3.0 2.0 2.0 0.0)

;; quantile function of the GEV Distribution.
(: gev-quantile (-> Flonum Flonum Positive-Flonum Flonum Flonum))
(define (gev-quantile x loc scale zeta)
  (if (or (fl< x 0.0) (fl> x 1.0)) (error "error Must consider a value between 0 and 1 for the quantile function.")
    (if (fl= 0.0 zeta)
      (fl+ (fl* (- scale) (fllog (- (fllog x)))) loc)
      (let* ([constant (fl+ (- (fl/ scale zeta)) loc)]
             [mult (fl/ scale zeta)]
             [mult_2 (fl* mult (flexpt (- (fllog x))  (- zeta)))])
        (fl+ mult_2 constant)))))

;; test
;;(gev-quantile 0.2 2.0 2.0 2.0)
;;(gev-quantile 0.2 2.0 2.0 0.0)

;; random value from GEV distribution.
(: gev-random (-> Flonum Positive-Flonum Flonum Flonum))
(define (gev-random loc scale zeta)
  (gev-quantile (random) loc scale zeta))

;; test
;;(gev-random 2.0 2.0 2.0)
