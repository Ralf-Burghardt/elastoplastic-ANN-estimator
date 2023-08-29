# ANN for estimation of elastic-plastic stress states

This repository contains a trained artificial neural network which is able to predict elastic-plastic stresses using linear-elastic pseudo stresses follwing the Ramberg and Osgood material law.
The artificial neural network is embedded in a framework that guarantees that physically reasonable results are obtained even for predictions outside of the training scope of the network. 
The underlying methodology is based on the analytical notch approximation formulas according to Neuber and Glinka. It exploits characteristics often mentioned in the literature e.g. [^1], namely that the Glinka rule leads to systematic underestimation and the Neuber rule in its extended form to systematic overestimation of the stress state. The results of these formulas are used as a limiter. In addition, the given implementation offers the possibility to switch this limiter to the two limiting cases "linear stress" and "linear strain".
This piece of software builds up on my PhD thesis [^2] (in german). An overview of the approach without the limiters can be found in [^3]. 

## Usage
To predict an elastic-plastic stress state simply use the following function call

```
[sigma_KNN] = perform_stress_prediction(E, K_, n_, spagra, h, kappa, sigma_e)
```

#### Parameters: 
E - Youngs modulus in MPa  
K_ - cyclic hardening coefficient in MPa  
n_ - cyclic hardening exponent  
spagra - relative stress gradient in mm^-1  
h - degree of multiaxiality ( ratio of hydrostatic stress to the von-Mises equivalent stress h = sig_H / sig_v)  
kappa - support potential   
sigma_e - linear-elastic computed von-Mises equivalent stress in MPa  

#### Returns
sigma_KNN - estimation of the elastic-plastic von-Mises stress in MPa  



Authors:  
Ralf Wuthenow  
Institute for Plant Engineering and Fatigue Analysis  
Clausthal University of Technology - Germany  

References:  
[^1]: Ye, D.; Matsuoka, S.; Suzuki, N.; Maeda, Y.: Further investigation of Neuber’s rule and the equivalent strain energy density (ESED) method. In: International journal of fatigue 26.5 (2004), S. 447–455. https://doi.org/10.1016/j.ijfatigue.2003.10.002.  
[^2]: Wuthenow, R.: Zur Abschätzung elastisch-plastischer Beanspruchungszustände mit analytischen Modellen und Methoden des Maschinellen Lernens. PhD Thesis. Clausthal-University of Technology, Clausthal-Zellerfeld; 2023.   
[^3]: Burghardt, R.; Wächter, M.; Masendorf, L.; Esderts, A.: Estimation of elastic–plastic notch strains and stresses using artificial neural networks. In: Fatigue & Fracture of Engineering Materials & Structures 44.10 (2021), S. 2718–2735. https://doi.org/10.1111/ffe.13540  
 
