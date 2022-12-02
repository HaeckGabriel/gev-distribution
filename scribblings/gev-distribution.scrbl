#lang scribble/manual

@title{linear-regression}

@author[(author+email "Gabriel Haeck" "haeckgabriel@gmail.com")]

@defmodule[gev-distribution]

This package provides basic distributional quantities (i.e. CDF, PDF, Quantile and Random Generation) for the family of Extreme-Value Distributions; the Gumbel, Fréchet, (inverse) Weibull and the GEV Distribution.

@section{Installation}

To install this library, use:

@verbatim{raco pkg install gev-distribution}

You can keep the package up to date by using

@verbatim{raco pkg update gev-distribution}

@section{Using the Package}

The package gives access to four functions for each of the Gumbel, Fréchet, (inverse) Weibull and GEV distributions.
Those are: the Cumulative Distribution Function (CDF), Probability Density Function (PDF), Quantile or Inverse-CDF and random generation of the distribution.
The exact function provide are listed below.

@itemlist[@item{Gumbel: @tt{gumbel-cdf}, @tt{gumbel-pdf}, @tt{gumbel-quantile} and @tt{gumbel-random};}
          @item{Fréchet: @tt{frechet-cdf}, @tt{frechet-pdf}, @tt{frechet-quantile} and @tt{frechet-random};}
          @item{Inverse Weibull: @tt{inv-weibull-cdf}, @tt{inv-weibull-pdf}, @tt{inv-weibull-quantile} and @tt{inv-weibull-random};}
          @item{GEV: @tt{gev-cdf}, @tt{gev-pdf}, @tt{gev-quantile} and @tt{gev-random}.}]
