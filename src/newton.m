function [ x ] = newton( f, df, x, modus, tol )
%newton executes newton iteration with the function handles for function, 
%derivation and initial value.
%
%input parameter:
%   f       - function handle of function f(x)
%   df      - function handle of derivation of function f(x)
%   x       - initial value of iteration
%   modus   - Which criterion should be chosen for the termination of 
%             Newton's method
%             1 --> 10 steps (standard in FKM-guideline 
%             nonlinear, 2 --> abs(f(x)/df(x)) < tol
%             In mode 2, after every 5000 steps the tolerance value is 
%             is increased
%             3 --> abs(function value) < tol
%             4 --> (abs(function value) < tol) && (abs(function value
%             /derivative value) < tol)
% 
%output parameter:
%   x       - value that reached termination criterion
%
% version 2.0, 02/2022
%
% created by: 
% ########################################################################
% # R. Wuthenow, M. Waechter, A. Linn                                     #
% #                                                                      #
% # Clausthal University of Technology                                   #
% # Institut f. Maschinelle Anlagentechnik u. Betriebsfestigkeit (IMAB)  #
% # Professor Dr.-Ing. A. Esderts                                        #
% ########################################################################
%
% Copyright 2022 Ralf Wuthenow, Michael Waechter, Alexander Linn, Alfons 
% Esderts
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%     http://www.apache.org/licenses/LICENSE-2.0
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.    

if(~exist('tol','var'))
    tol = 1e-6;
end

switch modus
    case 1
        for i=1:1:10
            x = x - f(x)/df(x); 
        end
        
    case 2
        start_value = x;
        function_value = f(x);
        derivation_value = df(x);
        i = 0;  % counter
        while abs(function_value/derivation_value) > tol % Termination criterion step size approaches 0
           function_value = f(x);
           derivation_value = df(x);
           x = x - function_value/derivation_value;
           i = i + 1;
           if i > 5000
               if x > start_value
                  x = start_value; 
               end
               i = 0;
               tol = tol * 10;
                  
           end
           if (tol> 1.0e-2)
              error('Tolerance limit exceeded at Newton´s method'); 
           end
        end
    case 3
        start_value = x;
        function_value = f(x);
        derivation_value = df(x);
        i = 0; % counter
        while abs(function_value) > tol % Termination criterion function value close to 0
           function_value = f(x);
           derivation_value = df(x);
           x = x - function_value/derivation_value;
           i = i + 1;
           if i > 5000
               if x > start_value
                  x = start_value; 
               end
               i = 0;
               tol = tol * 10;
                  
           end
           if (tol> 1.0e-2)
              error('Tolerance limit exceeded at Newton´s method'); 
           end
        end   
    case 4
        start_value = x;
        function_value = f(x);
        derivation_value = df(x);
        i = 0; % counter
        while ((abs(function_value) > tol) && (abs(function_value/derivation_value) > tol))  % doubled termination criterion
            function_value = f(x);
            derivation_value = df(x);
            x = x - function_value/derivation_value;
            i = i + 1;
            if i > 5000
               if x > start_value
                  x = start_value; 
               end
               i = 0;
               tol = tol * 10;
                    
            end
            if (tol> 1.0e-2)
               error('Tolerance limit exceeded at Newton´s method'); 
            end
        end   
end
if(tol>1.0e-5)
    fprintf(sprintf('Newton performed with reduced accuracy %d \n', tol));
end
end
