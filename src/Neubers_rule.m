function [ sigma ] = Neubers_rule( E, K_, n_, K_p, sigma_e)
% notch_root_approximation function for execution of a notch root
%approximation according to the extended version of Neubers rule 
% [ sigma ] = Neubers_rule( E, K_, n_, K_p, sigma_e)
%
%Parameter:
%   E           - Young's modulus in MPa 
%   K_          - cyclic hardening coefficient K'
%   n_          - cyclic hardening exponent n'
%   K_p         - limit load factor
%   sigma_e     - linear elastic stress in MPa
%
%Returns:
%   sigma       - notch root stress range in MPa
%
% created by: 
% ########################################################################
% # R. Wuthenow, M. Waechter                                              #
% #                                                                      #
% # Clausthal University of Technology                                   #
% # Institut f. Maschinelle Anlagentechnik u. Betriebsfestigkeit (IMAB)  #
% # Professor Dr.-Ing. A. Esderts                                        #
% ########################################################################
%
% Copyright 2022 Ralf Wuthenow, Michael Waechter, Alfons Esderts
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%     http://www.apache.org/licenses/LICENSE-2.0
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

    f           = @(sigma) sigma^2+2*E*((2*K_)^(-1/n_))*sigma^(1/n_+1)-(sigma_e)^2-K_p/(K_p^(1/n_))*2*E/((2*K_)^(1/n_))*sigma_e^(1/n_+1);
    df          = @(sigma) 2*sigma+2*E*((2*K_)^(-1/n_))*(1/n_+1)*sigma^(1/n_);
    sigma       = newton(f,df,sigma_e,3,1e-6);

end