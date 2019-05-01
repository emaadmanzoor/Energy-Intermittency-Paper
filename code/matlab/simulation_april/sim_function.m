function [ X ] = sim_function(v)
% ========================================================================
% SIM_FUNCTION finds the optimal quantity of X_1 given a multiplier for 
% the output efficiency of solar and a tax rate on coal
% ========================================================================
% INPUT ARGUMENTS:
%   v             (matrx)  the first entry is the multiplier on the output
%                          efficiency of solar and the second entry is the 
%                          tax rate
% ========================================================================

alpha = [0.6, 0.4];
xi_1  = [1, 1];
xi_2  = [1, 0.1]*v(1);

sigma = 0.5;
phi   = (sigma - 1)/sigma;
budget = 1;

x_1_cost_param = 104.3*v(2);
x_2_cost_param = 50;

% Prices
xi_mat   = [xi_1; xi_2];
cost_mat = [x_1_cost_param; x_2_cost_param];
prices   = xi_mat\cost_mat;

% Price Index
P = ((1/2) * (prices'.^(1-sigma))*(alpha'.^sigma)).^(1/(1-sigma));

if sigma == 1
    P = 1;
end
        

% Quantities
Y = ((alpha'./prices).^(sigma)) * (budget/P);
X = (xi_mat')\Y;


end