function [K_p] = kappatransformer(kappa,conservative)
% Function to predict the limit load factor K_p using the 
% support potential kappa 
%
%[K_p] = kappatransformer(kappa,konservativ)
%
%Parameter:
%   kappa        - support potential  
%   conservative - use the conservative prediction method?
%   (true/false)
%
%Returns:
%   K_p         - predicted limit load factor K_p
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


    if(~exist('conservative','var'))
        conservative = false;
    end
    
    if (conservative)
        K_p = max([1./(2*kappa),min([1./kappa,1.6])]);
    else
        K_p = 1/kappa;
    end 

end

