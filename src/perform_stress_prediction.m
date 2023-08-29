function [sigma_ANN, was_limited] = perform_stress_prediction(E, K_, n_, ...
                                                        spagra, h, ...
                                                        kappa, sigma_e,...
                                                        limiter, ...
                                                        optimized, ...
                                                        conservative)
% Main function to calculate an elastic-plastic stress using the trained
% artificial neural network
% 
% [sigma_ANN, is_limited] = perform_stress_prediction(E, K_, n_, ...
%                                                spagra, h, ...
%                                                kappa, sigma_e,...
%                                                randkorrektur, ...
%                                                optimized, ...
%                                                konservativeskappa)
% 
%Parameter:
%   E             - Youngs modulus in MPa   
%   K_            - cyclic hardening coefficient in MPa
%   n_            - cyclic hardening exponent 
%   spagra        - relative stress gradient in 1/mm
%   h             - degree of multiaxiality ( ratio of hydrostatic stress to the von-Mises equivalent stress h = sig_H / sig_v) 
%   kappa         - support potential
%   sigma_e       - linear-elastic computed von-Mises equivalent stress-range in MPa (hysteresis branch)
%   limiter       - (optional) switch to the limiter on or off
%                   (true/false)
%                   default = true
%   optimized     - (optional) if the limiter is true, Neubers rule and Glinkas rule are used to 
%                   limit the outputs otherwise the linear-stress or
%                   linear-strain corresponds to the limits
%                   default = true
%   conservative  - (optional) if the optimized limiter is used, shall the 
%                   upper limit conservatively estimated (true) or shall
%                   it be estimated using an more accurate but less safe
%                   approach?
%                   default = false
%
%Returns:
%   sigma_ANN     -  Estimated stress range MPa (hysteresis branch)
%   was_limited   -  flag which detects if the limiter was used
%
% created by: 
% ########################################################################
% # R. Wuthenow                                                          #
% #                                                                      #
% # Clausthal University of Technology                                   #
% # Institut f. Maschinelle Anlagentechnik u. Betriebsfestigkeit (IMAB)  #
% # Professor Dr.-Ing. A. Esderts                                        #
% ########################################################################
%
% Copyright 2023 Ralf Wuthenow
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%     http://www.apache.org/licenses/LICENSE-2.0
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

if(~exist('limiter','var'))
    limiter = true;
end

if(~exist('optimized','var'))
    optimized = true;
end

if(~exist('conservative','var'))
    conservative = false;
end

was_limited = false;

sigma_Glinka = Glinkas_rule(E,K_,n_,sigma_e);
sigma_ASME = linear_rule(E,K_,n_,sigma_e);

sigma_ANN = estimation_ANN([kappa,spagra,h,K_,n_,sigma_e,sigma_ASME]');

if(limiter)
    if (optimized)
        KappaKp = kappatransformer(kappa,conservative);
        Kappa_Neuber_sigma = Neubers_rule(E,K_,n_,KappaKp,sigma_e);
        if (sigma_ANN > Kappa_Neuber_sigma)
            sigma_ANN = Kappa_Neuber_sigma;
            was_limited = true;
        elseif (sigma_ANN < sigma_Glinka)
            sigma_ANN = sigma_Glinka;
            was_limited = true;
        end
    else
        if (sigma_ANN > sigma_e)
            sigma_ANN = sigma_e;
            was_limited = true;
        elseif (sigma_ANN < sigma_ASME)
            sigma_ANN = sigma_ASME;
            was_limited = true;
        end
    end  
end

end

