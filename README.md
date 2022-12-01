<h1 align="center"> GEV Distributions </h1>

<h4 align="center"> The GEV Distributions in Racket. </h4>

<p align="center">
  <a href="https://pkgd.racket-lang.org/pkgn/package/gev-distribution">
    <img src="https://img.shields.io/github/downloads/HaeckGabriel/gev-distribution/total?label=Downloads&logo=Github&style=for-the-badge">
  </a>
  <a href="https://pkgd.racket-lang.org/pkgn/package/gev-distribution">
    <img src="https://img.shields.io/badge/Version-1.0.0-blueviolet?style=for-the-badge&logo=Racket">
  </a>
</p>

Basic Distributional Quantities (CDF, PDfF, Quantile and Random Generation) for the Gumbel, Fréchet, (inverse) Weibull and GEV Distributions.

<p align="center">
  <a href="#Installation">Installation</a> •
  <a href="#Details">Details</a>
</p>

## Installation
You can install the package with `raco pkg install gev-distribution`.

## Details

This package provides the cumulative distribution function (CDF), probability density function (PDF), quantile or inverse-CDF function and random generation for each of the four following distributions: the <i>Gumbel</i>, <i>Fréchet</i>, <i>Inverse Weibull</i> and the <i>GEV</i> (Generalized Extreme Value) distributions.

As such, the following functions are provided:
* `gumbel-cdf`, `gumbel-pdf`, `gumbel-quantile` and `gumbel-random` for the Gumbel distribution;
* `frechet-cdf`, `frechet-pdf`, `frechet-quantile` and `frechet-random` for the Fréchet distribution;
* `inv-weibull-cdf`, `inv-weibull-pdf`, `inv-weibull-quantile` and `inv-weibull-random` for the (inverse) Weibull distribution;
* `gev-cdf`, `gev-pdf`, `gev-quantile` and `gev-random` for the GEV distribution.

You can read more about the family of GEV Distributions [here](https://en.wikipedia.org/wiki/Generalized_extreme_value_distribution). 
