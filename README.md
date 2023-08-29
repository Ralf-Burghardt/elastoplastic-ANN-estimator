# ANN for estimation of elastic-plastic stress states

This repository contains a trained artificial neural network which is able to predict elastic-plastic stresses using linear-elastic pseudo stresses follwing the Ramberg and Osgood material law.
The artificial neural network is embedded in a framework that guarantees that physically reasonable results are obtained even for predictions outside of the training scope of the network. 
The underlying methodology is based on the analytical notch approximation formulas according to Neuber and Glinka. It exploits characteristics often mentioned in the literature e.g. [1], namely that the Glinka rule leads to systematic underestimation and the Neuber rule in its extended form to systematic overestimation of the stress state. The results of these formulas are used as a limiter. In addition, the given implementation offers the possibility to switch this limiter to the two limiting cases "linear stress" and "linear strain".

#### Usage
To predict an elastic-plastic stress state simply use the following function call

Kerbnaeherung_KNN(E, K_, n_, spagra, h, kappa, sigma_e, randkorrektur, optimized, konservativeskappa)

Authors:
Ralf Wuthenow
Institute for Plant Engineering and Fatigue Analysis
Clausthal University of Technology - Germany

Literature:
[1]   Ye, D.; Matsuoka, S.; Suzuki, N.; Maeda, Y.: Further investigation of Neuber’s rule and the equivalent strain energy density (ESED) method. In: International journal of fatigue 26.5 (2004), S. 447–455. doi: https://doi.org/10.1016/j.ijfatigue.2003.10.002.

