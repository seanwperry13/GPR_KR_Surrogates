******************************************************************
Introduction:

Gaussian Processes Regression and" Kernel Regression are two methods of nonparametric modeling.
Given data in the form of paired lists, GPR and KR models are trained.
These surrogates are then iterated on test points from near the original data. 
This point cloud can be compared to the locus original data via Hausdorff Distance. 
The iterate point cloud should have small HD if the the data is drawn from a mostly time-invariant manifold. 
E.g. for a time series with an appropriate delay reconstruction.
Small HD is perhaps a good indicator of "similar" dynamics of the surrogate.
By similar we mean that the combinatorial approximation of the dynamics is identical 
 for a sufficiently well trained surrogate and the original for a given resolution parameter.

********************************************************************
